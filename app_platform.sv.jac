import from datetime { datetime }
import os;
import from .config { IntegrationConfig, seed_demo_config }

node Platform {
    has platform_id: str = "platform";
    has name: str = "";
    has environment: str = "";
    has default_chain: str = "";
    has default_asset: str = "";
    has status: str = "active";
    has created_at: str = "";

    def postinit {
        if not self.name {
            self.name = os.getenv("PLATFORM_NAME") or "FILL_ME_PLATFORM_NAME";
        }
        if not self.environment {
            self.environment = os.getenv("APP_ENV") or "dev";
        }
        if not self.default_chain {
            self.default_chain = os.getenv("DEFAULT_CHAIN") or "base";
        }
        if not self.default_asset {
            self.default_asset = os.getenv("DEFAULT_ASSET") or "USDC";
        }
        if not self.created_at {
            self.created_at = datetime.now().isoformat();
        }
    }
}

def get_platform_node() -> Platform {
    for item in [root()-->][?:Platform] {
        item.name = os.getenv("PLATFORM_NAME") or item.name or "FILL_ME_PLATFORM_NAME";
        item.environment = os.getenv("APP_ENV") or item.environment or "dev";
        item.default_chain = os.getenv("DEFAULT_CHAIN") or item.default_chain or "base";
        item.default_asset = os.getenv("DEFAULT_ASSET") or item.default_asset or "USDC";
        return item;
    }
    return (root() ++> Platform())[0];
}

def:pub bootstrap_platform() -> dict {
    platform = get_platform_node();
    configs = seed_demo_config();
    return {
        "platform_id": jid(platform),
        "name": platform.name,
        "environment": platform.environment,
        "default_chain": platform.default_chain,
        "default_asset": platform.default_asset,
        "config_count": len(configs),
        "env_keys": {
            "platform_name": "PLATFORM_NAME",
            "app_env": "APP_ENV",
            "app_mode": "APP_MODE",
            "default_chain": "DEFAULT_CHAIN",
            "default_asset": "DEFAULT_ASSET",
            "stripe_publishable_key": "STRIPE_PUBLISHABLE_KEY",
            "stripe_secret_key": "STRIPE_SECRET_KEY",
            "stripe_webhook_secret": "STRIPE_WEBHOOK_SECRET",
            "wallet_provider_name": "WALLET_PROVIDER_NAME",
            "wallet_provider_api_key": "WALLET_PROVIDER_API_KEY",
            "wallet_provider_secret": "WALLET_PROVIDER_SECRET",
            "treasury_wallet": "TREASURY_WALLET",
            "rpc_url": "RPC_URL",
            "usdc_contract": "USDC_CONTRACT",
            "chain_id": "CHAIN_ID"
        }
    };
}

def:pub get_platform_overview() -> dict {
    platform = get_platform_node();
    return {
        "platform_id": jid(platform),
        "name": platform.name,
        "environment": platform.environment,
        "default_chain": platform.default_chain,
        "default_asset": platform.default_asset,
        "merchant_count": len([root()-->]),
    };
}
