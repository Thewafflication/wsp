[CmdletBinding()]
param(
    [string]$Python
)

$ErrorActionPreference = 'Stop'
if ($Python) {
    $pythonPath = (Resolve-Path -LiteralPath $Python).Path
}
else {
    $pythonCommand = Get-Command python -ErrorAction SilentlyContinue |
        Select-Object -First 1
    if (-not $pythonCommand) {
        throw 'python was not found. Supply its path with -Python.'
    }
    $pythonPath = $pythonCommand.Source
}

$testScript = Join-Path $PSScriptRoot 'test_documentation_pdf.py'
& $pythonPath $testScript
if ($LASTEXITCODE -ne 0) {
    exit $LASTEXITCODE
}
