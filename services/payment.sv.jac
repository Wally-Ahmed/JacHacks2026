import from datetime { datetime }
import from nodes.CheckoutSession { CheckoutSession }
import from nodes.PaymentEvent { PaymentEvent }
import from nodes.Invoice { Invoice }
import from nodes.MerchantWallet { MerchantWallet }
import from services.invoice { find_invoice }
import from services.invoice { create_invoice }
import from services.merchant { find_merchant_wallet, find_wallet_merchant }

def find_checkout_for_invoice(invoice: Invoice) -> CheckoutSession {
    for checkout in [invoice-->][?:CheckoutSession] {
        return checkout;
    }
}

def:pub create_checkout_session(invoice_id: str) -> CheckoutSession {
    invoice = find_invoice(invoice_id);
    existing = find_checkout_for_invoice(invoice);
    if existing {
        return existing;
    }
    checkout = (invoice ++> CheckoutSession(
        checkout_id="checkout_" + invoice.invoice_id,
        provider_session_id="cs_test_FILL_ME_" + invoice.invoice_id,
        provider_payment_intent_id="pi_test_FILL_ME_" + invoice.invoice_id,
        hosted_url="https://checkout.stripe.com/pay/FILL_ME_" + invoice.invoice_id,
        amount_total=invoice.fiat_amount,
        currency=invoice.fiat_currency,
        status="open",
    ))[0];
    invoice.checkout_url = checkout.hosted_url;
    invoice.status = "checkout_created";
    invoice.updated_at = datetime.now().isoformat();
    return checkout;
}

def:pub create_checkout_for_wallet(wallet_id: str, dollar_value: float, reference: str = "", description: str = "") -> CheckoutSession {
    wallet = find_merchant_wallet(wallet_id);
    merchant = find_wallet_merchant(wallet_id);
    if not wallet or not merchant {
        raise Exception("Merchant wallet not found.");
    }
    if wallet.status != "active" {
        raise Exception("Merchant wallet is not active.");
    }
    invoice_reference = reference;
    if not invoice_reference {
        invoice_reference = "public_" + wallet.wallet_id + "_" + str(len([merchant-->][?:Invoice]) + 1);
    }
    invoice_description = description;
    if not invoice_description {
        invoice_description = "Public checkout for wallet " + wallet.wallet_id;
    }
    invoice = create_invoice(
        merchant_id=merchant.merchant_id,
        reference=invoice_reference,
        fiat_amount=dollar_value,
        fiat_currency="USD",
        destination_wallet=wallet.address,
        chain=wallet.chain,
        quoted_asset_amount=dollar_value,
        description=invoice_description,
    );
    return create_checkout_session(invoice.invoice_id);
}

def:pub get_checkout(invoice_id: str) -> CheckoutSession {
    invoice = find_invoice(invoice_id);
    return find_checkout_for_invoice(invoice);
}

def:pub stripe_webhook(event_type: str, invoice_id: str, provider_event_id: str) -> PaymentEvent {
    invoice = find_invoice(invoice_id);
    event = (invoice ++> PaymentEvent(
        event_id="event_" + str(len([invoice-->][?:PaymentEvent]) + 1),
        provider_event_id=provider_event_id,
        event_type=event_type,
        payment_status="succeeded" if event_type == "payment_intent.succeeded" else "failed",
    ))[0];
    if event_type == "payment_intent.succeeded" {
        invoice.status = "payment_succeeded";
    } else {
        invoice.status = "payment_failed";
    }
    invoice.updated_at = datetime.now().isoformat();
    checkout = find_checkout_for_invoice(invoice);
    if checkout {
        checkout.status = "completed" if event_type == "payment_intent.succeeded" else "failed";
        checkout.updated_at = datetime.now().isoformat();
    }
    return event;
}

def:pub mark_payment_succeeded(invoice_id: str) -> Invoice {
    stripe_webhook("payment_intent.succeeded", invoice_id, "evt_test_success_" + invoice_id);
    return find_invoice(invoice_id);
}

def:pub mark_payment_failed(invoice_id: str) -> Invoice {
    stripe_webhook("payment_intent.payment_failed", invoice_id, "evt_test_failed_" + invoice_id);
    return find_invoice(invoice_id);
}
