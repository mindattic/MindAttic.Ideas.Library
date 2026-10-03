---
codex: 1
project: MindAttic.Ideas.Library
code: MAIL
layer: stories
status: living
updated: 2026-10-03
---

# MindAttic.Ideas.Library — User Stories

> ✅ done (shipped & verified) · 🟡 partial · ⬜ planned. Every ✅ cites the proof.
> The repo is archived ([MAIL-§1](BIBLE.md#MAIL-§1)): nothing is planned here, and these stories describe
> what its contents do today. It has no test project and its components no longer build against current
> MindAttic.Ideas ([MAIL-§6](BIBLE.md#MAIL-§6)), so a story that depends on a build is 🟡.

## Epic A — Authoring a component

- **MAIL-US-A1 🟡** As a component author, a component's identity comes from convention (namespace tail =
  key, `V{n}` = version), so no per-project key/version config exists. *Given any project under
  `Themes/` or `Widgets/`, When I read its `.csproj`, Then it declares no key or version.* *(Convention holds
  in source, [MAIL-LAW-2](BIBLE.md#MAIL-LAW-2); the projects no longer compile against current
  Abstractions.)*
- **MAIL-US-A2 ✅** As a component author, I get common build settings and the one Abstractions reference
  from one file, so my `.csproj` stays tiny. *Given `Directory.Build.props`, When I add a component, Then I
  declare only my own asset quirks.* *(verified by [`Directory.Build.props`](../Directory.Build.props),
  which holds `net10.0`, `<Version>1.0.0</Version>`, `IsPackable=false` and the single Abstractions
  reference.)*
- **MAIL-US-A3 🟡** As a site builder, I can compose ordinary-website UI from the baseline widget set
  (NavMenu, Breadcrumbs, Hero, Card, Accordion, Tabs, Gallery, Carousel, Callout, CodeBlock, VideoEmbed,
  ContactForm, SocialLinks, BackToTop, Footer). *(Sources and raw-HTML demos are present; the widgets do
  not build against current Abstractions.)*

## Epic B — The one bundle, three consumers

- **MAIL-US-B1 ✅** As a raw-HTML author, I can link a component's `assets/*` directly and see it render
  with no CMS, build, or Blazor. *Given `Themes/Cyberspace/demo.html`, When I open it over HTTP, Then the
  theme chrome renders from `assets/theme.css` alone.* *(verified by
  [`Themes/Cyberspace/demo.html`](../Themes/Cyberspace/demo.html) and the 18 widget `demo.html` pages, which
  link only their own `assets/`.)*

## Epic C — Composition by string id

- **MAIL-US-C1 ✅** As a Theme author, I compose installed Widgets by string key without a project
  reference. *Given `theme.cyberspace` with `[Uses(Widget,"outfitfont",1)]` … `[Uses(Widget,"cyberspace",1)]`
  and matching `<CmsInclude>`, Then it carries only its own chrome and pulls the rest by id.* *(verified by
  the source of `Themes/Cyberspace` — no `ProjectReference` besides Abstractions; edges recorded on
  [theme.cyberspace](data/components.json).)*
- **MAIL-US-C2 ✅** As a Widget author, I compose other Widgets by id (Frontpage→tooltip,
  LegionPersonas→sacredgeometry, modalpopup). *(verified by the `[Uses]` declarations in source; edges on
  [widget.frontpage](data/components.json) and [widget.legionpersonas](data/components.json).)*

## Epic D — Catalog

- **MAIL-US-D1 ✅** As a maintainer, I can read one catalog of every component (key, kind, version,
  assembly, artifact, composition). *Given [`components.json`](data/components.json), When I open it, Then
  all 37 components are enumerated and validate against their schema.* *(verified by
  `tools/codex.ps1 doctor` schema + id-uniqueness checks.)*
- **MAIL-US-D2 ✅** As a maintainer, every component versions by whole numbers only. *(verified by
  [`Directory.Build.props`](../Directory.Build.props) `<Version>1.0.0</Version>` + `V1` classes;
  [HOUSE-LAW-1](../../MindAttic.HouseRules.md).)*
