[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [string]$LogPath,

    [string]$SummaryPath = $env:GITHUB_STEP_SUMMARY
)

$ErrorActionPreference = 'Stop'
if (-not $SummaryPath) {
    Write-Verbose 'No summary path was provided; nothing to write.'
    exit 0
}

$lines = [Collections.Generic.List[string]]::new()
$lines.Add('## Build warnings')
$lines.Add('')

if (-not (Test-Path -LiteralPath $LogPath -PathType Leaf)) {
    throw "Build log was not found: $LogPath"
}

$pattern = '(?i)(?:\bwarning\s+(?:[A-Z]+\d+|CMake\b)|' +
    ':\s*warning\b|^CMake Warning)'
$warnings = @(Get-Content -LiteralPath $LogPath |
    Where-Object { $_ -match $pattern } |
    ForEach-Object { $_.TrimEnd() })

if ($warnings.Count -eq 0) {
    $lines.Add('No compiler, linker, or CMake warnings were reported.')
}
else {
    $lines.Add("$($warnings.Count) warning line(s) were reported:")
    $lines.Add('')
    $lines.Add('<details>')
    $lines.Add('<summary>Show build warnings</summary>')
    $lines.Add('')
    $lines.Add('```text')
    foreach ($warning in $warnings) {
        $safeWarning = $warning.Replace('```', "`u{02CB}`u{02CB}`u{02CB}")
        $lines.Add($safeWarning)
    }
    $lines.Add('```')
    $lines.Add('')
    $lines.Add('</details>')
}

$lines.Add('')
$lines | Out-File -LiteralPath $SummaryPath -Encoding utf8 -Append
Write-Output "Wrote $($warnings.Count) warning(s) to $SummaryPath."
