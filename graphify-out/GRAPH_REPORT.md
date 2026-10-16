# Graph Report - devidence-home  (2026-10-15)

## Corpus Check
- 46 files · ~89,409 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 230 nodes · 214 edges · 35 communities (14 shown, 6 thin omitted)
- Extraction: 96% EXTRACTED · 4% INFERRED · 0% AMBIGUOUS · INFERRED: 8 edges (avg confidence: 0.79)
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `53cbba7d`
- Run `git rev-parse HEAD` and compare to check if the graph is stale.
- Run `graphify update .` after code changes (no API cost).

## Community Hubs (Navigation)
- package.json
- compilerOptions
- devDependencies
- Devidence Home Landing Page README
- Deploy Job (workflow_dispatch: patch/minor/major/rebuild)
- scripts
- ADDED Requirements
- Decisions
- GitHub Icon (SVG)
- Vite Build Tool
- Devidence Brand Identity
- Svelte Framework
- Graphify Knowledge Graph Workflow
- ADDED Requirements
- robots.txt - allow-all crawler policy
- Medium Logo Icon
- openspec-explore/SKILL.md
- explore.md
- Proposal
- Tasks

## God Nodes (most connected - your core abstractions)
1. `compilerOptions` - 11 edges
2. `Decisions` - 10 edges
3. `ADDED Requirements` - 9 edges
4. `scripts` - 8 edges
5. `Devidence Home Landing Page README` - 8 edges
6. `Design` - 7 edges
7. `Tasks` - 7 edges
8. `Requirement: Footer with legal navigation` - 6 edges
9. `Proposal` - 5 edges
10. `vitest` - 4 edges

## Surprising Connections (you probably didn't know these)
- `index.html app entry point` --references--> `favicon.svg - shield/badge emblem with checkmark`  [EXTRACTED]
  index.html → public/favicon.svg
- `Caddy` --conceptually_related_to--> `app service (devidence-home container)`  [INFERRED]
  README.md → docker-compose.yml
- `CI Job (push/PR trigger)` --conceptually_related_to--> `index.html app entry point`  [INFERRED]
  .github/workflows/ci.yml → index.html
- `Deploy Job (workflow_dispatch: patch/minor/major/rebuild)` --conceptually_related_to--> `index.html app entry point`  [INFERRED]
  .github/workflows/deploy.yml → index.html

## Import Cycles
- None detected.

## Hyperedges (group relationships)
- **Devidence Home Project Identity (name, branding, description across files)** — readme_readme [INFERRED 0.75]
- **CI/CD pipeline shipping the devidence-home static site** — github_workflows_ci_ci_job, github_workflows_deploy_deploy_job, index_app_entry [INFERRED 0.75]
- **Docker Image Build Pattern (shared Dockerfile across CI and Compose)** — docker_compose_app_service [INFERRED 0.85]

## Communities (35 total, 6 thin omitted)

### Community 0 - "package.json"
Cohesion: 0.09
Nodes (23): #app mount element, name, private, type, version, eslint, @eslint/js, eslint-plugin-svelte (+15 more)

### Community 1 - "compilerOptions"
Cohesion: 0.15
Nodes (12): compilerOptions, checkJs, esModuleInterop, isolatedModules, module, moduleResolution, resolveJsonModule, skipLibCheck (+4 more)

### Community 2 - "devDependencies"
Cohesion: 0.10
Nodes (20): devDependencies, eslint, @eslint/js, eslint-plugin-svelte, @fontsource-variable/geist, @fontsource-variable/geist-mono, globals, jsdom (+12 more)

### Community 3 - "Devidence Home Landing Page README"
Cohesion: 0.10
Nodes (11): app service (devidence-home container), Container Security Hardening, Bun, Caddy, LinkStack Galaxy Theme, Devidence Home Landing Page README, Svelte, Vite (+3 more)

### Community 4 - "Deploy Job (workflow_dispatch: patch/minor/major/rebuild)"
Cohesion: 0.25
Nodes (8): CI Job (push/PR trigger), Reusable workflow: ci-node.yml (devidence-dev/workflows@v1), Reusable workflow: cd-build-deploy-semver.yml (devidence-dev/workflows@v1), Deploy Job (workflow_dispatch: patch/minor/major/rebuild), Secret: HOMELAB_DEPLOY_TOKEN, Helm values file: kubernetes/internal-apps/devidence-home/values.yaml, index.html app entry point, favicon.svg - shield/badge emblem with checkmark

### Community 5 - "scripts"
Cohesion: 0.25
Nodes (8): scripts, build, check, dev, lint, preview, test, test:watch

### Community 6 - "ADDED Requirements"
Cohesion: 0.07
Nodes (28): ADDED Requirements, Purpose, Requirement: Existing content and links preserved, Requirement: Footer with legal navigation, Requirement: Glass surfaces over the starfield, Requirement: Legible contrast, Requirement: Respect reduced motion, Requirement: Responsive layout (+20 more)

### Community 7 - "Decisions"
Cohesion: 0.12
Nodes (16): Context, D1. Tailwind v4 through `@tailwindcss/vite`, CSS-first, D2. Dark only, no theme switching, D3. Starfield kept as the page background, D4. One logo on a white moon avatar, D5. Favicon from the SVG icon, D6. Self-hosted Geist, D7. Component migration order and what stays (+8 more)

### Community 8 - "GitHub Icon (SVG)"
Cohesion: 0.67
Nodes (3): GitHub (platform), LittleLink Icon Set, GitHub Icon (SVG)

### Community 13 - "ADDED Requirements"
Cohesion: 0.13
Nodes (14): ADDED Requirements, Purpose, Requirement: Lightweight logo assets, Requirement: Single logo on a moon avatar, Requirement: SVG favicon with fallbacks, Scenario: Accessible name, Scenario: Legacy and iOS, Scenario: Logo on the moon (+6 more)

### Community 18 - "openspec-explore/SKILL.md"
Cohesion: 0.17
Nodes (11): Check for context, Ending Discovery, Guardrails, Handling Different Entry Points, OpenSpec Awareness, Planning a Change, The Stance, What You Don't Have To Do (+3 more)

### Community 20 - "explore.md"
Cohesion: 0.18
Nodes (10): Check for context, Ending Discovery, Guardrails, OpenSpec Awareness, Planning a Change, The Stance, What You Don't Have To Do, What You Might Do (+2 more)

### Community 21 - "Proposal"
Cohesion: 0.25
Nodes (7): Capabilities, Impact, Modified Capabilities, New Capabilities, Proposal, What Changes, Why

### Community 22 - "Tasks"
Cohesion: 0.25
Nodes (7): 1. Dependencies and tooling, 2. Tokens and fonts, 3. Assets and branding, 4. Component migration, 5. Cleanup and integration, Tasks, Workflow follow-up

## Knowledge Gaps
- **142 isolated node(s):** `moduleResolution`, `target`, `module`, `verbatimModuleSyntax`, `isolatedModules` (+137 more)
  These have ≤1 connection - possible missing edges or undocumented components. (Counts symbols only; 169 node(s) total have ≤1 connection when file, concept and rationale nodes are included.)
- **6 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `devDependencies` connect `devDependencies` to `package.json`?**
  _High betweenness centrality (0.057) - this node is a cross-community bridge._
- **Why does `scripts` connect `scripts` to `package.json`?**
  _High betweenness centrality (0.023) - this node is a cross-community bridge._
- **What connects `moduleResolution`, `target`, `module` to the rest of the system?**
  _142 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `package.json` be split into smaller, more focused modules?**
  _Cohesion score 0.0873015873015873 - nodes in this community are weakly interconnected._
- **Should `devDependencies` be split into smaller, more focused modules?**
  _Cohesion score 0.1 - nodes in this community are weakly interconnected._
- **Should `Devidence Home Landing Page README` be split into smaller, more focused modules?**
  _Cohesion score 0.09846153846153846 - nodes in this community are weakly interconnected._
- **Should `ADDED Requirements` be split into smaller, more focused modules?**
  _Cohesion score 0.06896551724137931 - nodes in this community are weakly interconnected._