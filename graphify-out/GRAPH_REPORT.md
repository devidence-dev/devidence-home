# Graph Report - .  (2026-07-14)

## Corpus Check
- Corpus is ~49,418 words - fits in a single context window. You may not need a graph.

## Summary
- 79 nodes · 68 edges · 18 communities (13 shown, 5 thin omitted)
- Extraction: 88% EXTRACTED · 10% INFERRED · 1% AMBIGUOUS · INFERRED: 7 edges (avg confidence: 0.86)
- Token cost: 165,663 input · 0 output

## Community Hubs (Navigation)
- Svelte App & UI Components
- JS Config Compiler Options
- CI/CD Deployment Pipeline
- Package Scripts & Metadata
- Build Tool Dependencies
- Type Reference Includes
- GitHub Icon Asset
- Vite Brand Icon
- Devidence Logo & Brand
- Svelte Framework Icon
- Graphify Workflow Doc
- Medium Icon Asset

## God Nodes (most connected - your core abstractions)
1. `compilerOptions` - 11 edges
2. `Devidence Home Landing Page README` - 9 edges
3. `include` - 4 edges
4. `scripts` - 4 edges
5. `Build & Push image job` - 4 edges
6. `app service (devidence-home container)` - 4 edges
7. `Deploy to production job` - 3 edges
8. `@sveltejs/vite-plugin-svelte` - 2 edges
9. `svelte` - 2 edges
10. `terser` - 2 edges

## Surprising Connections (you probably didn't know these)
- `homelab repository (devidence-dev/homelab)` --conceptually_related_to--> `app service (devidence-home container)`  [AMBIGUOUS]
  .github/workflows/deploy.yml → docker-compose.yml
- `index.html entry document` --conceptually_related_to--> `Devidence Home Landing Page README`  [INFERRED]
  index.html → README.md
- `devidence-home Docker image (zot.devidence.dev/devidence-home)` --shares_data_with--> `app service (devidence-home container)`  [INFERRED]
  .github/workflows/deploy.yml → docker-compose.yml
- `Caddy` --conceptually_related_to--> `app service (devidence-home container)`  [INFERRED]
  README.md → docker-compose.yml

## Import Cycles
- None detected.

## Hyperedges (group relationships)
- **CI/CD Release Pipeline (version -> build -> deploy)** — github_workflows_deploy_version, github_workflows_deploy_build, github_workflows_deploy_deploy [EXTRACTED 0.95]
- **Docker Image Build Pattern (shared Dockerfile across CI and Compose)** — github_workflows_deploy_build, docker_compose_app_service, dockerfile [INFERRED 0.85]
- **Devidence Home Project Identity (name, branding, description across files)** — index_html_document, readme_readme, github_workflows_deploy_devidence_home_image [INFERRED 0.75]

## Communities (18 total, 5 thin omitted)

### Community 0 - "Svelte App & UI Components"
Cohesion: 0.13
Nodes (8): ./lib/animations.js, index.html entry document, Bun, LinkStack Galaxy Theme, Devidence Home Landing Page README, Svelte, Vite, app

### Community 1 - "JS Config Compiler Options"
Cohesion: 0.18
Nodes (11): compilerOptions, checkJs, esModuleInterop, isolatedModules, module, moduleResolution, resolveJsonModule, skipLibCheck (+3 more)

### Community 2 - "CI/CD Deployment Pipeline"
Cohesion: 0.28
Nodes (9): app service (devidence-home container), Container Security Hardening, Build & Push image job, Deploy to production job, devidence-home Docker image (zot.devidence.dev/devidence-home), homelab repository (devidence-dev/homelab), Calculate version job, Zot Container Registry (zot.devidence.dev) (+1 more)

### Community 3 - "Package Scripts & Metadata"
Cohesion: 0.22
Nodes (8): name, private, scripts, build, dev, preview, type, version

### Community 4 - "Build Tool Dependencies"
Cohesion: 0.22
Nodes (9): devDependencies, svelte, @sveltejs/vite-plugin-svelte, terser, vite, svelte, @sveltejs/vite-plugin-svelte, terser (+1 more)

### Community 5 - "Type Reference Includes"
Cohesion: 0.40
Nodes (4): include, src/**/*.d.ts, src/**/*.js, src/**/*.svelte

### Community 6 - "GitHub Icon Asset"
Cohesion: 0.67
Nodes (3): GitHub (platform), LittleLink Icon Set, GitHub Icon (SVG)

## Ambiguous Edges - Review These
- `homelab repository (devidence-dev/homelab)` → `app service (devidence-home container)`  [AMBIGUOUS]
  .github/workflows/deploy.yml · relation: conceptually_related_to

## Knowledge Gaps
- **42 isolated node(s):** `moduleResolution`, `target`, `module`, `verbatimModuleSyntax`, `isolatedModules` (+37 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **5 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **What is the exact relationship between `homelab repository (devidence-dev/homelab)` and `app service (devidence-home container)`?**
  _Edge tagged AMBIGUOUS (relation: conceptually_related_to) - confidence is low._
- **Why does `Devidence Home Landing Page README` connect `Svelte App & UI Components` to `CI/CD Deployment Pipeline`?**
  _High betweenness centrality (0.070) - this node is a cross-community bridge._
- **Why does `Caddy` connect `CI/CD Deployment Pipeline` to `Svelte App & UI Components`?**
  _High betweenness centrality (0.045) - this node is a cross-community bridge._
- **What connects `moduleResolution`, `target`, `module` to the rest of the system?**
  _42 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Svelte App & UI Components` be split into smaller, more focused modules?**
  _Cohesion score 0.1323529411764706 - nodes in this community are weakly interconnected._