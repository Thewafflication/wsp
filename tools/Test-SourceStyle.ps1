<#
.SYNOPSIS
Checks owned source/configuration text against the WSP physical style baseline.
.DESCRIPTION
Checks UTF-8, the 80-character limit, trailing whitespace, and final newline.
Tabs count as one physical character. Length uses UTF-16 code units, matching
Test-CSourceQuality.ps1. Syntax and documentation need separate validators.
.PARAMETER RepositoryRoot
Owning project root. Source and excluded paths must stay within this root.
.PARAMETER SourcePath
Files or directories to scan recursively, relative to RepositoryRoot.
.PARAMETER ExcludePath
Explicit owned-scope exclusions; directory exclusions include descendants.
.PARAMETER IncludeExtension
Selected extensions, including the leading dot. Defaults cover WSP profiles.
.PARAMETER IncludeName
Selected extensionless or conventional filenames, such as Makefile.
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory)][string]$RepositoryRoot,
    [Parameter(Mandatory)][string[]]$SourcePath,
    [string[]]$ExcludePath = @(),
    [string[]]$IncludeExtension = @(
        '.c', '.h', '.cc', '.hh', '.cpp', '.hpp', '.cxx', '.hxx',
        '.py', '.pyi', '.yaml', '.yml', '.json', '.mk', '.make',
        '.ps1', '.psm1', '.psd1', '.cs', '.vb', '.cmake',
        '.js', '.jsx', '.ts', '.tsx', '.sh', '.bash', '.zsh',
        '.rs', '.go', '.java', '.sql', '.html', '.css', '.xml',
        '.props', '.targets', '.csproj', '.vbproj', '.toml', '.ini', '.cfg',
        '.bat', '.cmd', '.lua', '.rb', '.php', '.kt', '.swift', '.dox'
    ),
    [string[]]$IncludeName = @(
        'Makefile', 'GNUmakefile', 'CMakeLists.txt', '.editorconfig',
        '.clang-format', '.clang-tidy', '.gitignore', '.gitattributes',
        'Doxyfile'
    )
)

$ErrorActionPreference = 'Stop'
$RepositoryRoot = (Resolve-Path -LiteralPath $RepositoryRoot).Path
$comparison = if ($IsWindows) {
    [StringComparison]::OrdinalIgnoreCase
} else {
    [StringComparison]::Ordinal
}
$rootPrefix = $RepositoryRoot.TrimEnd(
    [IO.Path]::DirectorySeparatorChar) + [IO.Path]::DirectorySeparatorChar

function Resolve-OwnedPath {
    param([string]$Path)

    $candidate = if ([IO.Path]::IsPathRooted($Path)) {
        [IO.Path]::GetFullPath($Path)
    } else {
        [IO.Path]::GetFullPath((Join-Path $RepositoryRoot $Path))
    }
    if (-not $candidate.Equals($RepositoryRoot, $comparison) -and
        -not $candidate.StartsWith($rootPrefix, $comparison)) {
        throw "Source-style path is outside RepositoryRoot: $Path"
    }
    return $candidate
}

function Test-ExcludedPath {
    param([string]$Path)

    foreach ($excluded in $excludedRoots) {
        $prefix = $excluded.TrimEnd([IO.Path]::DirectorySeparatorChar) +
            [IO.Path]::DirectorySeparatorChar
        if ($Path.Equals($excluded, $comparison) -or
            $Path.StartsWith($prefix, $comparison)) {
            return $true
        }
    }
    return $false
}

$excludedRoots = @($ExcludePath | ForEach-Object {
    Resolve-OwnedPath $_
})
$sourceRoots = @($SourcePath | ForEach-Object {
    $candidate = Resolve-OwnedPath $_
    if (-not (Test-Path -LiteralPath $candidate)) {
        throw "Source-style input is missing: $candidate"
    }
    $sourceItem = Get-Item -LiteralPath $candidate -Force
    if ($sourceItem.LinkType) {
        $target = $sourceItem.ResolveLinkTarget($true)
        if (-not $target) {
            throw "Unable to resolve source-style input link: $candidate"
        }
        Resolve-OwnedPath $target.FullName | Out-Null
    }
    $candidate
})
$files = @($sourceRoots | ForEach-Object {
    Get-ChildItem -LiteralPath $_ -Recurse -File -Force
} | Where-Object {
    ($_.Extension -in $IncludeExtension -or $_.Name -in $IncludeName) -and
        -not (Test-ExcludedPath $_.FullName)
} | Sort-Object FullName -CaseSensitive -Unique)
if ($files.Count -eq 0) {
    throw 'No in-scope source/configuration files were found.'
}

$failures = [Collections.Generic.List[string]]::new()
$utf8 = [Text.UTF8Encoding]::new($false, $true)
foreach ($file in $files) {
    $relative = [IO.Path]::GetRelativePath($RepositoryRoot, $file.FullName)
    if ($file.LinkType) {
        $target = $file.ResolveLinkTarget($true)
        if (-not $target) {
            throw "Unable to resolve source-style link: $relative"
        }
        Resolve-OwnedPath $target.FullName | Out-Null
    }
    try {
        $text = $utf8.GetString([IO.File]::ReadAllBytes($file.FullName))
    }
    catch {
        $failures.Add("${relative}: WSP-STYLE-0002: invalid UTF-8 input.")
        continue
    }
    # A UTF-8 BOM is encoding metadata, not a source character.
    if ($text.Length -gt 0 -and $text[0] -eq [char]0xfeff) {
        $text = $text.Substring(1)
    }
    $lines = $text -split '\r\n|\n|\r'
    for ($index = 0; $index -lt $lines.Count; $index++) {
        $line = $index + 1
        if ($lines[$index].Length -gt 80) {
            $failures.Add(
                "${relative}:${line}: WSP-STYLE-0001: " +
                "$($lines[$index].Length) characters exceeds 80.")
        }
        if ($lines[$index] -match '[ \t]+$') {
            $failures.Add(
                "${relative}:${line}: WSP-STYLE-0003: trailing whitespace.")
        }
    }
    if ($text.Length -gt 0 -and $text -notmatch '(?:\r\n|\n)$') {
        $failures.Add("${relative}: WSP-STYLE-0003: missing final newline.")
    }
}
if ($failures.Count -gt 0) {
    $failures | ForEach-Object { Write-Output $_ }
    exit 1
}
Write-Output "Source style passed for $($files.Count) owned file(s)."
