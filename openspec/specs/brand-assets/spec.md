# brand-assets Specification

## Purpose

Defines the logo the landing page shows on its moon avatar, the lightweight SVG assets it serves, and the favicon set, so the devidence brand appears consistently in the page and in browser chrome.

## Requirements

### Requirement: Single logo on a moon avatar
The page SHALL show the devidence logo (`devidence-logo-light.svg`, dark wordmark) over a white flat moon avatar, and SHALL give the logo an accessible text alternative. The moon SHALL be a 248px circle (`size-62`) with a crescent shadow, grey maria patches from `moon-maria.svg` and shaded craters from `moon-craters.svg`. The logo SHALL carry a subtle grey drop-shadow.

#### Scenario: Logo on the moon
- **WHEN** the page loads
- **THEN** the devidence logo is visible on the moon avatar and no other logo variant is rendered

#### Scenario: Moon artwork
- **WHEN** the avatar is rendered
- **THEN** the maria and craters are drawn over the white disc inside its crescent shadow, at 248px

#### Scenario: Accessible name
- **WHEN** a screen reader reaches the logo
- **THEN** it is announced as "devidence" (or equivalent) exactly once

### Requirement: Lightweight logo assets
The logo, moon and icon SVG files served by the site SHALL NOT contain embedded provenance metadata (C2PA manifests) and SHALL stay small enough not to dominate the page weight.

#### Scenario: Metadata stripped
- **WHEN** a served logo, moon or icon SVG is inspected
- **THEN** it contains no `c2pa:manifest` element

#### Scenario: Size budget
- **WHEN** the logo, moon and icon SVGs are measured
- **THEN** each is under 10 KB uncompressed

### Requirement: SVG favicon with fallbacks
The site SHALL serve `devidence-icon.svg` as its primary favicon and SHALL also serve `favicon.ico`, a 32x32 PNG and a 180x180 apple-touch-icon derived from the same icon, all referenced from the document head.

#### Scenario: Modern browser
- **WHEN** a browser that supports SVG icons loads the page
- **THEN** it displays the new icon in the tab

#### Scenario: Legacy and iOS
- **WHEN** a browser requests `/favicon.ico` or the apple-touch-icon
- **THEN** the server returns a valid image of the new icon (not the old logo)

#### Scenario: No broken icon links
- **WHEN** every icon URL referenced in the document head is requested
- **THEN** each returns HTTP 200
