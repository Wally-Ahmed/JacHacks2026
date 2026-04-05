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

const apiKey = process.env.CIRCLE_API_KEY || process.env.WALLET_PROVIDER_API_KEY;
const entitySecret = process.env.CIRCLE_ENTITY_SECRET || "ee73e6601fa3b4444cd68e62f9912262743b041b02b503c6e68dc48178f9a047";
const walletSetName = process.env.CIRCLE_WALLET_SET_NAME || "UNIBANK Wallet Set";

if (!apiKey) {
  throw new Error("Missing CIRCLE_API_KEY or WALLET_PROVIDER_API_KEY in .env");
}

if (!entitySecret) {
  throw new Error("Missing CIRCLE_ENTITY_SECRET in .env");
}

const client = initiateDeveloperControlledWalletsClient({
  apiKey,
  entitySecret,
});

const response = await client.createWalletSet({
  name: walletSetName,
});

console.log(JSON.stringify({
  walletSetId: response?.data?.walletSet?.id || null,
  walletSetName: response?.data?.walletSet?.name || walletSetName,
  raw: response?.data?.walletSet || null,
}, null, 2));
