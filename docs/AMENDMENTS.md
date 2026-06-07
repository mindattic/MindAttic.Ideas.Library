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

**Migration / status.** The source rename is staged in the working tree and the full solution builds clean
([MAIL-§6](BIBLE.md#MAIL-§6)). Residual historical prose still says "Plugin" in
[`Pages/_wip/README.md`](../Pages/_wip/README.md) and a couple of inline comments; these are descriptive,
not load-bearing, and are tracked as a cleanup in [MAIL-§7](BIBLE.md#MAIL-§7). The bible and stories use
**Widget** as the canonical term; this amendment records the prior name for history.
