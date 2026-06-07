# WIP page sources — to be ported into CMS Page **records** (not `.idea`)

> **Pages are not `.idea` components.** A page is a **database record** in MindAttic.Ideas: markup
> (HTML + `{{ Theme.… }}` / `{{ Plugin.… }}` / `{{ Control.… }}` tags) plus its own **Html / Css / Js**
> sections, placed in the parent/child page hierarchy. Only Themes, Plugins, and Controls ship as `.idea`.

These folders are the **frozen source** of the previously-compiled page apps, preserved losslessly so
nothing is lost. They are intentionally **not buildable** here:

- each project file is renamed `*.csproj.wip` (not recognized as a project, never packs to `.idea`);
- this folder carries an empty `Directory.Build.props` so the library's build props don't apply;
- nothing here is in `MindAttic.Ideas.Library.slnx`.

| WIP source | Becomes (later) | Notes |
|---|---|---|
| `MindAtticFrontpage/` | a Page record at the front slug | compiled Blazor (`V1.razor` + `HubModels.cs`, `SiteNav`/`NavTabItem`, `Resources/frontpage.css`, `Data/`, `wwwroot/covers/`). Real C# logic — port deliberately. |
| `LegionPersonas/` | a Page record | compiled Blazor (`V1.razor` + `PersonaCard`/`PersonaDetail`/`PersonaModel`, `personas.json`). |

## When it's time to port one

1. Create a new Page record in the CMS (in the hierarchy where it belongs).
2. Move the visual markup into the record's **Html**, the styles into **Css**, any behavior into **Js**.
3. Replace bespoke chrome/widgets with `{{ Theme.… }}` / `{{ Plugin.… }}` / `{{ Control.… }}` tags that
   resolve to installed `.idea` capabilities.
4. C# logic that can't be expressed as content becomes a **compiled Plugin/Control `.idea`** the page
   references by tag (e.g. a `Frontpage` accordion plugin, a `PersonaGallery` control).

Static data (`personas.json`, `hub.json`) and images (`wwwroot/covers/`) move with the content — into the
page's assets or a referenced plugin's `assets/`.
