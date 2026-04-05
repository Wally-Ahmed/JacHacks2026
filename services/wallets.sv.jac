import from datetime { datetime, timedelta }
import from ..nodes.InvoiceWallet { InvoiceWallet }
import from ..nodes.Invoice { Invoice }
import from .invoice { find_invoice }

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
