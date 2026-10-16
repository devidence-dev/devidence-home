# Proposal

## Why

The landing page still uses the old "galaxy" look: a Skeleton-derived stylesheet (820 lines), a Karla font and a PNG avatar. The rest of the devidence projects (voraz-bot, automation-hub, the dependency report in `devidence-info/`) already share a newer identity: cyan/blue palette, glass surfaces, Geist type and Tailwind v4. This page should match that identity in its dark form, keep its starfield, and use the new logo and icon assets that are ready.

## What Changes

- Add Tailwind CSS v4 (CSS-first config, `@tailwindcss/vite` plugin) and move the page styling to utilities plus a small token layer (`:root` variables exposed through `@theme inline`), the same structure voraz-bot and automation-hub use.
- Replace the palette with the shared dark token set (bg `#04101A`, ink `#EAF2F8`, accent `#7FD9EA`, cyan `#16CBE7`, blue `#0A84FF`) on a radial-gradient body (`radial-gradient(ellipse at bottom, #223344, #090a0f)`), with glass cards/buttons (`backdrop-filter`).
- Dark only: no light theme, no theme toggle, no persisted choice and no pre-paint script. The page declares `<meta name="color-scheme" content="dark">`.
- Self-host Geist and Geist Mono (woff2) and remove Karla. Google Fonts cannot be used: the Caddy CSP only allows `font-src 'self'`.
- Replace the PNG avatar with a white flat moon: a 248px circle (`size-62`) with a crescent shadow, grey maria patches (`public/images/moon-maria.svg`) and shaded craters (`public/images/moon-craters.svg`), carrying the single logo `public/images/devidence-logo-light.svg` (dark wordmark, alt "devidence") with a subtle grey drop-shadow. The C2PA metadata is stripped from the logo.
- Use `devidence-icon.svg` as the favicon. Produce the `favicon.ico`, `favicon-32x32.png` and `apple-touch-icon.png` fallbacks from it instead of from `devidence-logo.png` (today the Dockerfile builds them from the PNG).
- Replace the footer with a semantic `<footer>` containing `<nav aria-label="Legal">` with Terms and Privacy buttons that open the modals, muted text and "© <year> devidence", anchored to the bottom of the viewport. The "Home" link is removed.
- Remove the Skeleton CSS (`brands.css` deleted, `skeleton-auto.css` renamed to `stars.css` with the starfield rules only) and the old star markup. The starfield itself is kept: `Background.svelte` keeps its star layers and shooting stars. Keep the entrance animations and `prefers-reduced-motion` handling.
- **BREAKING** (visual only): new palette, typography, moon avatar and footer. No routes, URLs or content change.

## Capabilities

### New Capabilities
- `brand-assets`: the logo shown on the moon avatar and the favicon set served by the site.
- `landing-page-ui`: the visual language of the landing page: shared dark palette tokens, Geist typography, glass surfaces over the starfield, the footer, contrast and reduced-motion behavior.

### Modified Capabilities
<!-- None. openspec/specs/ is empty, so there is no existing spec to modify. -->

## Impact

- **Code:** `index.html`, `src/main.js`, `src/app.css`, `src/App.svelte`, `src/lib/{Background,Profile,SocialButton,Footer,Modal}.svelte`; delete `src/assets/styles/brands.css` and replace `skeleton-auto.css` with `stars.css`; trim `animations.css`. Existing tests (`SocialButton.test.js`, `animations.test.js`) need updating where class names change, and `Profile.test.js` covers the avatar.
- **New files:** the moon avatar SVGs (`public/images/moon-maria.svg`, `public/images/moon-craters.svg`), the logo and icon SVGs, font files.
- **Dependencies (need approval before install):** `tailwindcss`, `@tailwindcss/vite`, and a Geist font source (for example `@fontsource-variable/geist` and `@fontsource-variable/geist-mono`, the same route the current Karla files came from).
- **Deploy/security:** No theme script exists, so the Caddy CSP needs no change. `style-src 'unsafe-inline'` is already allowed, so Tailwind output and Svelte scoped styles are fine. The `Dockerfile` favicon/webp steps that read `public/images/devidence-logo.png` must be updated, and the image build must still pass (`bun run build`).
- **Out of scope:** new pages or content, a light theme, SSR, analytics, a router, and changes to the social links or the Terms/Privacy text.
