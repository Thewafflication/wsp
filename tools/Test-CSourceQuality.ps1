[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [string]$RepositoryRoot,

    [Parameter(Mandatory)]
    [string[]]$SourcePath,

    [string[]]$ExcludePath = @(),

    [Parameter(Mandatory)]
    [string]$Doxyfile,

    [string]$Doxygen = 'doxygen'
)

$ErrorActionPreference = 'Stop'

function Resolve-ProjectPath {
    param([Parameter(Mandatory)][string]$Path)

    if ([IO.Path]::IsPathRooted($Path)) {
        return [IO.Path]::GetFullPath($Path)
    }
    return [IO.Path]::GetFullPath((Join-Path $RepositoryRoot $Path))
}

$RepositoryRoot = (Resolve-Path -LiteralPath $RepositoryRoot).Path
$sourceRoots = @($SourcePath | ForEach-Object {
    (Resolve-Path -LiteralPath (Resolve-ProjectPath $_)).Path
})
$excludedRoots = @($ExcludePath | ForEach-Object {
    (Resolve-Path -LiteralPath (Resolve-ProjectPath $_)).Path
})
$doxyfileCandidate = Resolve-ProjectPath $Doxyfile
$doxyfilePath = (Resolve-Path -LiteralPath $doxyfileCandidate).Path
$failures = [Collections.Generic.List[string]]::new()

function Test-Excluded {
    param([Parameter(Mandatory)][string]$Path)

    foreach ($excluded in $excludedRoots) {
        if ($Path -eq $excluded -or
            $Path.StartsWith("$excluded$([IO.Path]::DirectorySeparatorChar)",
                [StringComparison]::OrdinalIgnoreCase)) {
            return $true
        }
    }
    return $false
}

$sourceFiles = @($sourceRoots |
    ForEach-Object {
        Get-ChildItem -LiteralPath $_ -Recurse -File
    } |
    Where-Object {
        $_.Extension -in '.c', '.h' -and -not (Test-Excluded $_.FullName)
    } |
    Sort-Object FullName -Unique)

if ($sourceFiles.Count -eq 0) {
    throw 'No in-scope C source or header files were found.'
}

foreach ($file in $sourceFiles) {
    $relative = [IO.Path]::GetRelativePath($RepositoryRoot, $file.FullName)
    $contents = Get-Content -LiteralPath $file.FullName
    $raw = $contents -join "`n"

    if ($raw -notmatch '(?s)/\*\*.*?@file(?:\s|\*/)' -and
        $raw -notmatch '(?s)/\*!.*?@file(?:\s|\*/)') {
        $failures.Add("${relative}: missing Doxygen @file comment.")
    }

    for ($index = 0; $index -lt $contents.Count; $index++) {
        if ($contents[$index].Length -gt 80) {
            $length = $contents[$index].Length
            $line = $index + 1
            $failures.Add(
                "${relative}:${line}: ${length} characters exceeds 80.")
        }
    }
}

if ($failures.Count -gt 0) {
    $failures | ForEach-Object { Write-Error $_ }
    exit 1
}

$doxygenCommand = Get-Command $Doxygen -ErrorAction SilentlyContinue |
    Select-Object -First 1
if (-not $doxygenCommand) {
    throw "Doxygen executable was not found: $Doxygen"
}

Push-Location (Split-Path -Parent $doxyfilePath)
try {
    & $doxygenCommand.Source $doxyfilePath
    if ($LASTEXITCODE -ne 0) {
        throw "Doxygen failed with exit code $LASTEXITCODE."
    }
}
finally {
    Pop-Location
}

Write-Output (
    "C source quality passed for $($sourceFiles.Count) file(s).")
