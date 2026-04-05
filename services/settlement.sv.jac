import from datetime { datetime }

edge Owns {}
edge HasInvoice {}
edge UsesWallet {}
edge SettlesTo {}
edge HasPayout {}
edge HasConfig {}

node Merchant {
    has name: str = "";
    has email: str = "";
    has status: str = "active";
    has created_at: str = "";

    def postinit {
        if not self.created_at {
            self.created_at = datetime.now().isoformat();
        }
    }
}

node MerchantWallet {
    has chain: str = "base";
    has address: str = "";
    has label: str = "Primary settlement wallet";
    has created_at: str = "";

    def postinit {
        if not self.created_at {
            self.created_at = datetime.now().isoformat();
        }
    }
}

node InvoiceWallet {
    has provider: str = "turnkey";
    has wallet_ref: str = "";
    has address: str = "";
    has chain: str = "base";
    has status: str = "ready";
    has spend_limit_usdc: float = 0.0;
    has expires_at: str = "";
    has created_at: str = "";

    def postinit {
        if not self.created_at {
            self.created_at = datetime.now().isoformat();
        }
    }
}

node Invoice {
    has reference: str = "";
    has fiat_amount: float = 0.0;
    has fiat_currency: str = "USD";
    has target_usdc: float = 0.0;
    has destination_wallet: str = "";
    has chain: str = "base";
    has status: str = "checkout_created";
    has stripe_checkout_url: str = "";
    has stripe_session_id: str = "";
    has created_at: str = "";

    def postinit {
        if not self.created_at {
            self.created_at = datetime.now().isoformat();
        }
    }
}

node Payout {
    has amount_usdc: float = 0.0;
    has destination_wallet: str = "";
    has tx_hash: str = "pending-demo-hash";
    has status: str = "pending";
    has created_at: str = "";

    def postinit {
        if not self.created_at {
            self.created_at = datetime.now().isoformat();
        }
    }
}

node IntegrationConfig {
    has stripe_publishable_key: str = "pk_test_FILL_ME_STRIPE_PUBLISHABLE_KEY";
    has stripe_secret_key: str = "sk_test_FILL_ME_STRIPE_SECRET_KEY";
    has stripe_webhook_secret: str = "whsec_FILL_ME_STRIPE_WEBHOOK_SECRET";
    has wallet_provider: str = "turnkey";
    has wallet_api_public_key: str = "FILL_ME_WALLET_PROVIDER_PUBLIC_KEY";
    has wallet_api_private_key: str = "FILL_ME_WALLET_PROVIDER_PRIVATE_KEY";
    has usdc_treasury_wallet: str = "0xFILL_ME_TREASURY_WALLET";
    has rpc_url: str = "https://FILL_ME_RPC_URL";
    has created_at: str = "";

    def postinit {
        if not self.created_at {
            self.created_at = datetime.now().isoformat();
        }
    }
}

def ensure_seed_data() -> dict {
    merchants = [root()-->][?:Merchant];
    if len(merchants) == 0 {
        merchant = (root() ++> Merchant(name="Demo Merchant", email="ops@demo-merchant.com"))[0];
        wallet = (merchant ++> Owns() ++> MerchantWallet(address="0x9fA1DemoMerchantWallet0000000000000000000001"))[0];
        invoice = (merchant ++> HasInvoice() ++> Invoice(
            reference="INV-1001",
            fiat_amount=500.0,
            target_usdc=500.0,
            destination_wallet=wallet.address,
            stripe_checkout_url="https://checkout.stripe.com/pay/FILL_ME_SESSION",
            stripe_session_id="cs_test_FILL_ME_SESSION"
        ))[0];
        invoice_wallet = (invoice ++> UsesWallet() ++> InvoiceWallet(
            wallet_ref="wallet_demo_1001",
            address="0x7bC2InvoiceWallet000000000000000000000001",
            spend_limit_usdc=500.0,
            expires_at="2026-12-31T23:59:59"
        ))[0];
        invoice ++> SettlesTo() ++> wallet;
        invoice ++> HasPayout() ++> Payout(
            amount_usdc=500.0,
            destination_wallet=wallet.address,
            status="queued"
        );
        root() ++> HasConfig() ++> IntegrationConfig();
        return {"seeded": True, "merchant_id": jid(merchant), "invoice_id": jid(invoice), "invoice_wallet_id": jid(invoice_wallet)};
    }
    return {"seeded": False};
}

def:pub bootstrap_demo() -> dict {
    return ensure_seed_data();
}

def:pub get_dashboard() -> dict {
    ensure_seed_data();
    merchants = [root()-->][?:Merchant];
    invoices = [root()-->][?:Invoice];
    invoice_wallets = [root()-->][?:InvoiceWallet];
    payouts = [root()-->][?:Payout];
    config = [root()-->][?:IntegrationConfig];

    merchant_cards = [
        {
            "id": jid(m),
            "name": m.name,
            "email": m.email,
            "status": m.status,
            "wallets": [
                {
                    "id": jid(w),
                    "address": w.address,
                    "chain": w.chain,
                    "label": w.label
                }
                for w in [m-->][?:MerchantWallet]
            ]
        }
        for m in merchants
    ];

    invoice_cards = [
        {
            "id": jid(i),
            "reference": i.reference,
            "fiat_amount": i.fiat_amount,
            "fiat_currency": i.fiat_currency,
            "target_usdc": i.target_usdc,
            "destination_wallet": i.destination_wallet,
            "chain": i.chain,
            "status": i.status,
            "stripe_checkout_url": i.stripe_checkout_url,
            "stripe_session_id": i.stripe_session_id,
            "invoice_wallets": [
                {
                    "id": jid(w),
                    "provider": w.provider,
                    "wallet_ref": w.wallet_ref,
                    "address": w.address,
                    "status": w.status,
                    "spend_limit_usdc": w.spend_limit_usdc,
                    "expires_at": w.expires_at
                }
                for w in [i-->][?:InvoiceWallet]
            ],
            "payouts": [
                {
                    "id": jid(p),
                    "amount_usdc": p.amount_usdc,
                    "destination_wallet": p.destination_wallet,
                    "tx_hash": p.tx_hash,
                    "status": p.status
                }
                for p in [i-->][?:Payout]
            ]
        }
        for i in invoices
    ];

    config_card = {};
    if len(config) > 0 {
        cfg = config[0];
        config_card = {
            "stripe_publishable_key": cfg.stripe_publishable_key,
            "stripe_secret_key": cfg.stripe_secret_key,
            "stripe_webhook_secret": cfg.stripe_webhook_secret,
            "wallet_provider": cfg.wallet_provider,
            "wallet_api_public_key": cfg.wallet_api_public_key,
            "wallet_api_private_key": cfg.wallet_api_private_key,
            "usdc_treasury_wallet": cfg.usdc_treasury_wallet,
            "rpc_url": cfg.rpc_url
        };
    }

    return {
        "summary": {
            "merchant_count": len(merchants),
            "invoice_count": len(invoices),
            "invoice_wallet_count": len(invoice_wallets),
            "payout_count": len(payouts)
        },
        "merchants": merchant_cards,
        "invoices": invoice_cards,
        "config": config_card,
        "routes": [
            "POST /v1/merchants",
            "POST /v1/invoices",
            "GET /v1/dashboard",
            "GET /v1/invoices/:id",
            "POST /v1/webhooks/stripe",
            "POST /v1/payouts/:id/retry"
        ]
    };
}

def:pub create_merchant(name: str, email: str, wallet_address: str, chain: str = "base") -> dict {
    ensure_seed_data();
    merchant = (root() ++> Merchant(name=name, email=email))[0];
    wallet = (merchant ++> Owns() ++> MerchantWallet(address=wallet_address, chain=chain))[0];
    return {
        "merchant_id": jid(merchant),
        "wallet_id": jid(wallet),
        "name": merchant.name,
        "email": merchant.email,
        "wallet_address": wallet.address,
        "chain": wallet.chain
    };
}

def:pub create_invoice(merchant_id: str, reference: str, fiat_amount: float, target_usdc: float, destination_wallet: str, chain: str = "base") -> dict {
    ensure_seed_data();
    for merchant in [root()-->][?:Merchant] {
        if jid(merchant) == merchant_id {
            invoice = (merchant ++> HasInvoice() ++> Invoice(
                reference=reference,
                fiat_amount=fiat_amount,
                target_usdc=target_usdc,
                destination_wallet=destination_wallet,
                chain=chain,
                stripe_checkout_url="https://checkout.stripe.com/pay/FILL_ME_NEW_SESSION",
                stripe_session_id="cs_test_FILL_ME_NEW_SESSION"
            ))[0];
            invoice_wallet = (invoice ++> UsesWallet() ++> InvoiceWallet(
                wallet_ref="wallet_" + reference,
                address="0xFILLME" + reference,
                chain=chain,
                spend_limit_usdc=target_usdc,
                expires_at="2026-12-31T23:59:59"
            ))[0];
            invoice ++> HasPayout() ++> Payout(
                amount_usdc=target_usdc,
                destination_wallet=destination_wallet,
                status="queued"
            );
            return {
                "invoice_id": jid(invoice),
                "invoice_wallet_id": jid(invoice_wallet),
                "reference": invoice.reference,
                "status": invoice.status,
                "stripe_checkout_url": invoice.stripe_checkout_url
            };
        }
    }
    return {"error": "merchant not found"};
}

def:pub get_invoice(invoice_id: str) -> dict {
    ensure_seed_data();
    for invoice in [root()-->][?:Invoice] {
        if jid(invoice) == invoice_id {
            return {
                "id": jid(invoice),
                "reference": invoice.reference,
                "fiat_amount": invoice.fiat_amount,
                "fiat_currency": invoice.fiat_currency,
                "target_usdc": invoice.target_usdc,
                "destination_wallet": invoice.destination_wallet,
                "chain": invoice.chain,
                "status": invoice.status,
                "stripe_checkout_url": invoice.stripe_checkout_url,
                "invoice_wallets": [
                    {
                        "id": jid(w),
                        "address": w.address,
                        "provider": w.provider,
                        "status": w.status,
                        "spend_limit_usdc": w.spend_limit_usdc
                    }
                    for w in [invoice-->][?:InvoiceWallet]
                ],
                "payouts": [
                    {
                        "id": jid(p),
                        "amount_usdc": p.amount_usdc,
                        "destination_wallet": p.destination_wallet,
                        "tx_hash": p.tx_hash,
                        "status": p.status
                    }
                    for p in [invoice-->][?:Payout]
                ]
            };
        }
    }
    return {"error": "invoice not found"};
}

def:pub mark_invoice_paid(invoice_id: str) -> dict {
    ensure_seed_data();
    for invoice in [root()-->][?:Invoice] {
        if jid(invoice) == invoice_id {
            invoice.status = "payment_succeeded";
            for payout in [invoice-->][?:Payout] {
                payout.status = "broadcast_ready";
            }
            return {"invoice_id": jid(invoice), "status": invoice.status};
        }
    }
    return {"error": "invoice not found"};
}

def:pub retry_payout(payout_id: str) -> dict {
    ensure_seed_data();
    for payout in [root()-->][?:Payout] {
        if jid(payout) == payout_id {
            payout.status = "queued";
            payout.tx_hash = "0xFILL_ME_RETRY_TX_HASH";
            return {"payout_id": jid(payout), "status": payout.status, "tx_hash": payout.tx_hash};
        }
    }
    return {"error": "payout not found"};
}
