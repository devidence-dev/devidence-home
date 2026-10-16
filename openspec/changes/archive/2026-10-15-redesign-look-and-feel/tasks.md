# Tasks

## 1. Dependencies and tooling

Run the apply session inside the devcontainer (bun available, `bun install` already run by `postCreateCommand`). Steps that need Docker (3.2, 5.3) run from the host.

- [x] 1.1 Inside the devcontainer, with user approval, run `bun add -d tailwindcss @tailwindcss/vite @fontsource-variable/geist @fontsource-variable/geist-mono`; verify `bun install --frozen-lockfile` succeeds and `bun.lock` lists them.
- [x] 1.2 Register the Tailwind plugin in `vite.config.js` and replace the top of `src/app.css` with `@import "tailwindcss";`; verify `bun run build` passes and the output CSS contains Tailwind utilities.

## 2. Tokens and fonts

- [x] 2.1 Add the dark token block to `src/app.css` (values from the token table in design.md, not from `devidence-info/`, which is temporary: `:root` with the dark values only, no `data-theme` or `prefers-color-scheme` branch) plus `@theme inline`, `color-scheme: dark`, `@utility glass` with `@supports` fallback; verify in devtools that the background and text colors match the spec values (`#04101A`, `#EAF2F8`).
- [x] 2.2 Import Geist and Geist Mono from `src/main.js`, set `--font-sans` / `--font-mono` with system fallbacks, delete `public/fonts/karla-*`; verify in the network tab that fonts load from the same origin and no Karla file remains referenced (`grep -ri karla src public index.html` is empty).
- [x] 2.3 Set `<meta name="color-scheme" content="dark">` in the `<head>` of `index.html`; verify the document declares a dark color scheme (dark scrollbars and form controls) and no theme script or `dv-theme` reference remains (`grep -rn "theme-init\|dv-theme\|data-theme" index.html src public` is empty).

## 3. Assets and branding

- [x] 3.1 Move the logo and icon SVGs out of `devidence-info/` to their final paths (`devidence-logo-light.svg` to `public/images/`, `devidence-icon.svg` to `public/favicon.svg`, replacing the old one), stripping the `c2pa:manifest` element on the way; verify with `grep -c c2pa` returning 0 for each, `wc -c` under 10 KB, a diff showing only the metadata removed, and the originals gone from `devidence-info/` (leave `reporte-dependencias.html` alone).
- [x] 3.2 From the host, using `docker run` (not the devcontainer), check whether ImageMagick in the Alpine builder renders `public/favicon.svg` to 32x32 PNG, 180x180 PNG and multi-size ICO; if yes, point the `Dockerfile` favicon step at the SVG and drop the logo webp conversion, otherwise commit the three fallbacks to `public/` and remove the step; verify with a local `docker build` that `favicon.ico`, `favicon-32x32.png` and `apple-touch-icon.png` exist in the final image and show the new icon.
- [x] 3.3 Update the `<head>` icon links in `index.html` (SVG primary, ico/png/apple-touch fallbacks); verify every icon URL returns 200 against `bun run preview` or the built image.

## 4. Component migration

- [x] 4.1 Restore `Background.svelte` as the starfield: the `#object1`-`#object3` star layers (box-shadow stars rising via `@keyframes animStar`) and 4 shooting stars, styled in `src/assets/styles/stars.css`, on the body background `radial-gradient(ellipse at bottom, #223344, #090a0f)` (no mesh gradient); verify it renders and `animations.test.js` still passes (update it if it referenced removed code).
- [x] 4.2 Rewrite `Profile.svelte` to show the logo `devidence-logo-light.svg` (alt "devidence", announced once) on a white flat moon avatar: 248px circle (`size-62`) with a crescent shadow, `moon-maria.svg` and `moon-craters.svg`, and a subtle grey drop-shadow on the logo; keep the name, verified badge and description; remove the webp/png fallback logic from `App.svelte`; verify a `Profile.test.js` checks the accessible name and that the avatar renders the logo and moon artwork.
- [x] 4.3 Rewrite `SocialButton.svelte` and `brands.css` usage as glass buttons with hover, focus-visible and active states, keeping `id`, `button-click` class, `target="_blank"` and `rel`; verify `SocialButton.test.js` (updated for new classes) and `animations.test.js` pass.
- [x] 4.4 Rewrite `App.svelte` layout (replace Skeleton `container/row/column`) and `Footer.svelte` as a semantic `<footer>` with `<nav aria-label="Legal">` holding Terms and Privacy as `<button>` elements that open the modals, muted text and "© <year> devidence", anchored to the bottom of the viewport; remove the "Home" link. Verify with `grep -rn "container\|\"row\"\|\"column\"" src` that no Skeleton class remains, the layout fits at 320 px without horizontal scroll, and the footer exposes the "Legal" landmark.
- [x] 4.5 Re-skin `Modal.svelte` and the Terms/Privacy content with the dark tokens (glass panel, readable headings and lists after the Tailwind reset); verify Escape and backdrop click still close it and text contrast is AA.
- [x] 4.6 Reduced motion: wrap entrance animations and starfield motion (star drift, shooting stars) in `prefers-reduced-motion` handling; verify with the devtools emulation that no decorative animation runs and content is visible.

## 5. Cleanup and integration

- [x] 5.1 Remove Skeleton and brand CSS: delete `brands.css`, replace `skeleton-auto.css` with `stars.css` (starfield rules only), update their imports in `src/main.js`, trim `animations.css`; verify `bun run build` passes and the CSS bundle is smaller than before (compare `dist/assets/*.css` sizes).
- [x] 5.2 Run `bun run lint`, `bun run check` and `bun run test`; verify all pass with no new warnings.
- [x] 5.3 Full image check, from the host: `docker build` the image and run it with the real Caddyfile; verify at 320 px, 768 px and desktop that there are no CSP violations in the console, fonts and icons load from the same origin, contrast is AA (devtools audit), the footer Terms/Privacy buttons open the modals, and the Medium/GitHub links work.
- [x] 5.4 Update `README.md` (stack, dark styling, how to change tokens and regenerate favicons) and run `graphify update .`; verify the README commands run as written.

## Workflow follow-up

- Review the dark page on a real phone before merging.
- Archive the change (`/opsx:archive`) after review and deploy.
