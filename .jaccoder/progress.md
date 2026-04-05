# Project: crypto_settlement_backend
## Status: DONE
## Plan
1. [x] Inspect current Jac project and syntax docs
2. [x] Create graph-native backend service files
3. [x] Register backend routes in main.jac
4. [x] Run Jac validation and fix syntax/runtime issues
## Files
- main.jac — backend endpoint registration + minimal app shell
- services/config.sv.jac — provider config nodes and bootstrap
- services/platform.sv.jac — platform root helpers
- services/merchant.sv.jac — merchants and merchant wallets
- services/invoice.sv.jac — invoice graph and lookup routes
- services/payment.sv.jac — checkout sessions and webhook events
- services/wallets.sv.jac — per-invoice wallet lifecycle
- services/settlement.sv.jac — treasury lots and payouts
- services/audit.sv.jac — ledger and audit events
## Issues
- Existing project was still a countdown frontend; backend files were missing.
- Direct CLI endpoint smoke test was limited, so validation relied on successful Jac compile/HMR and browser render.
## Learnings
- Backend endpoints belong in services/*.sv.jac and must be imported in main.jac to register.
- Typed node returns compile cleanly for graph-native backend modeling.
## Last Action
Completed backend graph structure, registered routes, and validated the app preview renders with the new backend shell.