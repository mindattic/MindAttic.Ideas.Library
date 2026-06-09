---
codex: 1
project: MindAttic.Ideas.Library
code: MAIL
layer: amendments
status: living
updated: 2026-06-07
---

# MindAttic.Ideas.Library — Amendments (append-only; amendment wins over the bible)

> Newest at the bottom. Never rewrite an amendment; supersede it with a new one. Beyond ~25, fold into
> [BIBLE.md](BIBLE.md) and start a new epoch (note the git tag); history stays in git.

## MAIL-A1 — Plugin → Widget rename (supersedes —)

**What changed.** The component kind formerly called "Plugin" is now **"Widget"** throughout: the
`Plugins/` directory is now `Widgets/`, and namespaces/types/csproj/`.idea` names moved from
`MindAttic.Ideas.Plugin.*` to `MindAttic.Ideas.Widget.*`. The composition attribute now uses
`ContentKind.Widget`.

**Why.** "Widget" describes a self-contained UI capability more accurately than "Plugin" (which implied a
host-extension contract the library never had), and aligns the catalog vocabulary across the CMS.

**Migration / status.** The source rename is complete and the full solution builds clean
([MAIL-§6](BIBLE.md#MAIL-§6)). Residual historical prose in
[`Pages/_wip/README.md`](../Pages/_wip/README.md) retains "Plugin" as a deliberate historical record
(frozen source; not updated). The bible and stories use **Widget** as the canonical term; this amendment
records the prior name for history.

## MAIL-A2 — Textbox: Control kind folded to Widget (supersedes §4.1 "1 Control") {#MAIL-A2}

**What changed.** `Textbox` was originally authored as a `Control` (inheriting `ControlBase`, living in a
`Controls/` folder) but was folded into the **Widget** kind before any release: it now lives under
`Widgets/Textbox/`, inherits `WidgetBase`, and is named `MindAttic.Ideas.Widget.Textbox`. The solution
has no `Controls/` folder. The `components.json` catalog records its kind as `Widget`. `ControlBase`
remains available in Abstractions for future use.

**Why.** Textbox is a self-contained, configurable UI element that fits the Widget contract (typed
`[Parameter]` props + pass-through `Attributes` are fully expressible on `WidgetBase`). A separate
Control tier adds complexity without benefit until a real distinction emerges (e.g. headless form
primitives that must not carry markup). MAI-A19 tracked this decision in the CMS backlog.

**Impact on §4.1.** The solution count is **7 Themes, 11 Widgets, 0 Controls** (not "7 Themes, 10 Widgets,
1 Control" as previously stated). Bible §4.1 updated accordingly. No breaking change: the `.idea`
artifact key/version and mount path are identical (`widget.textbox`, V1, `/_ideas/Widget/textbox/1`).

## MAIL-A3 — The baseline widget set (supersedes §4.1 "7 Themes, 11 Widgets") {#MAIL-A3}

**What changed.** Fifteen general-purpose **baseline widgets** were added so the CMS can build and
maintain ordinary websites from reusable parts instead of bespoke markup: NavMenu, Breadcrumbs, Hero,
Card, Accordion, Tabs, Gallery, Carousel, Callout, CodeBlock, VideoEmbed, ContactForm, SocialLinks,
BackToTop, and Footer. The solution count is now **7 Themes, 26 Widgets**. All are catalogued in
[`components.json`](data/components.json) (notes prefixed "Baseline set (MAIL-A3)").

**Why.** The prior catalog was MindAttic-specific (fonts, effects, persona gallery). The product goal —
many sites from one CMS, no monolith web apps — needs a vanilla kit: navigation, banners, cards,
collapsibles, tab boards, image grids, sliders, notices, code chrome, video, contact, social icons,
scroll-to-top, and a footer. The set was sized against recreating **mindattic.com** as a Data page:
Tabs (`ma-tabs-board`) is its project board, Gallery its books grid, Footer its pin-when-short bar.

**Design rules the set introduced (now load-bearing for future widgets):**
- **Activator-first.** Where possible a widget is an asset-only *capability activator* (the Tooltip
  model): drop the token once and plain author HTML gains the behavior via `ma-*` classes /
  `data-*` attributes. Free-form pages stay free-form; layout stays plain flex in author HTML.
- **String parameters only.** Razor-widget `[Parameter]`s are strings (data-page token attributes
  arrive as strings; typed coercion is RFC 0001 roadmap in the CMS). No widget depends on
  `ChildContent` (data-page tokens never carry it).
- **Images are inline base64 CSS classes.** A widget that shows an image accepts the page-convention
  class (`imageclass=`, `.ma-gallery-tile img-*`, `.ma-slide img-*`) and never requires a file URL;
  icons/arrows are inline SVG path data or CSS glyphs. No external requests, no icon files.
- **Per-site reuse via settings.** Site-chrome widgets (NavMenu, ContactForm, SocialLinks) read
  `ISiteContext.GetSetting` fallbacks (`nav.*`, `contact.action`, `social.*`) so one theme token
  serves every site.

**Migration / status.** Additive only — no existing component changed identity. All 33 components
build clean (0/0) and pack to [`dist/`](../dist).
