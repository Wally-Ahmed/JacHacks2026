def LandingHero(props: dict) -> JsxElement {
    return <section className="grid gap-10 lg:grid-cols-[1.1fr_0.9fr] lg:items-center">
        <div className="space-y-6">
            <div className="inline-flex items-center gap-2 rounded-full border border-white/10 bg-white/5 px-4 py-2 text-xs font-medium uppercase tracking-[0.28em] text-cyan-200">
                Base Sepolia ready
            </div>
            <div className="space-y-4">
                <h1 className="max-w-3xl text-5xl font-semibold tracking-tight text-white sm:text-6xl">
                    Accept fiat, settle in USDC, and keep every payout traceable.
                </h1>
                <p className="max-w-2xl text-lg leading-8 text-slate-300">
                    Launch a polished merchant portal with simple local auth flows while your Jac backend evolves underneath.
                </p>
            </div>
            <div className="flex flex-col gap-3 sm:flex-row">
                <button className="rounded-2xl bg-primary px-6 py-3 text-sm font-semibold text-primary-foreground shadow-card transition hover:-translate-y-0.5 hover:bg-primary/90" onClick={props["go_signup"]}>
                    Create account
                </button>
                <button className="rounded-2xl border border-white/15 bg-white/5 px-6 py-3 text-sm font-semibold text-white transition hover:bg-white/10" onClick={props["go_login"]}>
                    Log in
                </button>
            </div>
            <div className="grid gap-4 sm:grid-cols-3">
                <div className="rounded-3xl border border-white/10 bg-white/5 p-5 shadow-soft">
                    <p className="text-3xl font-semibold text-white">24/7</p>
                    <p className="mt-2 text-sm text-slate-300">Invoice wallet creation and payout orchestration.</p>
                </div>
                <div className="rounded-3xl border border-white/10 bg-white/5 p-5 shadow-soft">
                    <p className="text-3xl font-semibold text-white">1:1</p>
                    <p className="mt-2 text-sm text-slate-300">One invoice, one wallet, one destination policy.</p>
                </div>
                <div className="rounded-3xl border border-white/10 bg-white/5 p-5 shadow-soft">
                    <p className="text-3xl font-semibold text-white">USDC</p>
                    <p className="mt-2 text-sm text-slate-300">Base Sepolia-first flow for fast MVP testing.</p>
                </div>
            </div>
        </div>
        <div className="rounded-[2rem] border border-cyan-400/20 bg-slate-950/60 p-6 shadow-card backdrop-blur">
            <div className="rounded-[1.5rem] border border-white/10 bg-gradient-to-br from-slate-900 via-slate-950 to-slate-900 p-6">
                <div className="flex items-center justify-between">
                    <div>
                        <p className="text-sm uppercase tracking-[0.28em] text-cyan-200">Settlement pulse</p>
                        <h2 className="mt-2 text-2xl font-semibold text-white">Merchant dashboard preview</h2>
                    </div>
                    <div className="rounded-full border border-emerald-400/20 bg-emerald-400/10 px-3 py-1 text-xs font-medium text-emerald-300">
                        Live
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
                            <p className="text-xs uppercase tracking-[0.24em] text-slate-400">Invoices today</p>
                            <p className="mt-3 text-3xl font-semibold text-white">42</p>
                        </div>
                        <div className="rounded-2xl border border-white/10 bg-white/5 p-4">
                            <p className="text-xs uppercase tracking-[0.24em] text-slate-400">Success rate</p>
                            <p className="mt-3 text-3xl font-semibold text-white">99.2%</p>
                        </div>
                    </div>
                    <div className="rounded-2xl border border-white/10 bg-white/5 p-4">
                        <p className="text-xs uppercase tracking-[0.24em] text-slate-400">Recent payout</p>
                        <div className="mt-3 flex items-center justify-between gap-4">
                            <div>
                                <p className="font-medium text-white">Invoice INV-2048</p>
                                <p className="text-sm text-slate-400">Sent to merchant wallet ending in 9A3F</p>
                            </div>
                            <p className="text-sm font-semibold text-emerald-300">Confirmed</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>;
}

def AuthForm(props: dict) -> JsxElement {
    form_data = props["form_data"];
    return <div className="mx-auto w-full max-w-md rounded-[2rem] border border-white/10 bg-card/90 p-8 shadow-card backdrop-blur">
        <div className="space-y-2">
            <p className="text-sm uppercase tracking-[0.28em] text-cyan-200">{str(props["eyebrow"])}</p>
            <h2 className="text-3xl font-semibold text-white">{str(props["title"])}</h2>
            <p className="text-sm leading-6 text-slate-300">{str(props["subtitle"])}</p>
        </div>
        <div className="mt-8 space-y-5">
            <div className="space-y-2">
                <label className="text-sm font-medium text-slate-200">Business email</label>
                <input className="w-full rounded-2xl border border-white/10 bg-slate-950/70 px-4 py-3 text-white outline-none transition focus:border-cyan-400/60 focus:ring-2 focus:ring-cyan-400/20" value={str(form_data["email"])} onChange={props["set_email"]} placeholder="founder@merchant.com" />
            </div>
            <div className="space-y-2">
                <label className="text-sm font-medium text-slate-200">Password</label>
                <input className="w-full rounded-2xl border border-white/10 bg-slate-950/70 px-4 py-3 text-white outline-none transition focus:border-cyan-400/60 focus:ring-2 focus:ring-cyan-400/20" type="password" value={str(form_data["password"])} onChange={props["set_password"]} placeholder="••••••••••••" />
            </div>
            {props["show_name"] and <div className="space-y-2">
                <label className="text-sm font-medium text-slate-200">Company name</label>
                <input className="w-full rounded-2xl border border-white/10 bg-slate-950/70 px-4 py-3 text-white outline-none transition focus:border-cyan-400/60 focus:ring-2 focus:ring-cyan-400/20" value={str(form_data["name"])} onChange={props["set_name"]} placeholder="Acme Commerce" />
            </div>}
            <button className="w-full rounded-2xl bg-primary px-5 py-3 text-sm font-semibold text-primary-foreground transition hover:bg-primary/90" onClick={props["submit"]}>
                {str(props["button_text"])}
            </button>
            <button className="w-full rounded-2xl border border-white/10 bg-white/5 px-5 py-3 text-sm font-semibold text-white transition hover:bg-white/10" onClick={props["go_home"]}>
                Back to landing
            </button>
        </div>
    </div>;
}

def DashboardView(props: dict) -> JsxElement {
    user = props["user"];
    metrics = props["metrics"];
    return <div className="space-y-8">
        <div className="flex flex-col gap-4 rounded-[2rem] border border-white/10 bg-card/90 p-8 shadow-card backdrop-blur lg:flex-row lg:items-center lg:justify-between">
            <div>
                <p className="text-sm uppercase tracking-[0.28em] text-cyan-200">Merchant dashboard</p>
                <h1 className="mt-3 text-4xl font-semibold text-white">Welcome back, {str(user["name"])}</h1>
                <p className="mt-3 max-w-2xl text-slate-300">
                    Monitor invoice volume, wallet creation, and payout health for your Base Sepolia settlement flow.
                </p>
            </div>
            <div className="flex flex-wrap gap-3">
                <button className="rounded-2xl bg-primary px-5 py-3 text-sm font-semibold text-primary-foreground transition hover:bg-primary/90" onClick={props["go_landing"]}>
                    View public landing
                </button>
                <button className="rounded-2xl border border-white/10 bg-white/5 px-5 py-3 text-sm font-semibold text-white transition hover:bg-white/10" onClick={props["logout"]}>
                    Log out
                </button>
            </div>
        </div>
        <div className="grid gap-4 md:grid-cols-2 xl:grid-cols-4">
            <div className="rounded-[1.75rem] border border-white/10 bg-white/5 p-6 shadow-soft">
                <p className="text-sm text-slate-400">Gross volume</p>
                <p className="mt-3 text-3xl font-semibold text-white">{str(metrics["volume"])}</p>
            </div>
            <div className="rounded-[1.75rem] border border-white/10 bg-white/5 p-6 shadow-soft">
                <p className="text-sm text-slate-400">Invoices</p>
                <p className="mt-3 text-3xl font-semibold text-white">{str(metrics["invoices"])}</p>
            </div>
            <div className="rounded-[1.75rem] border border-white/10 bg-white/5 p-6 shadow-soft">
                <p className="text-sm text-slate-400">Wallets created</p>
                <p className="mt-3 text-3xl font-semibold text-white">{str(metrics["wallets"])}</p>
            </div>
            <div className="rounded-[1.75rem] border border-white/10 bg-white/5 p-6 shadow-soft">
                <p className="text-sm text-slate-400">Payout success</p>
                <p className="mt-3 text-3xl font-semibold text-white">{str(metrics["success"])}</p>
            </div>
        </div>
        <div className="grid gap-6 lg:grid-cols-[1.1fr_0.9fr]">
            <div className="rounded-[2rem] border border-white/10 bg-card/90 p-8 shadow-card">
                <div className="flex items-center justify-between">
                    <div>
                        <p className="text-sm uppercase tracking-[0.28em] text-cyan-200">Recent activity</p>
                        <h2 className="mt-2 text-2xl font-semibold text-white">Settlement timeline</h2>
                    </div>
                    <div className="rounded-full border border-emerald-400/20 bg-emerald-400/10 px-3 py-1 text-xs font-medium text-emerald-300">
                        Healthy
                    </div>
                </div>
                <div className="mt-6 space-y-4">
                    <div className="rounded-2xl border border-white/10 bg-white/5 p-4">
                        <p className="text-sm font-medium text-white">INV-2048 funded</p>
                        <p className="mt-1 text-sm text-slate-400">Treasury reserved and invoice wallet funded with exact USDC amount.</p>
                    </div>
                    <div className="rounded-2xl border border-white/10 bg-white/5 p-4">
                        <p className="text-sm font-medium text-white">Payout broadcast</p>
                        <p className="mt-1 text-sm text-slate-400">Merchant destination allowlist matched and transaction submitted on Base Sepolia.</p>
                    </div>
                    <div className="rounded-2xl border border-white/10 bg-white/5 p-4">
                        <p className="text-sm font-medium text-white">Webhook reconciled</p>
                        <p className="mt-1 text-sm text-slate-400">Stripe payment event linked to invoice graph and audit trail updated.</p>
                    </div>
                </div>
            </div>
            <div className="rounded-[2rem] border border-white/10 bg-card/90 p-8 shadow-card">
                <p className="text-sm uppercase tracking-[0.28em] text-cyan-200">Account snapshot</p>
                <h2 className="mt-2 text-2xl font-semibold text-white">{str(user["email"])}</h2>
                <div className="mt-6 space-y-4">
                    <div className="rounded-2xl border border-white/10 bg-white/5 p-4">
                        <p className="text-sm text-slate-400">Preferred chain</p>
                        <p className="mt-2 text-lg font-semibold text-white">Base Sepolia</p>
                    </div>
                    <div className="rounded-2xl border border-white/10 bg-white/5 p-4">
                        <p className="text-sm text-slate-400">Settlement asset</p>
                        <p className="mt-2 text-lg font-semibold text-white">USDC</p>
                    </div>
                    <div className="rounded-2xl border border-white/10 bg-white/5 p-4">
                        <p className="text-sm text-slate-400">Next recommended step</p>
                        <p className="mt-2 text-sm leading-6 text-slate-300">Connect Circle credentials, configure your Base Sepolia RPC, and wire merchant wallet onboarding to backend routes later.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>;
}

def:pub AuthPortal() -> JsxElement {
    has route: str = "landing";
    has is_logged_in: bool = False;
    has user: dict = {"name": "Merchant", "email": "founder@merchant.com"};
    has form_data: dict = {"name": "", "email": "", "password": ""};
    has metrics: dict = {
        "volume": "$128.4k",
        "invoices": "342",
        "wallets": "342",
        "success": "99.2%"
    };

    can with [is_logged_in, route] entry {
        if is_logged_in and route == "landing" {
            route = "dashboard";
        }
    }

    def update_field(field: str, value: str) -> None {
        form_data = {"name": form_data["name"], "email": form_data["email"], "password": form_data["password"]};
        form_data[field] = value;
    }

    def go_to(next_route: str) -> None {
        if next_route == "landing" and is_logged_in {
            route = "dashboard";
        } else {
            route = next_route;
        }
    }

    def complete_auth(default_name: str) -> None {
        resolved_name = str(form_data["name"]);
        resolved_email = str(form_data["email"]);
        if not resolved_name.strip() {
            resolved_name = default_name;
        }
        if not resolved_email.strip() {
            resolved_email = "founder@merchant.com";
        }
        user = {"name": resolved_name, "email": resolved_email};
        is_logged_in = True;
        route = "dashboard";
    }

    def logout() -> None {
        is_logged_in = False;
        route = "landing";
    }

    return <div className="min-h-screen bg-background text-foreground">
        <div className="mx-auto flex min-h-screen w-full max-w-7xl flex-col px-6 py-6 sm:px-8 lg:px-10">
            <header className="flex flex-col gap-4 rounded-[2rem] border border-white/10 bg-white/5 px-6 py-5 shadow-soft backdrop-blur md:flex-row md:items-center md:justify-between">
                <button className="flex items-center gap-3 text-left" onClick={lambda -> None { go_to("landing"); }}>
                    <div className="flex h-12 w-12 items-center justify-center rounded-2xl bg-gradient-to-br from-cyan-400 to-blue-500 text-lg font-bold text-slate-950">J</div>
                    <div>
                        <p className="text-sm uppercase tracking-[0.28em] text-cyan-200">Jac settlement</p>
                        <p className="text-lg font-semibold text-white">Merchant Portal</p>
                    </div>
                </button>
                <nav className="flex flex-wrap items-center gap-3 text-sm">
                    <button className="rounded-full border border-white/10 px-4 py-2 text-slate-200 transition hover:bg-white/10" onClick={lambda -> None { go_to("landing"); }}>Landing</button>
                    {not is_logged_in and <button className="rounded-full border border-white/10 px-4 py-2 text-slate-200 transition hover:bg-white/10" onClick={lambda -> None { go_to("login"); }}>Login</button>}
                    {not is_logged_in and <button className="rounded-full bg-primary px-4 py-2 font-semibold text-primary-foreground transition hover:bg-primary/90" onClick={lambda -> None { go_to("signup"); }}>Sign up</button>}
                    {is_logged_in and <button className="rounded-full bg-primary px-4 py-2 font-semibold text-primary-foreground transition hover:bg-primary/90" onClick={lambda -> None { go_to("dashboard"); }}>Dashboard</button>}
                </nav>
            </header>
            <main className="flex-1 py-10 space-y-8">
                {route == "landing" and <LandingHero props={{"go_signup": lambda -> None { go_to("signup"); }, "go_login": lambda -> None { go_to("login"); }}} />}
                {route == "login" and <AuthForm props={{
                    "eyebrow": "Welcome back",
                    "title": "Log in to your merchant account",
                    "subtitle": "Access invoice activity, payout status, and wallet operations from one Jac-powered dashboard.",
                    "form_data": form_data,
                    "set_email": lambda e: any -> None { update_field("email", e.target.value); },
                    "set_password": lambda e: any -> None { update_field("password", e.target.value); },
                    "set_name": lambda e: any -> None { update_field("name", e.target.value); },
                    "show_name": False,
                    "button_text": "Log in",
                    "submit": lambda -> None { complete_auth("Merchant Operator"); },
                    "go_home": lambda -> None { go_to("landing"); }
                }} />}
                {route == "signup" and <AuthForm props={{
                    "eyebrow": "Get started",
                    "title": "Create your merchant portal",
                    "subtitle": "Set up your account, connect Circle later, and start testing your Base Sepolia settlement flow.",
                    "form_data": form_data,
                    "set_email": lambda e: any -> None { update_field("email", e.target.value); },
                    "set_password": lambda e: any -> None { update_field("password", e.target.value); },
                    "set_name": lambda e: any -> None { update_field("name", e.target.value); },
                    "show_name": True,
                    "button_text": "Create account",
                    "submit": lambda -> None { complete_auth("New Merchant"); },
                    "go_home": lambda -> None { go_to("landing"); }
                }} />}
                {route == "dashboard" and <DashboardView props={{"user": user, "metrics": metrics, "go_landing": lambda -> None { go_to("landing"); }, "logout": logout}} />}
            </main>
        </div>
    </div>;
}
