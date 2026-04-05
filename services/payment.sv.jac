import from datetime { datetime }
import from ..nodes.CheckoutSession { CheckoutSession }
import from ..nodes.PaymentEvent { PaymentEvent }
import from ..nodes.Invoice { Invoice }
import from .invoice { find_invoice }

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
