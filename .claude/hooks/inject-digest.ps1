<#
  SessionStart hook — injects docs/BIBLE.digest.md as authoritative context for MindAttic.Ideas.Library.
  Emits Claude Code hook JSON on stdout. Windows PowerShell 5.1 / Win-1252 safe: all non-ASCII is
  escaped to \uXXXX so the JSON is valid regardless of console code page. If the digest is missing or
  empty, emits {}.
#>
$ErrorActionPreference = 'Stop'

try {
  $repoRoot   = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
  $digestPath = Join-Path $repoRoot 'docs\BIBLE.digest.md'

  if (-not (Test-Path $digestPath)) { Write-Output '{}'; return }
  $digest = Get-Content -LiteralPath $digestPath -Raw -Encoding UTF8
  if ([string]::IsNullOrWhiteSpace($digest)) { Write-Output '{}'; return }

  $preamble = @"
[MindAttic.Ideas.Library — Codex digest, AUTHORITATIVE]
The following is the authoritative source of truth for this repo (the first-party .idea component
library: Themes/Widgets/Controls). It is generated from docs/BIBLE.md. Treat its laws and definitions
as binding; when in doubt, open docs/BIBLE.md, docs/USER_STORIES.md, docs/AMENDMENTS.md, and
docs/data/components.json. An amendment always wins over the bible. Inherited org-wide laws live in
../MindAttic.HouseRules.md.

"@

  $text = $preamble + $digest

  # JSON-escape: backslash, quote, control chars, and all non-ASCII -> \uXXXX
  $sb = New-Object System.Text.StringBuilder
  foreach ($ch in $text.ToCharArray()) {
    $code = [int][char]$ch
    switch ($ch) {
      '\' { [void]$sb.Append('\\') }
      '"' { [void]$sb.Append('\"') }
      "`b" { [void]$sb.Append('\b') }
      "`f" { [void]$sb.Append('\f') }
      "`n" { [void]$sb.Append('\n') }
      "`r" { [void]$sb.Append('\r') }
      "`t" { [void]$sb.Append('\t') }
      default {
        if ($code -lt 32 -or $code -gt 126) {
          [void]$sb.Append('\u' + $code.ToString('x4'))
        } else {
          [void]$sb.Append($ch)
        }
      }
    }
  }
  $escaped = $sb.ToString()

  $json = '{"hookSpecificOutput":{"hookEventName":"SessionStart","additionalContext":"' + $escaped + '"}}'
  Write-Output $json
}
catch {
  # Never break a session on hook failure.
  Write-Output '{}'
}
