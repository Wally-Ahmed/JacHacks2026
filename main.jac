"""Graph-native backend for fiat-to-USDC settlement MVP."""

import from config {
    IntegrationConfig,
    seed_demo_config,
    list_configs
}
import from app_platform {
    Platform,
    bootstrap_platform,
    get_platform_overview
}
import from services.merchant {
    Merchant,
    MerchantWallet,
    create_merchant,
    get_merchant,
    list_merchants,
    add_merchant_wallet,
    list_merchant_wallets
}
import from services.invoice {
    Invoice,
    create_invoice,
    get_invoice,
    list_invoices,
    list_merchant_invoices,
    expire_invoice
}
import from services.payment {
    CheckoutSession,
    PaymentEvent,
    create_checkout_session,
    get_checkout,
    stripe_webhook,
    mark_payment_succeeded,
    mark_payment_failed
}
import from services.wallets {
    InvoiceWallet,
    create_invoice_wallet,
    get_invoice_wallet,
    retire_invoice_wallet
}
import from services.settlement {
    TreasuryLot,
    Payout,
    reserve_treasury,
    fund_invoice_wallet,
    create_payout,
    broadcast_payout,
    confirm_payout,
    retry_payout,
    get_failed_payouts
}
import from services.audit {
    LedgerEntry,
    AuditEvent,
    get_invoice_ledger,
    get_invoice_audit,
    reconcile_invoice
}

cl import ".styles.global.css";

cl def:pub app -> JsxElement {
    return <div className="min-h-screen bg-slate-950 text-slate-100 p-8 font-sans">
        <div className="mx-auto max-w-5xl space-y-6">
            <div className="rounded-3xl border border-cyan-500/20 bg-slate-900/80 p-8 shadow-2xl shadow-cyan-950/30">
                <p className="text-xs uppercase tracking-[0.35em] text-cyan-300">Jac backend ready</p>
                <h1 className="mt-3 text-4xl font-semibold">Fiat to USDC settlement graph</h1>
                <p className="mt-4 max-w-3xl text-slate-300">
                    Backend routes are registered in main.jac. Use the public endpoints to bootstrap the platform,
                    create merchants and invoices, simulate Stripe payment events, create per-invoice wallets,
                    and drive settlement state transitions.
                </p>
            </div>
            <div className="grid gap-4 md:grid-cols-2">
                <div className="rounded-2xl border border-slate-800 bg-slate-900 p-6">
                    <h2 className="text-lg font-semibold text-white">Start here</h2>
                    <ul className="mt-3 space-y-2 text-sm text-slate-300">
                        <li>1. bootstrap_platform()</li>
                        <li>2. create_merchant(name, email)</li>
                        <li>3. add_merchant_wallet(merchant_id, address)</li>
                        <li>4. create_invoice(...)</li>
                        <li>5. create_checkout_session(invoice_id)</li>
                        <li>6. mark_payment_succeeded(invoice_id)</li>
                        <li>7. create_invoice_wallet(invoice_id)</li>
                        <li>8. reserve_treasury(invoice_id)</li>
                        <li>9. fund_invoice_wallet(invoice_id)</li>
                        <li>10. create_payout(invoice_id) → broadcast_payout(invoice_id) → confirm_payout(invoice_id)</li>
                    </ul>
                </div>
                <div className="rounded-2xl border border-slate-800 bg-slate-900 p-6">
                    <h2 className="text-lg font-semibold text-white">Fill these placeholders</h2>
                    <ul className="mt-3 space-y-2 text-sm text-slate-300">
                        <li>pk_test_FILL_ME_STRIPE_PUBLISHABLE_KEY</li>
                        <li>sk_test_FILL_ME_STRIPE_SECRET_KEY</li>
                        <li>whsec_FILL_ME_STRIPE_WEBHOOK_SECRET</li>
                        <li>FILL_ME_WALLET_PROVIDER_API_KEY</li>
                        <li>FILL_ME_WALLET_PROVIDER_SECRET</li>
                        <li>0xFILL_ME_TREASURY_WALLET</li>
                        <li>https://FILL_ME_RPC_URL</li>
                        <li>0xFILL_ME_USDC_CONTRACT</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>;
}
