[CmdletBinding()]
param(
    [string]$RepositoryRoot = '.',

    [string]$PdfPath = 'output/pdf/wsp-documentation.pdf',

    [string]$ManifestPath =
        'documentation/documentation-manifest.json',

    [Parameter(Mandatory)][string]$ExpectedVersion,

    [Parameter(Mandatory)][string]$ExpectedSourceRevision,

    [string]$OutputPath,

    [string]$Python
)

$ErrorActionPreference = 'Stop'
$RepositoryRoot = (Resolve-Path -LiteralPath $RepositoryRoot).Path
$wspRoot = Split-Path -Parent $PSScriptRoot

function Resolve-ProjectPath {
    param([Parameter(Mandatory)][string]$Path)

    if ([IO.Path]::IsPathRooted($Path)) {
        return [IO.Path]::GetFullPath($Path)
    }
    return [IO.Path]::GetFullPath((Join-Path $RepositoryRoot $Path))
}

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

$verifier = Join-Path $wspRoot 'tools/pdf/test_documentation_pdf.py'
$arguments = @(
    $verifier,
    '--repository-root', $RepositoryRoot,
    '--pdf', (Resolve-ProjectPath $PdfPath),
    '--manifest', (Resolve-ProjectPath $ManifestPath),
    '--expected-version', $ExpectedVersion,
    '--expected-source-revision', $ExpectedSourceRevision
)
if ($OutputPath) {
    $arguments += @('--output', (Resolve-ProjectPath $OutputPath))
}

& $pythonPath @arguments
if ($LASTEXITCODE -ne 0) {
    exit $LASTEXITCODE
}
