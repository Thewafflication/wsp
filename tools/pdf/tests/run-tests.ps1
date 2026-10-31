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
$previousBytecodeSetting = $env:PYTHONDONTWRITEBYTECODE
try {
    $env:PYTHONDONTWRITEBYTECODE = '1'
    & $pythonPath $testScript
    $testExitCode = $LASTEXITCODE
}
finally {
    $env:PYTHONDONTWRITEBYTECODE = $previousBytecodeSetting
}
if ($testExitCode -ne 0) {
    exit $testExitCode
}
