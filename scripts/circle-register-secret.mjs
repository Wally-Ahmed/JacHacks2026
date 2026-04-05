import fs from "node:fs";
import path from "node:path";
import crypto from "node:crypto";
import { registerEntitySecretCiphertext } from "@circle-fin/developer-controlled-wallets";

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

if (!apiKey) {
  throw new Error("Missing CIRCLE_API_KEY or WALLET_PROVIDER_API_KEY in .env");
}

const outputDir = path.join(process.cwd(), "circle-recovery");
fs.mkdirSync(outputDir, { recursive: true });

const entitySecret = crypto.randomBytes(32).toString("hex");

const response = await registerEntitySecretCiphertext({
  apiKey,
  entitySecret,
  recoveryFileDownloadPath: outputDir,
});

console.log(JSON.stringify({
  entitySecret,
  recoveryFile: response?.data?.recoveryFile || null,
  recoveryDir: outputDir,
}, null, 2));
