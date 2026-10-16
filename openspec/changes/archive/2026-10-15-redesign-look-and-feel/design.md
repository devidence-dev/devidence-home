# Design

## Context

Today the page is a Svelte 5 + Vite SPA served by Caddy from `/srv`. Styling comes from `src/app.css`, the Skeleton-derived `skeleton-auto.css` (820 lines, now reduced to the starfield and renamed `stars.css`), `brands.css` and `animations.css`, plus scoped styles in each component. The look is dark-only and keeps the starfield (star layers, shooting stars, Karla replaced). See proposal.md for motivation.

Constraints found while reading the repo and the two reference projects:

- `Caddyfile` CSP: `script-src 'self'`, `font-src 'self' data:`, `style-src 'self' 'unsafe-inline'`. No inline scripts, no Google Fonts.
- `Dockerfile` builds `favicon.ico`, `favicon-32x32.png`, `apple-touch-icon.png` and `.webp` avatars from `public/images/devidence-logo.png` with ImageMagick/cwebp, then runs `bun install --frozen-lockfile` and `bun run build`.
- `animations.js` tracks clicks through the `button-click` class and link `id`; `animations.test.js` and `SocialButton.test.js` depend on those.
- voraz-bot and automation-hub are Go/templ servers, not Svelte. Only their CSS conventions transfer: Tailwind v4 CSS-first and tokens in `:root` exposed with `@theme inline`. The `devidence-info/reporte-dependencias.html` page holds the exact token values.
- `devidence-logo-light.svg` (dark wordmark, `#0B1B25`/`#334C5A`) is the only logo used, on the white moon avatar. `devidence-icon.svg` is a rounded square with a gradient. Each SVG carries about 13 KB of C2PA base64 metadata.

`devidence-info/` is a temporary folder, so nothing in this change may depend on it staying. The SVGs are moved to their final place in `public/` (see D4/tasks 3.1) and the dark token values are recorded here:

| Token | Value |
|---|---|
| `--bg` | `#04101A` |
| `--ink` | `#EAF2F8` |
| `--ink-2` | `#C9D8E2` |
| `--muted` | `#9FB6C6` |
| `--accent` | `#7FD9EA` |
| `--glass` | `rgba(255,255,255,.05)` |
| `--edge` | `rgba(255,255,255,.1)` |
| `--line` | `rgba(255,255,255,.07)` |

Body background is `radial-gradient(ellipse at bottom, #223344, #090a0f)`. Glass blur is `blur(24px) saturate(160%)`. Radii: pills `999px`, cards `20-26px`. Fonts: Geist (300-600) and Geist Mono (400-500).

## Goals / Non-Goals

**Goals:**
- One token layer shared in name and value with the other devidence projects, so a future change to the palette is a copy, not a redesign.
- Keep the starfield identity while moving the page to the shared tokens and glass surfaces.
- Smaller CSS shipped than today (drop Skeleton).

**Non-Goals:**
- A light theme, a theme toggle or theme persistence.
- Server-side rendering or a build-time theme.
- A shared npm package for the tokens across repos.
- Redesigning copy, adding pages or changing the Terms/Privacy text.

## Decisions

### D1. Tailwind v4 through `@tailwindcss/vite`, CSS-first
Add `tailwindcss` and `@tailwindcss/vite`, register the plugin in `vite.config.js`, and start `src/app.css` with `@import "tailwindcss";`. Tokens live in `:root` / `@theme inline` like voraz-bot (`--color-ink: var(--ink)` and so on), so utilities such as `bg-bg` and `text-ink` resolve to the dark tokens.
*Alternatives:* the Tailwind CLI as in the Go repos (needs a second build step, and Vite already exists here); plain CSS variables only (no utilities, keeps hand-written CSS). The Vite plugin is the smallest change for a Vite project.

### D2. Dark only, no theme switching
The dark tokens are the only values in `:root`. There is no `data-theme` attribute, no `prefers-color-scheme` branch, no toggle, no `localStorage` key and no pre-paint script. `<meta name="color-scheme" content="dark">` keeps native UI (scrollbars, form controls) dark.
*Alternatives:* a light theme with system/light/dark switching, as in voraz-bot. Rejected by the user: the page ships dark only, so the theme-switching capability is dropped.

### D3. Starfield kept as the page background
`Background.svelte` keeps the original starfield: the `#object1`-`#object3` star layers built from `box-shadow` stars that rise via `@keyframes animStar`, plus 4 shooting stars, styled in `src/assets/styles/stars.css`. The body background is the radial gradient from design Context. No mesh gradient is used.
*Alternative:* a CSS mesh gradient (the first plan). Rejected by the user: the original starfield is restored.

### D4. One logo on a white moon avatar
The avatar is a 248px circle (`size-62`) with a crescent shadow, a white flat disc, grey maria patches from `public/images/moon-maria.svg` and shaded craters from `public/images/moon-craters.svg`. The single logo `public/images/devidence-logo-light.svg` (alt "devidence") sits on it with a subtle grey drop-shadow. There is no logo swap, so no theme selectors or JS are involved. The logo file is optimized (C2PA metadata removed), and all three SVGs are referenced by URL and cached by Caddy.
*Alternatives:* keep the PNG avatar (the current state, rejected by the user); recolor an inline SVG with CSS variables (needs a modified SVG and loses the supplied artwork).

### D5. Favicon from the SVG icon
`public/favicon.svg` is replaced by the cleaned `devidence-icon.svg`. The `Dockerfile` favicon step is pointed at that SVG so `favicon.ico`, `favicon-32x32.png` and `apple-touch-icon.png` keep being generated at build time. ImageMagick's SVG support in Alpine may be limited, so the first task checks it. If it fails, the three fallbacks are committed as static files in `public/` and the Dockerfile step is removed. The webp conversion of `public/images` is dropped for the logos (SVG) and kept only if other raster images remain.
*Alternative:* always commit the PNG/ICO. Simpler but adds binaries to git; decide after the check.

### D6. Self-hosted Geist
Use `@fontsource-variable/geist` and `@fontsource-variable/geist-mono` (the existing Karla files came from fontsource too), imported from `main.js` so Vite bundles hashed woff2 files served from `'self'`. Delete the Karla files in `public/fonts/`. Latin subsets only.
*Alternative:* copy woff2 files by hand into `public/fonts/`. Same result, no version tracking.

### D7. Component migration order and what stays
Rewrite the components with utility classes, delete `brands.css`, and replace `skeleton-auto.css` with `stars.css` (starfield rules only) once nothing references the Skeleton classes. Keep:
- the `button-click` class and link `id`s (tracking + tests),
- the entrance animations (kept as small CSS keyframes in `app.css`, gated by `prefers-reduced-motion`),
- `Modal.svelte` behavior (Escape, backdrop click), re-skinned with the dark tokens,
- the footer's legal navigation: Terms and Privacy as `<button>` elements in `<nav aria-label="Legal">`, muted text and "© <year> devidence". The "Home" link is removed.

### D8. Glass with fallback
Glass utilities (`@utility glass`, as in automation-hub) use `backdrop-filter: blur(24px) saturate(160%)` with an `@supports not (backdrop-filter: …)` opaque fallback.

### D9. Run the implementation inside the devcontainer
Dependency changes and day-to-day commands (`bun add`, `bun run dev|build|lint|check|test`) run inside the existing devcontainer (`oven/bun:1.4.3-slim`, `postCreateCommand: bun install`), not on the host, which has no bun. This follows the project's container-first rule and keeps `bun.lock` produced by the same bun version as the Dockerfile. The devcontainer has neither Docker nor ImageMagick, so the two steps that need them (favicon rendering check, full image build) run from the host with `docker run` / `docker build`. Adding the `docker-outside-of-docker` feature to the devcontainer would remove that split, but it changes the container for everyone and is not part of this change.

## Risks / Trade-offs

- [Visual regressions are hard to catch with the current unit tests] → Review the dark page manually at 320 px, 768 px and desktop; run `svelte-check`, `eslint` and `vitest`.
- [Tailwind preflight resets change default element styling in the modal/legal text] → Check `TermsContent`/`PrivacyContent` after migration and add prose-like styles for headings and lists.
- [Dropping Skeleton may break layout classes (`container`, `row`, `column`) used in `App.svelte`] → Replace them in the same task as the layout rewrite, grep for leftovers before deleting the CSS.
- [New dependencies change `bun.lock` and the Docker build] → Install only after user approval, run `bun install --frozen-lockfile` and the full image build locally in Docker to confirm.
- [ImageMagick may not render the SVG icon cleanly in the Alpine image] → See D5 fallback.
- [Stripping C2PA metadata alters the files the user supplied, and `devidence-info/` is temporary] → Move each SVG to its final path in `public/` as a cleaned file and remove the original from `devidence-info/`. Only the metadata element is removed, not paths or fills (verify with a diff of the remaining markup before moving). `reporte-dependencias.html` is not touched; its token values are recorded in Context.
- [`backdrop-filter` cost on low-end phones] → Limit glass to the buttons and the modal, no full-screen blur layers.
- [Starfield animation cost on low-end phones] → The star layers are CSS-only and are disabled under `prefers-reduced-motion` (task 4.6).

## Migration Plan

1. Land the change on a feature branch; the site is static, so rollback is reverting the merge and redeploying the previous image.
2. Verify with `bun run build` and `docker build` locally, then open the built page under the real Caddy config (the CSP is the main risk).
3. Deploy through the existing `deploy.yml` workflow after review.

## Open Questions

None. The theme toggle question is resolved: the page is dark only, with no toggle.
