import from services.settlement {
    bootstrap_demo,
    create_invoice,
    create_merchant,
    get_dashboard,
    get_invoice,
    mark_invoice_paid,
    retry_payout
}

cl import ".styles.global.css";
cl import from .components.dashboardApp { DashboardApp }

cl {
    def:pub app() -> JsxElement {
        return <DashboardApp />;
    }
}
