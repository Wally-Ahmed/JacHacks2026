import fs from "node:fs";
import path from "node:path";
import crypto from "node:crypto";
import { initiateDeveloperControlledWalletsClient } from "@circle-fin/developer-controlled-wallets";

const envPath = path.join(process.cwd(), ".env");
if (fs.existsSync(envPath)) {
  const envText = fs.readFileSync(envPath, "utf8");
  for (const line of envText.split(/\r?\n/)) {
    const trimmed = line.trim();
    if (!trimmed || trimmed.startsWith("#") || !trimmed.includes("=")) {
      continue;
    }
    const idx = trimmed.indexOf("=");
    const key = trimmed.slice(0, idx).trim();
    let value = trimmed.slice(idx + 1).trim();
    if (
      (value.startsWith("\"") && value.endsWith("\"")) ||
      (value.startsWith("'") && value.endsWith("'"))
    ) {
      value = value.slice(1, -1);
    }
    if (!(key in process.env)) {
      process.env[key] = value;
    }
  }
}

const [,, destinationArg, amountArg] = process.argv;

const apiKey = process.env.CIRCLE_API_KEY || process.env.WALLET_PROVIDER_API_KEY;
const entitySecret = process.env.CIRCLE_ENTITY_SECRET;
const sourceWalletAddress = process.env.PLACEHOLDER_SOURCE_ADDRESS;
const blockchain = process.env.PLACEHOLDER_SOURCE_BLOCKCHAIN || process.env.CIRCLE_BLOCKCHAIN || "BASE-SEPOLIA";
const tokenAddress = process.env.PLACEHOLDER_SOURCE_TOKEN_ADDRESS || process.env.USDC_CONTRACT;

if (!apiKey) {
  throw new Error("Missing CIRCLE_API_KEY or WALLET_PROVIDER_API_KEY in .env");
}
if (!entitySecret) {
  throw new Error("Missing CIRCLE_ENTITY_SECRET in .env");
}
if (!sourceWalletAddress) {
  throw new Error("Missing PLACEHOLDER_SOURCE_ADDRESS in .env");
}
if (!tokenAddress) {
  throw new Error("Missing PLACEHOLDER_SOURCE_TOKEN_ADDRESS or USDC_CONTRACT in .env");
}
if (!destinationArg) {
  throw new Error("Missing destination argument");
}
if (!amountArg) {
  throw new Error("Missing amount argument");
}

try {
  const client = initiateDeveloperControlledWalletsClient({
    apiKey,
    entitySecret,
  });

  const response = await client.createTransaction({
    amount: [String(amountArg)],
    destinationAddress: destinationArg,
    walletAddress: sourceWalletAddress,
    tokenAddress,
    blockchain,
    fee: {
      type: "level",
      config: {
        feeLevel: "MEDIUM",
      },
    },
    idempotencyKey: crypto.randomUUID(),
  });

  const transaction = response?.data?.transaction;
  if (!transaction) {
    throw new Error("Circle transaction creation returned no transaction");
  }

  console.log(JSON.stringify({
    source_wallet_address: sourceWalletAddress,
    transaction_id: transaction.id || null,
    tx_hash: transaction.txHash || transaction.transactionHash || "",
    state: transaction.state || transaction.status || null,
    destination: destinationArg,
    amount: amountArg,
    blockchain,
    token_address: tokenAddress,
  }, null, 2));
} catch (error) {
  const payload = {
    message: error?.message || "Unknown Circle send error",
    code: error?.code || null,
    status: error?.status || error?.response?.status || null,
    response: error?.response?.data || null,
  };
  console.error(JSON.stringify(payload, null, 2));
  process.exit(1);
}
