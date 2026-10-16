# Graph Report - devidence-home  (2026-09-11)

## Corpus Check
- 21 files · ~49,696 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 113 nodes · 108 edges · 20 communities (7 shown, 8 thin omitted)
- Extraction: 93% EXTRACTED · 7% INFERRED · 0% AMBIGUOUS · INFERRED: 8 edges (avg confidence: 0.79)
- Token cost: 52,773 input · 0 output

## Community Hubs (Navigation)
- ESLint Config
- TS/JS Compiler Config
- Dev Dependencies
- Stack & Deployment Overview
- CI/CD Pipeline
- NPM Scripts
- Button Animations & Tests
- GitHub Social Icon
- Vite Branding
- Devidence Brand
- Svelte Branding
- Graphify Workflow
- Animations Module Reference
- Robots Policy
- Medium Icon

## God Nodes (most connected - your core abstractions)
1. `compilerOptions` - 11 edges
2. `Devidence Home Landing Page README` - 8 edges
3. `scripts` - 8 edges
4. `include` - 4 edges
5. `Deploy Job (workflow_dispatch: patch/minor/major/rebuild)` - 4 edges
6. `index.html app entry point` - 4 edges
7. `vitest` - 3 edges
8. `setupButtonTracking()` - 3 edges
9. `Caddy` - 2 edges
10. `app service (devidence-home container)` - 2 edges

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
- **Docker Image Build Pattern (shared Dockerfile across CI and Compose)** — docker_compose_app_service [INFERRED 0.85]
- **Devidence Home Project Identity (name, branding, description across files)** — readme_readme [INFERRED 0.75]
- **CI/CD pipeline shipping the devidence-home static site** — github_workflows_ci_ci_job, github_workflows_deploy_deploy_job, index_app_entry [INFERRED 0.75]

## Communities (20 total, 8 thin omitted)

### Community 0 - "ESLint Config"
Cohesion: 0.12
Nodes (17): name, private, type, version, eslint, @eslint/js, eslint-plugin-svelte, globals (+9 more)

### Community 1 - "TS/JS Compiler Config"
Cohesion: 0.12
Nodes (15): compilerOptions, checkJs, esModuleInterop, isolatedModules, module, moduleResolution, resolveJsonModule, skipLibCheck (+7 more)

### Community 2 - "Dev Dependencies"
Cohesion: 0.12
Nodes (16): devDependencies, eslint, @eslint/js, eslint-plugin-svelte, globals, jsdom, svelte, svelte-check (+8 more)

### Community 3 - "Stack & Deployment Overview"
Cohesion: 0.16
Nodes (9): app service (devidence-home container), Container Security Hardening, Bun, Caddy, LinkStack Galaxy Theme, Devidence Home Landing Page README, Svelte, Vite (+1 more)

### Community 4 - "CI/CD Pipeline"
Cohesion: 0.18
Nodes (10): CI Job (push/PR trigger), Reusable workflow: ci-node.yml (devidence-dev/workflows@v1), Reusable workflow: cd-build-deploy-semver.yml (devidence-dev/workflows@v1), Deploy Job (workflow_dispatch: patch/minor/major/rebuild), Secret: HOMELAB_DEPLOY_TOKEN, Helm values file: kubernetes/internal-apps/devidence-home/values.yaml, index.html app entry point, #app mount element (+2 more)

### Community 5 - "NPM Scripts"
Cohesion: 0.25
Nodes (8): scripts, build, check, dev, lint, preview, test, test:watch

### Community 8 - "GitHub Social Icon"
Cohesion: 0.67
Nodes (3): GitHub (platform), LittleLink Icon Set, GitHub Icon (SVG)

## Knowledge Gaps
- **70 isolated node(s):** `moduleResolution`, `target`, `module`, `verbatimModuleSyntax`, `isolatedModules` (+65 more)
  These have ≤1 connection - possible missing edges or undocumented components. (Counts symbols only; 81 node(s) total have ≤1 connection when file, concept and rationale nodes are included.)
- **8 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `devDependencies` connect `Dev Dependencies` to `ESLint Config`?**
  _High betweenness centrality (0.171) - this node is a cross-community bridge._
- **Why does `vitest` connect `Button Animations & Tests` to `ESLint Config`, `Stack & Deployment Overview`?**
  _High betweenness centrality (0.162) - this node is a cross-community bridge._
- **What connects `moduleResolution`, `target`, `module` to the rest of the system?**
  _70 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `ESLint Config` be split into smaller, more focused modules?**
  _Cohesion score 0.11578947368421053 - nodes in this community are weakly interconnected._
- **Should `TS/JS Compiler Config` be split into smaller, more focused modules?**
  _Cohesion score 0.125 - nodes in this community are weakly interconnected._
- **Should `Dev Dependencies` be split into smaller, more focused modules?**
  _Cohesion score 0.125 - nodes in this community are weakly interconnected._