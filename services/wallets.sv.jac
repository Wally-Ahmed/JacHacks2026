import from datetime { datetime, timedelta }
import from .invoice { Invoice, find_invoice }

node InvoiceWallet {
    has invoice_wallet_id: str = "";
    has provider: str = "wallet_provider";
    has provider_wallet_id: str = "";
    has address: str = "";
    has chain: str = "base";
    has asset: str = "USDC";
    has status: str = "created";
    has allowed_destination: str = "";
    has spend_limit: float = 0.0;
    has gas_limit: float = 0.005;
    has expires_at: str = "";
    has retired_at: str = "";
    has created_at: str = "";

    def postinit {
        if not self.created_at {
            self.created_at = datetime.now().isoformat();
        }
        if not self.expires_at {
            self.expires_at = (datetime.now() + timedelta(hours=2)).isoformat();
        }
    }
}

def find_invoice_wallet(invoice: Invoice) -> InvoiceWallet {
    for wallet in [invoice-->][?:InvoiceWallet] {
        return wallet;
    }
}

def:pub create_invoice_wallet(invoice_id: str) -> InvoiceWallet {
    invoice = find_invoice(invoice_id);
    existing = find_invoice_wallet(invoice);
    if existing {
        return existing;
    }
    wallet = (invoice ++> InvoiceWallet(
        invoice_wallet_id="invoice_wallet_" + invoice.invoice_id,
        provider_wallet_id="provider_wallet_FILL_ME_" + invoice.invoice_id,
        address="0xFILL_ME_INVOICE_WALLET_" + invoice.invoice_id,
        chain=invoice.target_chain,
        allowed_destination=invoice.destination_address,
        spend_limit=invoice.quoted_asset_amount,
        status="ready",
    ))[0];
    invoice.status = "wallet_created";
    invoice.updated_at = datetime.now().isoformat();
    return wallet;
}

def:pub get_invoice_wallet(invoice_id: str) -> InvoiceWallet {
    invoice = find_invoice(invoice_id);
    return find_invoice_wallet(invoice);
}

def:pub retire_invoice_wallet(invoice_id: str) -> InvoiceWallet {
    invoice = find_invoice(invoice_id);
    wallet = find_invoice_wallet(invoice);
    wallet.status = "retired";
    wallet.retired_at = datetime.now().isoformat();
    return wallet;
}
