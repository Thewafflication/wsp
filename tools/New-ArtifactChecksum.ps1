[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [string[]]$Path,

    [Parameter(Mandatory)]
    [string]$OutputPath
)

$ErrorActionPreference = 'Stop'

$resolvedFiles = foreach ($entry in $Path) {
    $resolved = Resolve-Path -LiteralPath $entry -ErrorAction Stop
    $item = Get-Item -LiteralPath $resolved.Path
    if (-not $item.PSIsContainer) {
        $item
    }
    else {
        throw "Checksum input is not a file: $entry"
    }
}

$outputFullPath = [IO.Path]::GetFullPath($OutputPath)
$outputDirectory = Split-Path -Parent $outputFullPath
if ($outputDirectory) {
    New-Item -ItemType Directory -Force -Path $outputDirectory | Out-Null
}

$lines = foreach ($file in $resolvedFiles) {
    $hash = (Get-FileHash -LiteralPath $file.FullName `
            -Algorithm SHA256).Hash.ToLowerInvariant()
    "$hash  $($file.Name)"
}

[IO.File]::WriteAllLines(
    $outputFullPath,
    $lines,
    [Text.UTF8Encoding]::new($false))

Write-Output "SHA-256 checksums: $outputFullPath"
