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
