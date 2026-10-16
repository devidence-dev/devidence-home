# Spec Delta

## Purpose

Defines the visual language of the landing page (dark palette, typography, surfaces, starfield background, footer, motion and legibility) so it matches the shared devidence style used by the other devidence projects.

## ADDED Requirements

### Requirement: Shared devidence dark palette
The page SHALL use the shared devidence dark palette: a `#04101A` background token and a `#EAF2F8` ink token, with the cyan/blue accent family for interactive elements. The body background SHALL be `radial-gradient(ellipse at bottom, #223344, #090a0f)`, and the document SHALL declare `<meta name="color-scheme" content="dark">` so browser-rendered UI (scrollbars, form controls) is dark.

#### Scenario: Dark palette tokens
- **WHEN** the page renders
- **THEN** the background token resolves to `#04101A` and body text to `#EAF2F8`

#### Scenario: Body gradient
- **WHEN** the page renders
- **THEN** the body background is the radial gradient from `#223344` at the bottom center to `#090a0f`

#### Scenario: Native UI is dark
- **WHEN** the page renders
- **THEN** browser-rendered controls and scrollbars use their dark appearance

### Requirement: Self-hosted Geist typography
The page SHALL render text in Geist and monospace text in Geist Mono, served from the site's own origin with a system-font fallback, and SHALL NOT request fonts from third-party hosts.

#### Scenario: Fonts load from own origin
- **WHEN** the page is loaded under the site's CSP (`font-src 'self'`)
- **THEN** Geist renders and no font request goes to another origin

#### Scenario: Font failure
- **WHEN** the font files fail to load
- **THEN** text remains readable in the fallback system font

### Requirement: Glass surfaces over the starfield
The page SHALL present the social links and the modal as translucent glass surfaces over the starfield background (the star layers and shooting stars in `Background.svelte`).

#### Scenario: Social links as glass buttons
- **WHEN** the page loads
- **THEN** the Medium and GitHub links render as glass-style buttons that show distinct hover, focus-visible and active states

#### Scenario: No backdrop-filter support
- **WHEN** the browser does not support `backdrop-filter`
- **THEN** surfaces fall back to an opaque tinted background and stay legible

### Requirement: Footer with legal navigation
The page SHALL end with a semantic `<footer>` anchored to the bottom of the viewport. It SHALL contain a `<nav aria-label="Legal">` with Terms and Privacy as buttons that open the modals, muted text, and a copyright line "© <year> devidence". The footer SHALL NOT contain a "Home" link.

#### Scenario: Legal navigation landmark
- **WHEN** a screen reader lists the page landmarks
- **THEN** the footer exposes a navigation landmark named "Legal" containing Terms and Privacy

#### Scenario: Legal buttons open modals
- **WHEN** the visitor activates the Terms or Privacy button
- **THEN** the matching modal opens, and the controls are `<button>` elements rather than links

#### Scenario: Copyright line
- **WHEN** the footer renders
- **THEN** it shows "© <year> devidence" with the current year and in muted text that meets the contrast requirement

#### Scenario: Footer anchored to the viewport bottom
- **WHEN** the content is shorter than the viewport
- **THEN** the footer sits at the bottom of the viewport, and when the content is taller it follows the content

#### Scenario: No Home link
- **WHEN** the footer is rendered
- **THEN** no "Home" link is present

### Requirement: Legible contrast
Text and interactive elements SHALL meet WCAG AA contrast (4.5:1 for body text, 3:1 for large text and UI boundaries) against their surfaces.

#### Scenario: Contrast on the dark surfaces
- **WHEN** text, links, footer text and button labels are measured against their backgrounds
- **THEN** each meets the AA thresholds

### Requirement: Respect reduced motion
The page SHALL disable or minimize decorative animation (entrance effects, starfield drift and shooting stars) when the visitor prefers reduced motion.

#### Scenario: Reduced motion enabled
- **WHEN** `prefers-reduced-motion: reduce` is set
- **THEN** no decorative animation runs and all content is visible immediately

### Requirement: Existing content and links preserved
The redesign SHALL keep the profile name, verified badge, description, the Medium and GitHub links, and the Terms and Privacy modals, with unchanged destinations and text.

#### Scenario: Links unchanged
- **WHEN** the page is rendered
- **THEN** the Medium link points to `https://medium.com/@devidence` and the GitHub link to `https://github.com/devidence-dev`, both opening in a new tab with `rel="noopener noreferrer"`

#### Scenario: Modal still works
- **WHEN** the visitor opens Terms or Privacy
- **THEN** the modal shows the same content and closes by button, backdrop click or Escape

### Requirement: Responsive layout
The page SHALL stay usable and free of horizontal scrolling from 320 px wide up to desktop widths.

#### Scenario: Small phone
- **WHEN** the viewport is 320 px wide
- **THEN** the logo, profile text, buttons and footer fit without horizontal scroll
