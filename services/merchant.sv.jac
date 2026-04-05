import os;
import from uuid { uuid4 }
import from dotenv { load_dotenv }
import from json { loads }
import from subprocess { run }
import from nodes.Merchant { Merchant }
import from nodes.MerchantWallet { MerchantWallet }

def find_merchant(merchant_id: str) -> Merchant {
    for merchant in [root()-->][?:Merchant] {
        if merchant.merchant_id == merchant_id or jid(merchant) == merchant_id {
            return merchant;
        }
    }
}

def find_merchant_wallet(wallet_id: str) -> MerchantWallet {
    for merchant in [root()-->][?:Merchant] {
        for wallet in [merchant-->][?:MerchantWallet] {
            if wallet.wallet_id == wallet_id or jid(wallet) == wallet_id {
                return wallet;
            }
        }
    }
}

def find_wallet_merchant(wallet_id: str) -> Merchant {
    for merchant in [root()-->][?:Merchant] {
        for wallet in [merchant-->][?:MerchantWallet] {
            if wallet.wallet_id == wallet_id or jid(wallet) == wallet_id {
                return merchant;
            }
        }
    }
}

def env_required(name: str) -> str {
    load_dotenv();
    value = os.getenv(name);
    if not value {
        raise Exception("Missing required environment variable: " + name);
    }
    return value;
}

def circle_blockchain_for(chain: str) -> str {
    load_dotenv();
    lowered = chain.lower();
    if lowered == "base" {
        return os.getenv("CIRCLE_BLOCKCHAIN", "BASE-SEPOLIA");
    }
    if lowered == "ethereum" or lowered == "eth" {
        return "ETH-SEPOLIA";
    }
    if lowered == "polygon" or lowered == "matic" {
        return "MATIC-AMOY";
    }
    return os.getenv("CIRCLE_BLOCKCHAIN", "BASE-SEPOLIA");
}

def create_circle_merchant_wallet(merchant: Merchant, chain: str, label: str) -> dict {
    env_required("CIRCLE_ENTITY_SECRET");
    env_required("CIRCLE_WALLET_SET_ID");

    result = run(
        [
            "node",
            "scripts/circle-create-wallet.mjs",
            circle_blockchain_for(chain),
            merchant.display_name + " " + label,
            merchant.merchant_id + "_" + label + "_" + str(uuid4()),
        ],
        cwd=os.getcwd(),
        capture_output=True,
        text=True,
    );
    if result.returncode != 0 {
        raise Exception("Circle wallet creation failed: " + result.stderr);
    }
    return loads(result.stdout);
}

def:priv create_merchant(legal_name: str, email: str, display_name: str = "") -> Merchant {
    resolved_display_name = display_name;
    if not resolved_display_name {
        resolved_display_name = legal_name;
    }
    merchant = (root() ++> Merchant(
        merchant_id="merchant_" + str(len([root()-->][?:Merchant]) + 1),
        legal_name=legal_name,
        display_name=resolved_display_name,
        email=email,
    ))[0];
    return merchant;
}

def:priv get_merchant(merchant_id: str) -> Merchant {
    return find_merchant(merchant_id);
}

def:priv list_merchants() -> list[Merchant] {
    return [root()-->][?:Merchant];
}

def:priv add_merchant_wallet(merchant_id: str, chain: str = "base", asset: str = "USDC", label: str = "primary") -> MerchantWallet {
    print("add_merchant_wallet service start", merchant_id, chain, asset, label);
    merchant = find_merchant(merchant_id);
    if not merchant {
        raise Exception("Merchant not found: " + merchant_id);
    }
    print("merchant found", merchant.display_name, merchant.email);
    circle_wallet = create_circle_merchant_wallet(merchant, chain, label);
    print("circle wallet created", circle_wallet["wallet_id"], circle_wallet["address"]);
    wallet = (merchant ++> MerchantWallet(
        wallet_id="wallet_" + str(len([merchant-->][?:MerchantWallet]) + 1),
        address=circle_wallet["address"],
        chain=chain,
        asset=asset,
        label=label,
        verified=True,
        is_default=len([merchant-->][?:MerchantWallet]) == 0,
    ))[0];
    print("merchant wallet node created", wallet.wallet_id, wallet.address);
    return wallet;
}

def:priv list_merchant_wallets(merchant_id: str) -> list[MerchantWallet] {
    merchant = find_merchant(merchant_id);
    return [merchant-->][?:MerchantWallet];
}

def:priv delete_merchant_wallet(merchant_id: str, wallet_id: str) -> dict {
    merchant = find_merchant(merchant_id);
    wallets = [merchant-->][?:MerchantWallet];
    deleted_default = False;

    for wallet in wallets {
        if wallet.wallet_id == wallet_id or jid(wallet) == wallet_id {
            deleted_default = wallet.is_default;
            del wallet;
            break;
        }
    }

    remaining = [merchant-->][?:MerchantWallet];
    if deleted_default and len(remaining) > 0 {
        remaining[0].is_default = True;
    }

    return {"deleted": wallet_id};
}
