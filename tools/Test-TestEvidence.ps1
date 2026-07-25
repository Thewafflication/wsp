[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [string]$EvidenceDirectory,

    [Parameter(Mandatory)]
    [int]$ExpectedCount,

    [string]$Filter = 'tc-*-execution-evidence.tex'
)

$ErrorActionPreference = 'Stop'
$evidenceRoot = (Resolve-Path -LiteralPath $EvidenceDirectory).Path
$evidenceFiles = @(Get-ChildItem -LiteralPath $evidenceRoot -File `
    -Filter $Filter)

if ($evidenceFiles.Count -ne $ExpectedCount) {
    throw (
        "Expected $ExpectedCount evidence file(s) in $evidenceRoot; " +
        "found $($evidenceFiles.Count).")
}

$invalid = [Collections.Generic.List[string]]::new()
foreach ($file in $evidenceFiles) {
    $contents = Get-Content -LiteralPath $file.FullName -Raw
    $matches = [regex]::Matches(
        $contents,
        '\\item\[Overall Status\]\s+' +
        '(Pass|Fail|Blocked|Inconclusive|Not run|Not applicable)\s*')
    if ($matches.Count -ne 1) {
        $invalid.Add("$($file.Name): expected exactly one controlled status.")
        continue
    }
    $status = $matches[0].Groups[1].Value
    if ($status -ne 'Pass') {
        $invalid.Add("$($file.Name): status is $status, not Pass.")
    }
}

if ($invalid.Count -gt 0) {
    $invalid | ForEach-Object { Write-Error $_ }
    exit 1
}

Write-Output "Validated $($evidenceFiles.Count) passing evidence file(s)."
