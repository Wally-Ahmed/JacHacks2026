import from datetime { datetime }
import from .invoice { Invoice, find_invoice }
import from .merchant { Merchant, find_merchant }
import from .settlement { Payout }

node LedgerEntry {
    has entry_id: str = "";
    has entry_type: str = "";
    has asset: str = "USDC";
    has amount: float = 0.0;
    has direction: str = "internal";
    has reference_id: str = "";
    has note: str = "";
    has created_at: str = "";

    def postinit {
        if not self.created_at {
            self.created_at = datetime.now().isoformat();
        }
    }
}

node AuditEvent {
    has audit_id: str = "";
    has actor: str = "system";
    has action: str = "";
    has target_type: str = "";
    has target_id: str = "";
    has result: str = "ok";
    has notes: str = "";
    has created_at: str = "";

    def postinit {
        if not self.created_at {
            self.created_at = datetime.now().isoformat();
        }
    }
}

def append_invoice_ledger(invoice: Invoice, entry_type: str, amount: float = 0.0, asset: str = "USDC", direction: str = "internal", note: str = "") -> LedgerEntry {
    return (invoice ++> LedgerEntry(
        entry_id="ledger_" + str(len([invoice-->][?:LedgerEntry]) + 1),
        entry_type=entry_type,
        asset=asset,
        amount=amount,
        direction=direction,
        reference_id=invoice.invoice_id,
        note=note,
    ))[0];
}

def append_audit(action: str, target_type: str, target_id: str, notes: str = "", actor: str = "system") -> AuditEvent {
    return (root() ++> AuditEvent(
        audit_id="audit_" + str(len([root()-->][?:AuditEvent]) + 1),
        actor=actor,
        action=action,
        target_type=target_type,
        target_id=target_id,
        notes=notes,
    ))[0];
}

def:pub get_invoice_ledger(invoice_id: str) -> list[LedgerEntry] {
    invoice = find_invoice(invoice_id);
    return [invoice-->][?:LedgerEntry];
}

def:pub get_invoice_audit(invoice_id: str) -> list[AuditEvent] {
    events: list[AuditEvent] = [];
    for event in [root()-->][?:AuditEvent] {
        if event.target_id == invoice_id {
            events.append(event);
        }
    }
    return events;
}

def:pub reconcile_invoice(invoice_id: str) -> dict {
    invoice = find_invoice(invoice_id);
    return {
        "invoice_id": invoice.invoice_id,
        "status": invoice.status,
        "has_checkout": len([invoice-->][?:obj]) > 0,
        "ledger_entries": len([invoice-->][?:LedgerEntry]),
        "audit_events": len(get_invoice_audit(invoice_id)),
        "destination_address": invoice.destination_address,
    };
}
