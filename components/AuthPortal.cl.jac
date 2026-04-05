def:pub LandingHero(props: dict) -> JsxElement {
    return <section className="grid gap-10 lg:grid-cols-[1.1fr_0.9fr] lg:items-center">
        <div className="space-y-6">
            <div className="inline-flex items-center gap-2 rounded-full border border-white/10 bg-white/5 px-4 py-2 text-xs font-medium uppercase tracking-[0.28em] text-cyan-200">
                <span>Base Sepolia ready</span>
            </div>
            <div className="space-y-4">
                <h1 className="max-w-3xl text-5xl font-semibold tracking-tight text-white sm:text-6xl">
                    <span>Accept fiat, settle in USDC, and keep every payout traceable.</span>
                </h1>
                <p className="max-w-2xl text-lg leading-8 text-slate-300">
                    <span>Launch a polished merchant portal with simple local auth flows while your Jac backend evolves underneath.</span>
                </p>
            </div>
            <div className="flex flex-col gap-3 sm:flex-row">
                <button className="rounded-2xl bg-primary px-6 py-3 text-sm font-semibold text-primary-foreground shadow-card transition hover:-translate-y-0.5 hover:bg-primary/90" onClick={props["go_signup"]}>
                    <span>Create account</span>
                </button>
                <button className="rounded-2xl border border-white/15 bg-white/5 px-6 py-3 text-sm font-semibold text-white transition hover:bg-white/10" onClick={props["go_login"]}>
                    <span>Log in</span>
                </button>
            </div>
            <div className="grid gap-4 sm:grid-cols-3">
                <div className="rounded-3xl border border-white/10 bg-white/5 p-5 shadow-soft">
                    <p className="text-3xl font-semibold text-white"><span>24/7</span></p>
                    <p className="mt-2 text-sm text-slate-300"><span>Invoice wallet creation and payout orchestration.</span></p>
                </div>
                <div className="rounded-3xl border border-white/10 bg-white/5 p-5 shadow-soft">
                    <p className="text-3xl font-semibold text-white"><span>1:1</span></p>
                    <p className="mt-2 text-sm text-slate-300"><span>One invoice, one wallet, one destination policy.</span></p>
                </div>
                <div className="rounded-3xl border border-white/10 bg-white/5 p-5 shadow-soft">
                    <p className="text-3xl font-semibold text-white"><span>USDC</span></p>
                    <p className="mt-2 text-sm text-slate-300"><span>Base Sepolia-first flow for fast MVP testing.</span></p>
                </div>
            </div>
        </div>
        <div className="rounded-[2rem] border border-cyan-400/20 bg-slate-950/60 p-6 shadow-card backdrop-blur">
            <div className="rounded-[1.5rem] border border-white/10 bg-gradient-to-br from-slate-900 via-slate-950 to-slate-900 p-6">
                <div className="flex items-center justify-between">
                    <div>
                        <p className="text-sm uppercase tracking-[0.28em] text-cyan-200"><span>Settlement pulse</span></p>
                        <h2 className="mt-2 text-2xl font-semibold text-white"><span>Merchant dashboard preview</span></h2>
                    </div>
                    <div className="rounded-full border border-emerald-400/20 bg-emerald-400/10 px-3 py-1 text-xs font-medium text-emerald-300">
                        <span>Live</span>
                    </div>
                </div>
                <div className="mt-6 space-y-4">
                    <div className="rounded-2xl border border-white/10 bg-white/5 p-4">
                        <div className="flex items-center justify-between text-sm text-slate-300">
                            <span>Pending settlement</span>
                            <span className="font-semibold text-white">$18,420</span>
                        </div>
                        <div className="mt-3 h-2 rounded-full bg-white/10">
                            <div className="h-2 w-3/4 rounded-full bg-gradient-to-r from-cyan-400 to-blue-500"></div>
                        </div>
                    </div>
                    <div className="grid gap-4 sm:grid-cols-2">
                        <div className="rounded-2xl border border-white/10 bg-white/5 p-4">
                            <p className="text-xs uppercase tracking-[0.24em] text-slate-400"><span>Invoices today</span></p>
                            <p className="mt-3 text-3xl font-semibold text-white"><span>42</span></p>
                        </div>
                        <div className="rounded-2xl border border-white/10 bg-white/5 p-4">
                            <p className="text-xs uppercase tracking-[0.24em] text-slate-400"><span>Success rate</span></p>
                            <p className="mt-3 text-3xl font-semibold text-white"><span>99.2%</span></p>
                        </div>
                    </div>
                    <div className="rounded-2xl border border-white/10 bg-white/5 p-4">
                        <p className="text-xs uppercase tracking-[0.24em] text-slate-400"><span>Recent payout</span></p>
                        <div className="mt-3 flex items-center justify-between gap-4">
                            <div>
                                <p className="font-medium text-white"><span>Invoice INV-2048</span></p>
                                <p className="text-sm text-slate-400"><span>Sent to merchant wallet ending in 9A3F</span></p>
                            </div>
                            <p className="text-sm font-semibold text-emerald-300"><span>Confirmed</span></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>;
}

def:pub AuthForm(props: dict) -> JsxElement {
    return <div className="mx-auto w-full max-w-3xl rounded-[2rem] border border-white/10 bg-card/90 p-8 shadow-card backdrop-blur">
        <div className="space-y-2">
            <p className="text-sm uppercase tracking-[0.28em] text-cyan-200">{props["eyebrow"] or ""}</p>
            <h2 className="text-3xl font-semibold text-white">{props["title"] or ""}</h2>
            <p className="text-sm leading-6 text-slate-300">{props["subtitle"] or ""}</p>
        </div>
        <div className="mt-8 space-y-5">
            {props["show_signup_fields"] and (
                <div className="grid gap-5 sm:grid-cols-2">
                    <div className="space-y-2">
                        <label className="text-sm font-medium text-slate-200"><span>Name</span></label>
                        <input className="w-full rounded-2xl border border-white/10 bg-slate-950/70 px-4 py-3 text-white outline-none transition focus:border-cyan-400/60 focus:ring-2 focus:ring-cyan-400/20" value={str(props["legal_name"])} onChange={props["set_legal_name"]} placeholder="Acme Commerce LLC" />
                    </div>
                    <div className="space-y-2">
                        <label className="text-sm font-medium text-slate-200"><span>Screen name</span></label>
                        <input className="w-full rounded-2xl border border-white/10 bg-slate-950/70 px-4 py-3 text-white outline-none transition focus:border-cyan-400/60 focus:ring-2 focus:ring-cyan-400/20" value={str(props["display_name"])} onChange={props["set_display_name"]} placeholder="Acme Commerce" />
                    </div>
                </div>
            )}
            {props["show_signup_fields"] and (
                <div className="grid gap-5 sm:grid-cols-2">
                    <div className="space-y-2">
                        <label className="text-sm font-medium text-slate-200"><span>Business website</span></label>
                        <input className="w-full rounded-2xl border border-white/10 bg-slate-950/70 px-4 py-3 text-white outline-none transition focus:border-cyan-400/60 focus:ring-2 focus:ring-cyan-400/20" value={str(props["website"])} onChange={props["set_website"]} placeholder="https://acmecommerce.com" />
                    </div>
                    <div className="space-y-2">
                        <label className="text-sm font-medium text-slate-200"><span>Business type</span></label>
                        <input className="w-full rounded-2xl border border-white/10 bg-slate-950/70 px-4 py-3 text-white outline-none transition focus:border-cyan-400/60 focus:ring-2 focus:ring-cyan-400/20" value={str(props["business_type"])} onChange={props["set_business_type"]} placeholder="Marketplace, SaaS, agency..." />
                    </div>
                </div>
            )}
            {props["show_signup_fields"] and (
                <div className="grid gap-5 sm:grid-cols-2">
                    <div className="space-y-2">
                        <label className="text-sm font-medium text-slate-200"><span>Default chain</span></label>
                        <input className="w-full rounded-2xl border border-white/10 bg-slate-950/70 px-4 py-3 text-white outline-none transition focus:border-cyan-400/60 focus:ring-2 focus:ring-cyan-400/20" value={str(props["default_chain"])} onChange={props["set_default_chain"]} placeholder="base-sepolia" />
                    </div>
                    <div className="space-y-2">
                        <label className="text-sm font-medium text-slate-200"><span>Settlement asset</span></label>
                        <input className="w-full rounded-2xl border border-white/10 bg-slate-950/70 px-4 py-3 text-white outline-none transition focus:border-cyan-400/60 focus:ring-2 focus:ring-cyan-400/20" value={str(props["default_asset"])} onChange={props["set_default_asset"]} placeholder="USDC" />
                    </div>
                </div>
            )}
            {props["show_signup_fields"] and (
                <div className="space-y-2">
                    <label className="text-sm font-medium text-slate-200"><span>Payout wallet address</span></label>
                    <input className="w-full rounded-2xl border border-white/10 bg-slate-950/70 px-4 py-3 text-white outline-none transition focus:border-cyan-400/60 focus:ring-2 focus:ring-cyan-400/20" value={str(props["wallet_address"])} onChange={props["set_wallet_address"]} placeholder="0x1234...abcd" />
                </div>
            )}
            <div className="space-y-2">
                <label className="text-sm font-medium text-slate-200"><span>Business email</span></label>
                <input className="w-full rounded-2xl border border-white/10 bg-slate-950/70 px-4 py-3 text-white outline-none transition focus:border-cyan-400/60 focus:ring-2 focus:ring-cyan-400/20" value={str(props["email"])} onChange={props["set_email"]} placeholder="founder@merchant.com" />
            </div>
            <div className="space-y-2">
                <label className="text-sm font-medium text-slate-200"><span>Password</span></label>
                <input className="w-full rounded-2xl border border-white/10 bg-slate-950/70 px-4 py-3 text-white outline-none transition focus:border-cyan-400/60 focus:ring-2 focus:ring-cyan-400/20" type="password" value={str(props["password"])} onChange={props["set_password"]} placeholder="••••••••••••" />
            </div>
            <button className="w-full rounded-2xl bg-primary px-5 py-3 text-sm font-semibold text-primary-foreground transition hover:bg-primary/90" onClick={props["submit"]}>
                {str(props["button_text"])}
            </button>
            <button className="w-full rounded-2xl border border-white/10 bg-white/5 px-5 py-3 text-sm font-semibold text-white transition hover:bg-white/10" onClick={props["go_home"]}>
                <span>Back to landing</span>
            </button>
        </div>
    </div>;
}

def:pub DashboardView(props: dict) -> JsxElement {
    return <div className="space-y-8">
        <div className="flex flex-col gap-4 rounded-[2rem] border border-white/10 bg-card/90 p-8 shadow-card backdrop-blur lg:flex-row lg:items-center lg:justify-between">
            <div>
                <p className="text-sm uppercase tracking-[0.28em] text-cyan-200"><span>Merchant dashboard</span></p>
                <h1 className="mt-3 text-4xl font-semibold text-white">{str(props["welcome_text"])}</h1>
                <p className="mt-3 max-w-2xl text-slate-300">
                    <span>Monitor invoice volume, wallet creation, and payout health for your Base Sepolia settlement flow.</span>
                </p>
            </div>
            <div className="flex flex-wrap gap-3">
                <button className="rounded-2xl border border-white/10 bg-white/5 px-5 py-3 text-sm font-semibold text-white transition hover:bg-white/10" onClick={props["logout"]}>
                    <span>Log out</span>
                </button>
            </div>
        </div>
        <div className="grid gap-4 md:grid-cols-2 xl:grid-cols-4">
            <div className="rounded-[1.75rem] border border-white/10 bg-white/5 p-6 shadow-soft">
                <p className="text-sm text-slate-400"><span>Gross volume</span></p>
                <p className="mt-3 text-3xl font-semibold text-white">{str(props["volume"])}</p>
            </div>
            <div className="rounded-[1.75rem] border border-white/10 bg-white/5 p-6 shadow-soft">
                <p className="text-sm text-slate-400"><span>Invoices</span></p>
                <p className="mt-3 text-3xl font-semibold text-white">{str(props["invoices"])}</p>
            </div>
            <div className="rounded-[1.75rem] border border-white/10 bg-white/5 p-6 shadow-soft">
                <p className="text-sm text-slate-400"><span>Wallets created</span></p>
                <p className="mt-3 text-3xl font-semibold text-white">{str(props["wallets"])}</p>
            </div>
            <div className="rounded-[1.75rem] border border-white/10 bg-white/5 p-6 shadow-soft">
                <p className="text-sm text-slate-400"><span>Payout success</span></p>
                <p className="mt-3 text-3xl font-semibold text-white">{str(props["success"])} </p>
            </div>
        </div>
        <div className="grid gap-6 lg:grid-cols-[1.1fr_0.9fr]">
            <div className="rounded-[2rem] border border-white/10 bg-card/90 p-8 shadow-card">
                <div className="flex items-center justify-between">
                    <div>
                        <p className="text-sm uppercase tracking-[0.28em] text-cyan-200"><span>Recent activity</span></p>
                        <h2 className="mt-2 text-2xl font-semibold text-white"><span>Settlement timeline</span></h2>
                    </div>
                    <div className="rounded-full border border-emerald-400/20 bg-emerald-400/10 px-3 py-1 text-xs font-medium text-emerald-300">
                        <span>Healthy</span>
                    </div>
                </div>
                <div className="mt-6 space-y-4">
                    <div className="rounded-2xl border border-white/10 bg-white/5 p-4">
                        <p className="text-sm font-medium text-white"><span>INV-2048 funded</span></p>
                        <p className="mt-1 text-sm text-slate-400"><span>Treasury reserved and invoice wallet funded with exact USDC amount.</span></p>
                    </div>
                    <div className="rounded-2xl border border-white/10 bg-white/5 p-4">
                        <p className="text-sm font-medium text-white"><span>Payout broadcast</span></p>
                        <p className="mt-1 text-sm text-slate-400"><span>Merchant destination allowlist matched and transaction submitted on Base Sepolia.</span></p>
                    </div>
                    <div className="rounded-2xl border border-white/10 bg-white/5 p-4">
                        <p className="text-sm font-medium text-white"><span>Webhook reconciled</span></p>
                        <p className="mt-1 text-sm text-slate-400"><span>Stripe payment event linked to invoice graph and audit trail updated.</span></p>
                    </div>
                </div>
            </div>
            <div className="rounded-[2rem] border border-white/10 bg-card/90 p-8 shadow-card">
                <p className="text-sm uppercase tracking-[0.28em] text-cyan-200"><span>Account snapshot</span></p>
                <h2 className="mt-2 text-2xl font-semibold text-white">{str(props["email"])}</h2>
                <div className="mt-6 space-y-4">
                    <div className="rounded-2xl border border-white/10 bg-white/5 p-4">
                        <p className="text-sm text-slate-400"><span>Preferred chain</span></p>
                        <p className="mt-2 text-lg font-semibold text-white">{str(props["default_chain"])}</p>
                    </div>
                    <div className="rounded-2xl border border-white/10 bg-white/5 p-4">
                        <p className="text-sm text-slate-400"><span>Settlement asset</span></p>
                        <p className="mt-2 text-lg font-semibold text-white">{str(props["default_asset"])}</p>
                    </div>
                    <div className="rounded-2xl border border-white/10 bg-white/5 p-4">
                        <p className="text-sm text-slate-400"><span>Payout wallet</span></p>
                        <p className="mt-2 text-sm font-semibold text-white break-all">{str(props["wallet_address"])}</p>
                    </div>
                    <div className="rounded-2xl border border-white/10 bg-white/5 p-4">
                        <p className="text-sm text-slate-400"><span>Next recommended step</span></p>
                        <p className="mt-2 text-sm leading-6 text-slate-300"><span>Connect Circle credentials, configure your Base Sepolia RPC, and wire merchant wallet onboarding to backend routes later.</span></p>
                    </div>
                </div>
            </div>
        </div>
    </div>;
}

def:pub AuthPortal(props: dict) -> JsxElement {
    has route: str = "landing";
    has is_logged_in: bool = False;
    has first_name: str = "";
    has last_name: str = "";
    has legal_name: str = "";
    has display_name: str = "";
    has website: str = "";
    has business_type: str = "";
    has default_chain: str = "Base Sepolia";
    has default_asset: str = "USDC";
    has wallet_address: str = "";
    has email: str = "";
    has password: str = "";

    can with [is_logged_in, route] entry {
        if is_logged_in and route == "landing" {
            route = "dashboard";
        }
    }

    def go_landing() -> None {
        if is_logged_in {
            route = "dashboard";
        } else {
            route = "landing";
        }
    }

    def go_login() -> None {
        route = "login";
    }

    def go_signup() -> None {
        route = "signup";
    }

    def go_dashboard() -> None {
        route = "dashboard";
    }

    def set_first_name(e: any) -> None {
        first_name = e.target.value;
    }

    def set_last_name(e: any) -> None {
        last_name = e.target.value;
    }

    def set_legal_name(e: any) -> None {
        legal_name = e.target.value;
    }

    def set_display_name(e: any) -> None {
        display_name = e.target.value;
    }

    def set_website(e: any) -> None {
        website = e.target.value;
    }

    def set_business_type(e: any) -> None {
        business_type = e.target.value;
    }

    def set_default_chain(e: any) -> None {
        default_chain = e.target.value;
    }

    def set_default_asset(e: any) -> None {
        default_asset = e.target.value;
    }

    def set_wallet_address(e: any) -> None {
        wallet_address = e.target.value;
    }

    def set_email(e: any) -> None {
        email = e.target.value;
    }

    def set_password(e: any) -> None {
        password = e.target.value;
    }

    def login_submit() -> None {
        is_logged_in = True;
        route = "dashboard";
    }

    def signup_submit() -> None {
        if not legal_name.strip() and display_name.strip() {
            legal_name = display_name;
        }
        if not display_name.strip() and legal_name.strip() {
            display_name = legal_name;
        }
        is_logged_in = True;
        route = "dashboard";
    }

    def logout() -> None {
        is_logged_in = False;
        route = "landing";
    }

    welcome_text = "Welcome back, Merchant";
    if first_name.strip() {
        welcome_text = "Welcome back, " + first_name;
        if display_name.strip() {
            welcome_text = welcome_text + " from " + display_name;
        }
    } elif display_name.strip() {
        welcome_text = "Welcome back, " + display_name;
    } elif legal_name.strip() {
        welcome_text = "Welcome back, " + legal_name;
    }

    dashboard_email = "founder@merchant.com";
    if email.strip() {
        dashboard_email = email;
    }

    dashboard_chain = default_chain;
    if not dashboard_chain.strip() {
        dashboard_chain = "Base Sepolia";
    }

    dashboard_asset = default_asset;
    if not dashboard_asset.strip() {
        dashboard_asset = "USDC";
    }

    dashboard_wallet = wallet_address;
    if not dashboard_wallet.strip() {
        dashboard_wallet = "Not added yet";
    }

    return <div className="min-h-screen bg-background text-foreground">
        <div className="mx-auto flex min-h-screen w-full max-w-7xl flex-col px-6 py-6 sm:px-8 lg:px-10">
            <header className="flex flex-col gap-4 rounded-[2rem] border border-white/10 bg-white/5 px-6 py-5 shadow-soft backdrop-blur md:flex-row md:items-center md:justify-between">
                <button className="flex items-center gap-3 text-left" onClick={go_landing}>
                    <div className="flex h-12 w-12 items-center justify-center rounded-2xl bg-gradient-to-br from-cyan-400 to-blue-500 text-lg font-bold text-slate-950"><span>J</span></div>
                    <div>
                        <p className="text-sm uppercase tracking-[0.28em] text-cyan-200"><span>Jac settlement</span></p>
                        <p className="text-lg font-semibold text-white"><span>Merchant Portal</span></p>
                    </div>
                </button>
                <nav className="flex flex-wrap items-center gap-3 text-sm">
                    {(not is_logged_in) and (<button className="rounded-full border border-white/10 px-4 py-2 text-slate-200 transition hover:bg-white/10" onClick={go_login}><span>Login</span></button>)}
                    {(not is_logged_in) and (<button className="rounded-full bg-primary px-4 py-2 font-semibold text-primary-foreground transition hover:bg-primary/90" onClick={go_signup}><span>Sign up</span></button>)}
                    {is_logged_in and (<button className="rounded-full bg-primary px-4 py-2 font-semibold text-primary-foreground transition hover:bg-primary/90" onClick={go_dashboard}><span>Dashboard</span></button>)}
                </nav>
            </header>
            <main className="flex-1 space-y-8 py-10">
                {route == "landing" and (<LandingHero props={{"go_signup": go_signup, "go_login": go_login}} />)}
                {route == "login" and (<AuthForm props={{
                    "eyebrow": "Welcome back",
                    "title": "Log in to your merchant account",
                    "subtitle": "Access invoice activity, payout status, and wallet operations from one Jac-powered dashboard.",
                    "first_name": first_name,
                    "last_name": last_name,
                    "legal_name": legal_name,
                    "display_name": display_name,
                    "website": website,
                    "business_type": business_type,
                    "default_chain": default_chain,
                    "default_asset": default_asset,
                    "wallet_address": wallet_address,
                    "email": email,
                    "password": password,
                    "set_first_name": set_first_name,
                    "set_last_name": set_last_name,
                    "set_legal_name": set_legal_name,
                    "set_display_name": set_display_name,
                    "set_website": set_website,
                    "set_business_type": set_business_type,
                    "set_default_chain": set_default_chain,
                    "set_default_asset": set_default_asset,
                    "set_wallet_address": set_wallet_address,
                    "set_email": set_email,
                    "set_password": set_password,
                    "show_signup_fields": False,
                    "button_text": "Log in",
                    "submit": login_submit,
                    "go_home": go_landing
                }} />)}
                {route == "signup" and (<AuthForm props={{
                    "eyebrow": "Get started",
                    "title": "Create your merchant portal",
                    "subtitle": "Enter the merchant profile details needed to create a new merchant account and payout destination.",
                    "first_name": first_name,
                    "last_name": last_name,
                    "legal_name": legal_name,
                    "display_name": display_name,
                    "website": website,
                    "business_type": business_type,
                    "default_chain": default_chain,
                    "default_asset": default_asset,
                    "wallet_address": wallet_address,
                    "email": email,
                    "password": password,
                    "set_first_name": set_first_name,
                    "set_last_name": set_last_name,
                    "set_legal_name": set_legal_name,
                    "set_display_name": set_display_name,
                    "set_website": set_website,
                    "set_business_type": set_business_type,
                    "set_default_chain": set_default_chain,
                    "set_default_asset": set_default_asset,
                    "set_wallet_address": set_wallet_address,
                    "set_email": set_email,
                    "set_password": set_password,
                    "show_signup_fields": True,
                    "button_text": "Create account",
                    "submit": signup_submit,
                    "go_home": go_landing
                }} />)}
                {route == "dashboard" and (<DashboardView props={{
                    "welcome_text": welcome_text,
                    "email": dashboard_email,
                    "default_chain": dashboard_chain,
                    "default_asset": dashboard_asset,
                    "wallet_address": dashboard_wallet,
                    "volume": "$128.4k",
                    "invoices": "342",
                    "wallets": "342",
                    "success": "99.2%",
                    "go_landing": go_landing,
                    "logout": logout
                }} />)}
            </main>
        </div>
    </div>;
}
