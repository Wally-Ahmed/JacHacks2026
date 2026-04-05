sv import from ..services.settlement { bootstrap_demo, get_dashboard }

def:pub DashboardApp() -> JsxElement {
    has dashboard: dict = {};
    has loading: bool = True;

    can with [] entry {
        async def load() -> None {
            await bootstrap_demo();
            dashboard = await get_dashboard();
            loading = False;
        }
        load();
    }

    summary = dashboard["summary"] if dashboard and "summary" in dashboard else {};
    merchants = dashboard["merchants"] if dashboard and "merchants" in dashboard else [];
    invoices = dashboard["invoices"] if dashboard and "invoices" in dashboard else [];
    config = dashboard["config"] if dashboard and "config" in dashboard else {};
    routes = dashboard["routes"] if dashboard and "routes" in dashboard else [];

    return
        <div className="min-h-screen text-foreground">
            <div className="mx-auto flex max-w-7xl flex-col gap-8 px-6 py-8 lg:px-10">
                <section className="rounded-[28px] border border-border bg-card/90 p-8 shadow-card backdrop-blur">
                    <div className="flex flex-col gap-6 lg:flex-row lg:items-end lg:justify-between">
                        <div className="max-w-3xl space-y-4">
                            <div className="inline-flex items-center gap-2 rounded-full border border-primary/30 bg-primary/10 px-3 py-1 text-xs font-semibold uppercase tracking-[0.25em] text-primary">
                                Jac graph-native settlement MVP
                            </div>
                            <h1 className="text-4xl font-extrabold tracking-tight text-white lg:text-5xl">
                                Fiat checkout in, USDC settlement out, modeled as relationships.
                            </h1>
                            <p className="text-base leading-7 text-muted-foreground lg:text-lg">
                                This starter uses Jac nodes and edges for merchants, invoices, invoice wallets, payouts, and integration config. No SQL schema is used.
                            </p>
                        </div>
                        <div className="grid grid-cols-2 gap-3 sm:grid-cols-4">
                            <div className="rounded-2xl border border-border bg-muted p-4">
                                <div className="text-xs uppercase tracking-[0.2em] text-muted-foreground">Merchants</div>
                                <div className="mt-2 text-3xl font-bold text-white">{summary["merchant_count"] if "merchant_count" in summary else 0}</div>
                            </div>
                            <div className="rounded-2xl border border-border bg-muted p-4">
                                <div className="text-xs uppercase tracking-[0.2em] text-muted-foreground">Invoices</div>
                                <div className="mt-2 text-3xl font-bold text-white">{summary["invoice_count"] if "invoice_count" in summary else 0}</div>
                            </div>
                            <div className="rounded-2xl border border-border bg-muted p-4">
                                <div className="text-xs uppercase tracking-[0.2em] text-muted-foreground">Invoice wallets</div>
                                <div className="mt-2 text-3xl font-bold text-white">{summary["invoice_wallet_count"] if "invoice_wallet_count" in summary else 0}</div>
                            </div>
                            <div className="rounded-2xl border border-border bg-muted p-4">
                                <div className="text-xs uppercase tracking-[0.2em] text-muted-foreground">Payouts</div>
                                <div className="mt-2 text-3xl font-bold text-white">{summary["payout_count"] if "payout_count" in summary else 0}</div>
                            </div>
                        </div>
                    </div>
                </section>

                {loading and <section className="rounded-3xl border border-border bg-card p-8 shadow-soft">
                    <div className="text-sm uppercase tracking-[0.2em] text-muted-foreground">Loading graph data...</div>
                </section>}

                {not loading and <div className="grid gap-8 xl:grid-cols-[1.2fr_0.8fr]">
                    <div className="space-y-8">
                        <section className="rounded-3xl border border-border bg-card p-6 shadow-soft">
                            <div className="mb-5 flex items-center justify-between">
                                <div>
                                    <h2 className="text-2xl font-bold text-white">Graph nodes</h2>
                                    <p className="text-sm text-muted-foreground">Each invoice is connected to a merchant, a one-time invoice wallet, and a payout node.</p>
                                </div>
                                <div className="rounded-full border border-secondary/30 bg-secondary/10 px-3 py-1 text-xs font-semibold uppercase tracking-[0.2em] text-secondary">Relationships first</div>
                            </div>
                            <div className="space-y-4">
                                {[
                                    <div key={merchant["id"]} className="rounded-2xl border border-border bg-muted p-5 transition-colors hover:bg-card-hover">
                                        <div className="flex flex-col gap-4 lg:flex-row lg:items-start lg:justify-between">
                                            <div>
                                                <div className="text-lg font-semibold text-white">{merchant["name"]}</div>
                                                <div className="text-sm text-muted-foreground">{merchant["email"]} · {merchant["status"]}</div>
                                            </div>
                                            <div className="rounded-xl border border-border px-3 py-2 text-xs text-muted-foreground">Merchant node</div>
                                        </div>
                                        <div className="mt-4 grid gap-3">
                                            {[
                                                <div key={wallet["id"]} className="rounded-xl border border-border bg-card px-4 py-3">
                                                    <div className="text-xs uppercase tracking-[0.2em] text-muted-foreground">Owns wallet</div>
                                                    <div className="mt-1 break-all font-mono text-sm text-white">{wallet["address"]}</div>
                                                    <div className="mt-1 text-xs text-muted-foreground">{wallet["chain"]} · {wallet["label"]}</div>
                                                </div> for wallet in merchant["wallets"]
                                            ]}
                                        </div>
                                    </div> for merchant in merchants
                                ]}
                            </div>
                        </section>

                        <section className="rounded-3xl border border-border bg-card p-6 shadow-soft">
                            <div className="mb-5">
                                <h2 className="text-2xl font-bold text-white">Invoice routes and lifecycle</h2>
                                <p className="text-sm text-muted-foreground">These public endpoints are already registered in Jac and backed by graph mutations.</p>
                            </div>
                            <div className="grid gap-3 md:grid-cols-2">
                                {[
                                    <div key={route} className="rounded-2xl border border-border bg-muted px-4 py-3 font-mono text-sm text-primary transition-colors hover:bg-card-hover">{route}</div> for route in routes
                                ]}
                            </div>
                        </section>
                    </div>

                    <div className="space-y-8">
                        <section className="rounded-3xl border border-border bg-card p-6 shadow-soft">
                            <div className="mb-5">
                                <h2 className="text-2xl font-bold text-white">Placeholder keys to fill in</h2>
                                <p className="text-sm text-muted-foreground">Replace these demo values before wiring real providers.</p>
                            </div>
                            <div className="space-y-3">
                                <div className="rounded-2xl border border-border bg-muted p-4">
                                    <div className="text-xs uppercase tracking-[0.2em] text-muted-foreground">Stripe publishable key</div>
                                    <div className="mt-2 break-all font-mono text-sm text-white">{config["stripe_publishable_key"] if "stripe_publishable_key" in config else "pk_test_FILL_ME_STRIPE_PUBLISHABLE_KEY"}</div>
                                </div>
                                <div className="rounded-2xl border border-border bg-muted p-4">
                                    <div className="text-xs uppercase tracking-[0.2em] text-muted-foreground">Stripe secret key</div>
                                    <div className="mt-2 break-all font-mono text-sm text-white">{config["stripe_secret_key"] if "stripe_secret_key" in config else "sk_test_FILL_ME_STRIPE_SECRET_KEY"}</div>
                                </div>
                                <div className="rounded-2xl border border-border bg-muted p-4">
                                    <div className="text-xs uppercase tracking-[0.2em] text-muted-foreground">Stripe webhook secret</div>
                                    <div className="mt-2 break-all font-mono text-sm text-white">{config["stripe_webhook_secret"] if "stripe_webhook_secret" in config else "whsec_FILL_ME_STRIPE_WEBHOOK_SECRET"}</div>
                                </div>
                                <div className="rounded-2xl border border-border bg-muted p-4">
                                    <div className="text-xs uppercase tracking-[0.2em] text-muted-foreground">Wallet provider keys</div>
                                    <div className="mt-2 break-all font-mono text-sm text-white">{config["wallet_api_public_key"] if "wallet_api_public_key" in config else "FILL_ME_WALLET_PROVIDER_PUBLIC_KEY"}</div>
                                    <div className="mt-1 break-all font-mono text-sm text-white">{config["wallet_api_private_key"] if "wallet_api_private_key" in config else "FILL_ME_WALLET_PROVIDER_PRIVATE_KEY"}</div>
                                </div>
                                <div className="rounded-2xl border border-border bg-muted p-4">
                                    <div className="text-xs uppercase tracking-[0.2em] text-muted-foreground">Treasury wallet + RPC</div>
                                    <div className="mt-2 break-all font-mono text-sm text-white">{config["usdc_treasury_wallet"] if "usdc_treasury_wallet" in config else "0xFILL_ME_TREASURY_WALLET"}</div>
                                    <div className="mt-1 break-all font-mono text-sm text-white">{config["rpc_url"] if "rpc_url" in config else "https://FILL_ME_RPC_URL"}</div>
                                </div>
                            </div>
                        </section>

                        <section className="rounded-3xl border border-border bg-card p-6 shadow-soft">
                            <div className="mb-5">
                                <h2 className="text-2xl font-bold text-white">Live invoice graph</h2>
                                <p className="text-sm text-muted-foreground">Demo invoice data seeded into the root graph.</p>
                            </div>
                            <div className="space-y-4">
                                {[
                                    <div key={invoice["id"]} className="rounded-2xl border border-border bg-muted p-5">
                                        <div className="flex items-start justify-between gap-4">
                                            <div>
                                                <div className="text-lg font-semibold text-white">{invoice["reference"]}</div>
                                                <div className="mt-1 text-sm text-muted-foreground">{invoice["fiat_currency"]} {invoice["fiat_amount"]} → {invoice["target_usdc"]} USDC</div>
                                            </div>
                                            <div className="rounded-full border border-primary/30 bg-primary/10 px-3 py-1 text-xs font-semibold uppercase tracking-[0.2em] text-primary">{invoice["status"]}</div>
                                        </div>
                                        <div className="mt-4 rounded-xl border border-border bg-card p-4">
                                            <div className="text-xs uppercase tracking-[0.2em] text-muted-foreground">Stripe checkout</div>
                                            <div className="mt-2 break-all font-mono text-sm text-white">{invoice["stripe_checkout_url"]}</div>
                                            <div className="mt-1 text-xs text-muted-foreground">Session: {invoice["stripe_session_id"]}</div>
                                        </div>
                                        <div className="mt-4 grid gap-3">
                                            {[
                                                <div key={wallet["id"]} className="rounded-xl border border-border bg-card p-4">
                                                    <div className="text-xs uppercase tracking-[0.2em] text-muted-foreground">Invoice wallet</div>
                                                    <div className="mt-2 break-all font-mono text-sm text-white">{wallet["address"]}</div>
                                                    <div className="mt-1 text-xs text-muted-foreground">{wallet["provider"]} · limit {wallet["spend_limit_usdc"]} USDC · {wallet["status"]}</div>
                                                </div> for wallet in invoice["invoice_wallets"]
                                            ]}
                                            {[
                                                <div key={payout["id"]} className="rounded-xl border border-border bg-card p-4">
                                                    <div className="text-xs uppercase tracking-[0.2em] text-muted-foreground">Payout</div>
                                                    <div className="mt-2 text-sm text-white">{payout["amount_usdc"]} USDC → {payout["destination_wallet"]}</div>
                                                    <div className="mt-1 break-all font-mono text-xs text-muted-foreground">{payout["tx_hash"]}</div>
                                                </div> for payout in invoice["payouts"]
                                            ]}
                                        </div>
                                    </div> for invoice in invoices
                                ]}
                            </div>
                        </section>
                    </div>
                </div>}
            </div>
        </div>;
}
