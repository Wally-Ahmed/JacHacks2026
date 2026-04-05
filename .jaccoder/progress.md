# Progress

## Plan
- Inspect current AuthPortal client component and app imports.
- Replace invalid/legacy JSX patterns with current Jac frontend syntax.
- Keep local MVP auth state only with landing, login, signup, and dashboard views.
- Add redirect effect from landing to dashboard when logged in.
- Start app and validate browser render.

## Files
- components/AuthPortal.cl.jac

## Issues
- Existing component used unsupported patterns like ternary JSX, fragment syntax, and non-typed `has` locals inside helper components.

## Learnings
- Jac client components should prefer `has` state with explicit types, `def` methods, `can with [deps] entry` for effects, and conditional rendering with `and`.
