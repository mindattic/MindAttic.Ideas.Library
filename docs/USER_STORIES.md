---
codex: 1
project: MindAttic.Ideas.Library
code: MAIL
layer: stories
status: living
updated: 2026-06-07
---

# MindAttic.Ideas.Library — User Stories

> ✅ done (shipped & verified) · 🟡 partial · ⬜ planned · 🗑️ cut. Every ✅ cites the proof.
> This is a component RCL library with **no test project**; "verified" here means a clean
> `dotnet build` and/or an observed interactive/raw-HTML demo (see [MAIL-§8](BIBLE.md#MAIL-§8) and
> [HOUSE-LAW-8](../../MindAttic.HouseRules.md)). Where a story would normally cite a `[Test]`, it cites the
> build target or demo that proves it; absent an automated test those stories stay 🟡.

## Epic A — Authoring a component

- **MAIL-US-A1 ✅** As a component author, I can add a Theme/Widget/Control as a tiny RCL and have its
  identity come from convention (namespace tail = key, `V{n}` = version), so no per-project key/version
  config exists. *Given a new project under `Themes/`/`Widgets/`/`Controls/`, When I build it, Then it
  compiles against Abstractions alone and is identified by convention.* *(verified by
  `dotnet build -c Release MindAttic.Ideas.Library.slnx` → 0/0; identity convention documented at
  [MAIL-LAW-2](BIBLE.md#MAIL-LAW-2).)*
- **MAIL-US-A2 ✅** As a component author, I get common build settings and the one Abstractions reference
  for free, so my `.csproj` stays tiny. *Given `Directory.Build.props`, When I add a component, Then I
  declare only my own asset quirks.* *(verified by [`Directory.Build.props`](../Directory.Build.props) +
  the clean solution build.)*
- **MAIL-US-A3 ✅** As a component author, my css/js live in a plain `assets/` folder (not `wwwroot/`) so
  the Razor SDK never causes cross-host static-asset collisions. *Given `StaticWebAssetsEnabled=false` and
  `assets/`, When the solution builds, Then no static-web-asset collision occurs.* *(verified by the clean
  solution build; rule at [MAIL-LAW-5](BIBLE.md#MAIL-LAW-5).)*

## Epic B — The one bundle, three consumers

- **MAIL-US-B1 ✅** As a raw-HTML author, I can link a component's `assets/*` directly and see it render
  with no CMS, build, or Blazor. *Given `Themes/Cyberspace/demo.html`, When I open it, Then the theme
  chrome renders from `assets/theme.css` alone.* *(verified by [`Themes/Cyberspace/demo.html`](../Themes/Cyberspace/demo.html)
  linking the same `theme.css` the `.idea` bundles.)*
- **MAIL-US-B2 🟡** As a standalone Blazor app, I can reference a component RCL (or link the same `assets/`)
  and get identical output to the CMS. *Given the component RCL, When an app references it, Then it renders
  the same bundle.* *(no standalone-app harness in this repo yet; the RCLs build and the bundle is shared by
  construction — not independently observed here.)*
- **MAIL-US-B3 🟡** As the CMS, I can upload a packed `.idea` and serve its bundle under
  `/_ideas/<Kind>/<key>/<version>/`. *Given `dist/<component>.idea`, When the CMS installs it, Then the
  bundle is served at the mount.* *(18 `.idea` artifacts exist in [`dist/`](../dist); install/serve happens
  in the CMS repo and was not exercised during this Codex pass.)*

## Epic C — Composition by string id

- **MAIL-US-C1 ✅** As a Theme author, I can compose installed Widgets by string key without a project
  reference, so themes stay decoupled. *Given `theme.cyberspace` with `[Uses(Widget,"outfitfont",1)]`…
  `[Uses(Widget,"cyberspace",1)]` and matching `<CmsInclude>`, When it builds, Then it carries only its own
  chrome and pulls the rest by id.* *(verified by the clean build of `Themes/Cyberspace`; edges recorded on
  [theme.cyberspace](data/components.json).)*
- **MAIL-US-C2 ✅** As a Widget author, I can compose other Widgets by id (Frontpage→tooltip,
  LegionPersonas→sacredgeometry). *Given those `[Uses]` declarations, When the widgets build, Then the
  edges resolve by id only.* *(verified by the clean solution build; edges on
  [widget.frontpage](data/components.json) and [widget.legionpersonas](data/components.json).)*

## Epic D — Catalog & lifecycle

- **MAIL-US-D1 ✅** As a maintainer, I can read one catalog of every shipped component (key, kind, version,
  assembly, artifact, composition). *Given [`components.json`](data/components.json), When I open it, Then
  all 18 components are enumerated and validate against their schema.* *(verified by
  `tools/codex.ps1 doctor` schema + id-uniqueness checks.)*
- **MAIL-US-D2 ✅** As a maintainer, every component versions by whole numbers only. *Given `<Version>` and
  the `V{n}` class, When I inspect any component, Then the version is a whole number.* *(verified by
  [`Directory.Build.props`](../Directory.Build.props) `<Version>1.0.0</Version>` + `V1` classes;
  [HOUSE-LAW-1](../../MindAttic.HouseRules.md).)*
- **MAIL-US-D3 🟡** As a maintainer, I can re-`pack` any component into a fresh `.idea`. *Given a built DLL
  + `assets/`, When I run the pack command, Then a `dist/*.idea` is produced.* *(`dist/*.idea` exist but
  the pack round-trip was not re-run during this Codex pass.)*

## Epic E — Pages stay records

- **MAIL-US-E1 ✅** As a maintainer, frozen page source is preserved losslessly without polluting the build.
  *Given `Pages/_wip/*` with `*.csproj.wip` + an empty `Directory.Build.props` and absence from `.slnx`,
  When the solution builds, Then nothing under `Pages/_wip` compiles or packs.* *(verified by the clean
  solution build and [`Pages/_wip/README.md`](../Pages/_wip/README.md); rule at [MAIL-LAW-8](BIBLE.md#MAIL-LAW-8).)*

## Priority backlog

1. **MAIL-US-B2 / MAIL-US-D3** — a component smoke-test + pack-round-trip harness so "done" is proven, not
   asserted ([RFC 0001](rfc/0001-component-test-harness.md)) — closes the ⬜ test gap in [MAIL-§6](BIBLE.md#MAIL-§6).
2. **MAIL-US-B3** — an install/serve assertion exercised from a host (likely in the CMS repo).
3. Port `Pages/_wip` sources into Page records / compiled Widgets (see [`Pages/_wip/README.md`](../Pages/_wip/README.md)).

### Audit log

No story has been re-scoped from an original written spec; this file is the first formal statement of the
library's stories, derived from the README, the per-component source/conventions, and the verified build.
When a story is later re-scoped, preserve its original ask verbatim here, marked "(original spec — audit log)".
