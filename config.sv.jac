import from datetime { datetime }

node IntegrationConfig {
    has config_id: str = "";
    has provider: str = "";
    has label: str = "";
    has api_key: str = "";
    has secret_key: str = "";
    has webhook_secret: str = "";
    has rpc_url: str = "";
    has treasury_wallet: str = "";
    has usdc_contract: str = "";
    has chain_id: str = "";
    has enabled: bool = True;
    has mode: str = "test";
    has updated_at: str = "";

    def postinit {
        if not self.updated_at {
            self.updated_at = datetime.now().isoformat();
        }
    }
}

def ensure_config(provider: str, label: str, api_key: str = "", secret_key: str = "", webhook_secret: str = "", rpc_url: str = "", treasury_wallet: str = "", usdc_contract: str = "", chain_id: str = "8453", mode: str = "test") -> IntegrationConfig {
    for cfg in [root()-->][?:IntegrationConfig] {
        if cfg.provider == provider {
            return cfg;
        }
    }
    return (root() ++> IntegrationConfig(
        config_id=provider + "_config",
        provider=provider,
        label=label,
        api_key=api_key,
        secret_key=secret_key,
        webhook_secret=webhook_secret,
        rpc_url=rpc_url,
        treasury_wallet=treasury_wallet,
        usdc_contract=usdc_contract,
        chain_id=chain_id,
        mode=mode,
    ))[0];
}

def:pub seed_demo_config() -> list[IntegrationConfig] {
    stripe = ensure_config(
        provider="stripe",
        label="Stripe Checkout",
        api_key="pk_test_FILL_ME_STRIPE_PUBLISHABLE_KEY",
        secret_key="sk_test_FILL_ME_STRIPE_SECRET_KEY",
        webhook_secret="whsec_FILL_ME_STRIPE_WEBHOOK_SECRET",
        mode="test",
    );
    wallets = ensure_config(
        provider="wallet_provider",
        label="Wallet Provider",
        api_key="FILL_ME_WALLET_PROVIDER_API_KEY",
        secret_key="FILL_ME_WALLET_PROVIDER_SECRET",
        treasury_wallet="0xFILL_ME_TREASURY_WALLET",
        mode="test",
    );
    rpc = ensure_config(
        provider="rpc",
        label="Base RPC",
        rpc_url="https://FILL_ME_RPC_URL",
        usdc_contract="0xFILL_ME_USDC_CONTRACT",
        chain_id="8453",
        mode="test",
    );
    return [stripe, wallets, rpc];
}

def:pub list_configs() -> list[IntegrationConfig] {
    return [root()-->][?:IntegrationConfig];
}
