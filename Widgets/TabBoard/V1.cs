using MindAttic.Ideas.Abstractions;

namespace MindAttic.Ideas.Widget.TabBoard;

/// <summary>
/// MindAttic.Ideas.Widget.TabBoard.V1 — the mindattic.com project-board engine as an asset-only
/// activator, extracted VERBATIM from mindattic.com/index.htm (the `.tabButton`/`.tabPage` styles
/// and the board script). Drop the token once and authored board markup is wired — tiles in a
/// wrapping grid, single-active full-row panels, procedural tile art for placeholders, per-section
/// localStorage persistence:
/// <code>
///   &lt;div class="board-section"&gt;&lt;div class="board-grid"&gt;
///     &lt;button type="button" class="tabButton" data-target="x"&gt;
///       &lt;div class="tabButton-name"&gt;Name&lt;/div&gt;&lt;/button&gt;
///     &lt;div class="tabPage" id="x"&gt;…&lt;/div&gt;
///   &lt;/div&gt;&lt;/div&gt;
/// </code>
/// Page scripts can also BUILD boards from data via <c>window.TabBoard.build(items)</c> /
/// <c>TabBoard.art(name)</c> / <c>TabBoard.images</c> (how the frontpage tabifies its Portfolio
/// links and books grids).
/// </summary>
public sealed class V1 : WidgetBase
{
    private const string Mount = "/_ideas/Widget/tabboard/1";

    public override IReadOnlyList<string> StylesheetUrls { get; } = new[] { Mount + "/tabboard.css" };
    public override IReadOnlyList<string> ScriptUrls { get; } = new[] { Mount + "/tabboard.js" };
}
