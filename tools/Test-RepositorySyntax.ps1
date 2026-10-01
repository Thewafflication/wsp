[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
Push-Location $root
try {
    $files = & git ls-files --cached --others --exclude-standard
    if ($LASTEXITCODE -ne 0) {
        throw 'Unable to enumerate repository files with git ls-files.'
    }
    $failures = [Collections.Generic.List[string]]::new()
    foreach ($file in $files) {
        if ([IO.Path]::GetExtension($file) -notin '.ps1', '.psm1' -or
            -not (Test-Path -LiteralPath $file -PathType Leaf)) {
            continue
        }
        $tokens = $null
        $errors = $null
        [Management.Automation.Language.Parser]::ParseFile(
            (Join-Path $root $file), [ref]$tokens, [ref]$errors) |
            Out-Null
        foreach ($parseError in $errors) {
            $failures.Add(
                "${file}:$($parseError.Extent.StartLineNumber): " +
                $parseError.Message)
        }
    }
    if ($failures.Count -gt 0) {
        throw ($failures -join "`n")
    }
    Write-Output '[PASS] Repository PowerShell syntax'
}
finally {
    Pop-Location
}
