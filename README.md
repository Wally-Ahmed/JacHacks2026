# Jactastic — Countdown Timer

A single-page countdown timer built with Jac client components (React under the hood) and Tailwind CSS v4.

The UI is a dark, glassy countdown with animated bokeh particles and four circular progress rings (days / hours / minutes / seconds). You can change the target date from the in-app editor.

## Project Structure

```
build/jactastic/
├── jac.toml                          # Project config + npm deps (Tailwind + @tailwindcss/vite)
├── main.jac                          # App entry point (renders CountdownApp)
├── components/
│   └── CountdownApp.cl.jac            # Countdown UI + reactive state
└── styles/
    └── global.css                    # Tailwind import + app-specific gradients/animations
```

## Run

From this directory:

```bash
jac start main.jac
```

## What To Edit

- **Default target date**: update `target_year`, `target_month`, `target_day` in `components/CountdownApp.cl.jac`.
- **Styling**:
  - Tailwind is enabled (see `styles/global.css` with `@import "tailwindcss";` and `jac.toml` Vite plugin config).
  - App-specific visuals (gradients, bokeh animation, typography tweaks) live in `styles/global.css`.

## Jac Patterns Used

**Reactive state** (`has` fields):

```jac
has days: int = 0;
has editing: bool = False;
```

**Effect-like ability with cleanup** (`can with [...] entry`):

```jac
can with [target_year, target_month, target_day] entry {
    def tick -> None { /* recompute countdown */ }
    tick();
    id = setInterval(tick, 1000);

    def cleanup -> None { clearInterval(id); }
    return cleanup;
}
```

**List rendering** (comprehension):

```jac
{[<div key={p["id"]} /> for p in particles]}
```

## Adding npm Dependencies

```bash
jac add --cl <package-name>
```
