# MindAttic.Ideas.Page.LegionPersonas

The MindAttic.Legion **1024-persona gallery** as a single **MindAttic.Ideas Page**, shipped as a
`.idea`. **Not a web app** — a Razor Class Library that compiles against only
`MindAttic.Ideas.Abstractions` and composes everything else **by string id** at runtime.

| | |
|---|---|
| **Key** | `legionpersonas` (from the namespace tail `MindAttic.Ideas.Page.LegionPersonas`) |
| **Version** | V1 (the `V1` class; ship `V2.razor` alongside, never mutate V1) |
| **Slug** | `/legion-personas` |
| **Theme** | `cyberspace` v1 (named in `data/page.json`) |
| **Composes** | `Plugin.sacredgeometry@1` (the live avatar engine) |

## What's in here

| File | Role |
|---|---|
| `V1.razor` | The page — gallery grid + facet filters + paging + detail overlay. All CSS scoped under `.legion-personas`. |
| `PersonaCard.razor` / `PersonaDetail.razor` | The card and the detail panel. Each avatar is a `<canvas data-sacred-shape="N">` the SacredGeometry plugin animates. |
| `PersonaModel.cs` | `Persona` record + `PersonaData` (loads the embedded library) + `PersonaFilter`/`PersonaFiltering`. |
| `personas.json` | The flattened persona library, **embedded** in the assembly. Each persona carries its precomputed SacredGeometry shape index and pre-formatted psychometric lines — so the page has **no `MindAttic.Legion` dependency**. |
| `data/page.json` | The seed that makes the page routable at `/legion-personas` and picks the theme. |
| `_Imports.razor`, `AssemblyInfo.cs`, `*.csproj` | Boilerplate (the csproj's only reference is the Abstractions SDK). |

## Dependencies (must be installed in the CMS)

This page references the following `.idea`s by string id — install them too:

- `MindAttic.Ideas.Plugin.SacredGeometry.V1` (the avatar engine — built in `MindAttic.UiUx`)
- `MindAttic.Ideas.Theme.Cyberspace.V1` and the plugins it composes (OutfitFont, AtticFont, BackHomeM, Cyberspace)

A missing/disabled reference degrades to a placeholder — never a crash.

## Build, pack, validate

Requires the sibling `MindAttic.Ideas` repo (host + SDK) and the .NET 10 SDK.

```powershell
dotnet build -c Release
dotnet run --project ..\MindAttic.Ideas\src\MindAttic.Ideas.Sdk -- pack `
  --assembly bin/Release/net10.0/MindAttic.Ideas.Page.LegionPersonas.dll --out ./dist --data ./data `
  --refs ..\MindAttic.Ideas\src\MindAttic.Ideas.Abstractions\bin\Release\net10.0
dotnet run --project ..\MindAttic.Ideas\src\MindAttic.Ideas.Sdk -- inspect ./dist/MindAttic.Ideas.Page.LegionPersonas.V1.idea
dotnet run --project ..\MindAttic.Ideas\src\MindAttic.Ideas.Sdk -- install ./dist/MindAttic.Ideas.Page.LegionPersonas.V1.idea
```

Output: `dist/MindAttic.Ideas.Page.LegionPersonas.V1.idea` — upload it in the CMS admin.

## Refreshing the persona data

`personas.json` is a one-time export from the MindAttic.Legion persona store (it was generated with each
persona's shape index and psychometric display lines baked in). Re-export from the Legion store and
replace this file to refresh the library.
