import from datetime { datetime }
import from .config { IntegrationConfig, seed_demo_config }

node Platform {
    has platform_id: str = "platform";
    has name: str = "FILL_ME_PLATFORM_NAME";
    has environment: str = "dev";
    has default_chain: str = "base";
    has default_asset: str = "USDC";
    has status: str = "active";
    has created_at: str = "";

    def postinit {
        if not self.created_at {
            self.created_at = datetime.now().isoformat();
        }
    }
}

def get_platform_node() -> Platform {
    for item in [root()-->][?:Platform] {
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
        "fill_in": {
            "platform_name": "FILL_ME_PLATFORM_NAME",
            "stripe_publishable_key": "pk_test_FILL_ME_STRIPE_PUBLISHABLE_KEY",
            "stripe_secret_key": "sk_test_FILL_ME_STRIPE_SECRET_KEY",
            "stripe_webhook_secret": "whsec_FILL_ME_STRIPE_WEBHOOK_SECRET",
            "wallet_provider_api_key": "FILL_ME_WALLET_PROVIDER_API_KEY",
            "wallet_provider_secret": "FILL_ME_WALLET_PROVIDER_SECRET",
            "treasury_wallet": "0xFILL_ME_TREASURY_WALLET",
            "rpc_url": "https://FILL_ME_RPC_URL",
            "usdc_contract": "0xFILL_ME_USDC_CONTRACT"
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
