import fs from "node:fs";
import path from "node:path";
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

const [,, blockchainArg, labelArg, refIdArg] = process.argv;

const apiKey = process.env.CIRCLE_API_KEY || process.env.WALLET_PROVIDER_API_KEY;
const entitySecret = process.env.CIRCLE_ENTITY_SECRET;
const walletSetId = process.env.CIRCLE_WALLET_SET_ID;

if (!apiKey) {
  throw new Error("Missing CIRCLE_API_KEY or WALLET_PROVIDER_API_KEY in .env");
}
if (!entitySecret) {
  throw new Error("Missing CIRCLE_ENTITY_SECRET in .env");
}
if (!walletSetId) {
  throw new Error("Missing CIRCLE_WALLET_SET_ID in .env");
}
if (!blockchainArg) {
  throw new Error("Missing blockchain argument");
}

const client = initiateDeveloperControlledWalletsClient({
  apiKey,
  entitySecret,
});

const response = await client.createWallets({
  accountType: "EOA",
  blockchains: [blockchainArg],
  count: 1,
  walletSetId,
  metadata: [{
    name: labelArg || "Wallet",
    refId: refIdArg || `ref_${Date.now()}`,
  }],
});

const wallet = response?.data?.wallets?.[0];
if (!wallet) {
  throw new Error("Circle wallet creation returned no wallets");
}

console.log(JSON.stringify({
  wallet_id: wallet.id || null,
  wallet_set_id: wallet.walletSetId || wallet.walletSetID || walletSetId,
  address: wallet.address || null,
  blockchain: wallet.blockchain || blockchainArg,
  state: wallet.state || null,
  custody_type: wallet.custodyType || "DEVELOPER",
  ref_id: wallet.refId || refIdArg || null,
}, null, 2));
