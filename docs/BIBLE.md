---
codex: 1
project: MindAttic.Ideas.Library
code: MAIL
layer: bible
status: living
updated: 2026-10-03
---

# MindAttic.Ideas.Library — Project Bible

> Single source of truth for what MindAttic.Ideas.Library IS, is NOT, and the rules its contents follow.
> The [README](../README.md) says how to look at and build the contents; this says how to think about them.
> Where a fact is structured and tabular it lives once in [`docs/data/components.json`](data/components.json)
> (L5) and is cited here by `id`.

## 1. The one sentence {#MAIL-§1}

MindAttic.Ideas.Library is a **retired, archived repository**: on 2026-06-12 the library was merged into
the CMS repo as `MindAttic.Ideas/library`, where all work on first-party `.idea` components now happens;
this repo holds the component sources (7 Themes, 30 Widgets) as they stood at that merge.

## 2. The product promise {#MAIL-§2}

The repo promises nothing new; it is read-only (archived on GitHub). What it contains:

- **37 component projects**, each a small Razor Class Library (RCL) under `Themes/` or `Widgets/`, one per
  `.idea`. All are enumerated in [`components.json`](data/components.json).
- **Each component's asset bundle** in its own `assets/` folder (css/js/html/images), plus a raw-HTML
  `demo.html` for the Cyberspace theme and 18 widgets that renders from that bundle alone, with no build.
- **The solution** [`MindAttic.Ideas.Library.slnx`](../MindAttic.Ideas.Library.slnx) (36 projects; the
  `Widgets/ModalPopup` project is on disk and catalogued but not in the solution) and the shared
  [`Directory.Build.props`](../Directory.Build.props).
- **The Codex docs** (this file, the stories, the catalog) and `tools/codex.ps1`.

## 3. What it is NOT {#MAIL-§3}

- **NOT where work happens.** No further changes land here. The live library is
  `MindAttic.Ideas/library`, where the Widget kind has since been split into Plugin and Component.
- **NOT buildable against a current MindAttic.Ideas checkout.** Every widget derives from `WidgetBase`,
  which current `MindAttic.Ideas.Abstractions` no longer defines (see [MAIL-§6](#MAIL-§6)).
- **NOT a source of packed artifacts.** `dist/` is git-ignored build output and is not in the repo.
- **NOT the CMS host.** The CMS never referenced anything here ([MAIL-LAW-7](#MAIL-LAW-7)).
- **NOT a NuGet library.** Every component is `IsPackable=false`; the unit of distribution was the
  `.idea` (a guarded zip, [HOUSE-LAW-5](../../MindAttic.HouseRules.md)).
- **NOT a place for Pages.** A Page is a CMS database record, not a `.idea`; no page source lives here
  ([MAIL-LAW-8](#MAIL-LAW-8)).

## 4. Architecture canon {#MAIL-§4}

```
   sibling repo  MindAttic.Ideas  (CMS host; never references this repo)
        │
   MindAttic.Ideas.Abstractions  ◄── the ONE ProjectReference (Private=false, ExcludeAssets=runtime)
        │
   ┌────┴──────────────────── MindAttic.Ideas.Library (archived) ─────────────────────┐
   │  Directory.Build.props  (net10.0, <Version>1.0.0</Version>, the Abstractions ref)  │
   │                                                                                    │
   │   Themes/   7 RCLs   ThemeBase  → ThemeCssUrls; chrome + ONE @Body hole           │
   │   Widgets/ 30 RCLs   WidgetBase → StylesheetUrls / inline markup; self-contained  │
   │                                                                                    │
   │   each component: V1.razor + assets/ (the bundle) [+ demo.html]                    │
   └────────────────────────────────────────────────────────────────────────────────────┘
                 composition: [Uses(ContentKind, "key", n)] + <CmsInclude Ref="…"> (by string id)
```

### 4.1 Projects {#MAIL-§4.1}
37 component RCLs: **7 Themes** (Cyberspace, Light, Dark, Spring, Summer, Autumn, Winter) and
**30 Widgets**. The widgets fall into three groups:
- **MindAttic-specific** — OutfitFont, AtticFont, BackHomeM, Cyberspace (effects), SacredGeometry, Tooltip,
  TableOfContents, LegionPersonas, Frontpage, HelloWorld, Textbox, ModalPopup.
- **Baseline set** (general-purpose parts for ordinary websites) — NavMenu, Breadcrumbs, Hero, Card,
  Accordion, Tabs, Gallery, Carousel, Callout, CodeBlock, VideoEmbed, ContactForm, SocialLinks, BackToTop,
  Footer.
- **mindattic.com verbatim set** (extracted from mindattic.com's `index.htm`) — TabBoard, PinFooter,
  WebSnapshot.

There is no `Controls/` folder: Textbox is a Widget. The full enumeration (key, kind, version, assembly,
artifact name, mount, composition edges) is L5 canon in [`components.json`](data/components.json).

### 4.2 Domain model (NOUNS) {#MAIL-§4.2}
- **Component** — a single `.idea` citizen: a Theme or Widget. Identity = `key` (namespace tail) +
  `version` (`V{n}` class). Catalogued in [`components.json`](data/components.json).
- **Theme** — chrome (a `theme.css`) plus exactly one `@Body` hole; derives from `ThemeBase`, exposes
  `ThemeCssUrls`. May compose Widgets.
- **Widget** — a self-contained capability (font, effect, glyph, gallery, form field, board); derives from
  `WidgetBase`, exposes `StylesheetUrls` and/or inline Razor markup. May compose other Widgets.
- **Asset bundle** — a component's `assets/` folder; packing turns it into the package `wwwroot/`, served
  under the component **mount** `/_ideas/<Kind>/<key>/<version>/`.
- **`.idea` artifact** — the packed zip produced by the MindAttic.Ideas SDK `pack` command into `dist/`
  (not in the repo).

### 4.3 Key services (VERBS) {#MAIL-§4.3}
- **build** — `dotnet build -c Release <project>`; compiles one RCL to one DLL against Abstractions.
  Fails against current Abstractions ([MAIL-§6](#MAIL-§6)).
- **pack** — `dotnet run --project ../MindAttic.Ideas/src/MindAttic.Ideas.Sdk -- pack …` turns a built DLL
  + its `assets/` into a `dist/*.idea` (see [README](../README.md)).
- **compose** — `[Uses(ContentKind, "key", n)]` declares a dependency on another installed component and
  `<CmsInclude Ref="…">` renders it, resolved by string id at install/render time.
- **demo** — a component's `demo.html` links its `assets/*` directly, so the bundle can be viewed over any
  static HTTP server.

## 5. The Laws {#MAIL-§5}

This project **inherits the org-wide House Rules** at
[`MindAttic.HouseRules.md`](../../MindAttic.HouseRules.md) by reference — they are not restated here.
Most relevant: [HOUSE-LAW-1](../../MindAttic.HouseRules.md) (whole-number versioning),
[HOUSE-LAW-5](../../MindAttic.HouseRules.md) (`.idea` is a guarded, versioned, integrity-checked zip) and
[HOUSE-LAW-8](../../MindAttic.HouseRules.md) (done = verified). The laws below are the project-specific
conventions every component in this repo follows. They now govern the live library in
`MindAttic.Ideas/library`.

### {#MAIL-LAW-1} The asset bundle is the single source of truth.
A component owns its `assets/` (css/js/html/images) once. That one bundle serves raw HTML pages,
standalone Blazor apps and the CMS. No second copy exists.

### {#MAIL-LAW-2} Identity is convention, never configuration.
A component's **key** is its namespace tail, lowercased; its **version** is the `V{n}` class number. A
`.csproj` declares no key/version.

### {#MAIL-LAW-3} Compose by string id, never by project reference.
The only `ProjectReference` a component carries is the Abstractions SDK. Dependencies on other components
are declared with `[Uses(ContentKind, "key", n)]` and rendered with `<CmsInclude Ref="…">`.

### {#MAIL-LAW-4} One DLL per packed `bin/`.
Abstractions and the framework Components it carries stay out of `bin/` (`Private=false` +
`ExcludeAssets=runtime`), so a packed `bin/` holds exactly one DLL.

### {#MAIL-LAW-5} Chrome lives in `assets/`, never `wwwroot/`.
Component css/js live in a plain `assets/` folder with `StaticWebAssetsEnabled=false`, so the Razor SDK
never registers them as static web assets (which collide across hosts). `assets/` becomes the package
`wwwroot/` only at pack time.

### {#MAIL-LAW-6} Styles are scoped to the component.
Every selector is scoped under a component-specific root (e.g. `.hello-world`, `.theme-light`,
`.ma-field`) so a component never leaks styles into the host theme, the page, or a sibling component.

### {#MAIL-LAW-7} The CMS never references the library.
The CMS installs packed `.idea`s as **optional** content and takes no code dependency on anything here.
The dependency arrow points one way only.

### {#MAIL-LAW-8} Pages are records, not `.idea`s.
Themes and Widgets ship as `.idea`. A Page is a CMS database record; no page source lives in this repo.

## 6. Verified state {#MAIL-§6}

| Aspect | Status | Evidence (2026-10-03) |
|---|---|---|
| Builds against current MindAttic.Ideas | ⬜ | `dotnet build -c Release Widgets/HelloWorld` → `error CS0246: The type or namespace name 'WidgetBase' could not be found`. Current `MindAttic.Ideas.Abstractions` no longer defines `WidgetBase`. |
| Catalog validates | ✅ | `tools/codex.ps1 doctor`: [`components.json`](data/components.json) passes its schema and id-uniqueness checks (37 components). |
| Raw-HTML demos | ✅ | 19 `demo.html` pages (the Cyberspace theme + 18 widgets) link only their own `assets/*`; no build is involved. |
| Automated tests | ⬜ | The repo has no test project. |
| Packed artifacts | ⬜ | None in the repo; `dist/` is git-ignored. |

## 7. Active frontier {#MAIL-§7}

None. The repo is archived; component work, its backlog and its design notes live in
`MindAttic.Ideas/library` and the MindAttic.Ideas docs. Stories: [`USER_STORIES.md`](USER_STORIES.md).

## 8. Quality bar {#MAIL-§8}

No changes land here. A docs-only correction is done when `tools/codex.ps1 doctor` passes and every
statement in this bible is true of the repo's contents ([HOUSE-LAW-8](../../MindAttic.HouseRules.md)).

## 9. Glossary {#MAIL-§9}

- **`.idea`** — a guarded, versioned zip ([HOUSE-LAW-5](../../MindAttic.HouseRules.md)); the unit of
  distribution for a component, uploaded to the CMS as optional content.
- **Component** — a Theme or Widget; one RCL, one `.idea`. Catalog: [`components.json`](data/components.json).
- **Theme / Widget** — see [MAIL-§4.2](#MAIL-§4.2).
- **Asset bundle / `assets/`** — a component's css/js/html/images; becomes the package `wwwroot/` at pack
  time.
- **Mount** — the served path `/_ideas/<Kind>/<key>/<version>/` for a component's assets.
- **Key** — a component's namespace tail, lowercased; its stable string identity.
- **Version** — the `V{n}` content class number; whole-number only ([HOUSE-LAW-1](../../MindAttic.HouseRules.md)).
- **`[Uses]` / `<CmsInclude>`** — declare/render a dependency on another installed component by string id.
- **Abstractions** — `MindAttic.Ideas.Abstractions`, the SDK project in the sibling MindAttic.Ideas repo
  that components compile against; at this repo's merge it supplied `ThemeBase`, `WidgetBase`, `[Idea]`,
  `[Uses]` and `CmsInclude`.
- **Page record** — a CMS database row (Html/Css/Js + tags); NOT a `.idea` ([MAIL-LAW-8](#MAIL-LAW-8)).
- **RCL** — Razor Class Library, the project type of every component (`Microsoft.NET.Sdk.Razor`).
