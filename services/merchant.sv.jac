import from datetime { datetime }

node Merchant {
    has merchant_id: str = "";
    has legal_name: str = "";
    has display_name: str = "";
    has email: str = "";
    has status: str = "active";
    has default_chain: str = "base";
    has default_asset: str = "USDC";
    has created_at: str = "";
    has updated_at: str = "";

    def postinit {
        now = datetime.now().isoformat();
        if not self.created_at { self.created_at = now; }
        if not self.updated_at { self.updated_at = now; }
    }
}

node MerchantWallet {
    has wallet_id: str = "";
    has address: str = "";
    has chain: str = "base";
    has asset: str = "USDC";
    has label: str = "primary";
    has verified: bool = False;
    has is_default: bool = True;
    has status: str = "active";
    has created_at: str = "";

    def postinit {
        if not self.created_at {
            self.created_at = datetime.now().isoformat();
        }
    }
}

def find_merchant(merchant_id: str) -> Merchant {
    for merchant in [root()-->][?:Merchant] {
        if merchant.merchant_id == merchant_id or jid(merchant) == merchant_id {
            return merchant;
        }
    }
}

def:pub create_merchant(name: str, email: str) -> Merchant {
    merchant = (root() ++> Merchant(
        merchant_id="merchant_" + str(len([root()-->][?:Merchant]) + 1),
        legal_name=name,
        display_name=name,
        email=email,
    ))[0];
    return merchant;
}

def:pub get_merchant(merchant_id: str) -> Merchant {
    return find_merchant(merchant_id);
}

def:pub list_merchants() -> list[Merchant] {
    return [root()-->][?:Merchant];
}

def:pub add_merchant_wallet(merchant_id: str, address: str, chain: str = "base", asset: str = "USDC") -> MerchantWallet {
    merchant = find_merchant(merchant_id);
    wallet = (merchant ++> MerchantWallet(
        wallet_id="wallet_" + str(len([merchant-->][?:MerchantWallet]) + 1),
        address=address,
        chain=chain,
        asset=asset,
        verified=False,
        is_default=len([merchant-->][?:MerchantWallet]) == 0,
    ))[0];
    return wallet;
}

def:pub list_merchant_wallets(merchant_id: str) -> list[MerchantWallet] {
    merchant = find_merchant(merchant_id);
    return [merchant-->][?:MerchantWallet];
}
