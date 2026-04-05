# Project: jactastic
## Status: DONE
## Plan
1. [x] Inspect current Jac fullstack setup and syntax
2. [x] Build graph-native backend services with nodes, edges, and public routes
3. [x] Replace countdown UI with styled settlement dashboard shell
4. [x] Add client hooks/components for invoice creation and graph views
5. [x] Start app, validate in browser, and document placeholder keys
## Files
- jac.toml — Vite/Tailwind config
- main.jac — app entry and endpoint registration for settlement routes
- services/settlement.sv.jac — graph-native nodes, edges, seed data, and public endpoints
- styles/global.css — Tailwind theme for the settlement dashboard
- components/dashboardApp.cl.jac — live dashboard showing graph data and placeholder keys
## Issues
- Browser validation passed, but preview still showed an older app snapshot; current server on :8001 returned HTTP 200 and validated successfully
## Learnings
- Endpoints should live in services/*.sv.jac and be imported in main.jac and client hooks
- Use graph relationships instead of SQL tables for invoice, wallet, merchant, and payout data
- Placeholder provider keys can be stored in a config node for MVP graph inspection
## Last Action
Built the first graph-native settlement MVP shell, started the dev server, and validated the app. Next: add interactive create-merchant/create-invoice forms and webhook simulation.