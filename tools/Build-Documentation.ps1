[CmdletBinding()]
param(
    [string]$RepositoryRoot = '.',

    [string]$ManifestPath =
        'documentation/documentation-manifest.json',

    [string]$OutputPath,

    [string]$Version,

    [string]$Pandoc,

    [string]$PdfLatex,

    [string[]]$HeaderPath = @()
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

function Find-Executable {
    param(
        [string]$Requested,
        [Parameter(Mandatory)][string]$Name,
        [string[]]$CandidatePath = @()
    )

    if ($Requested) {
        return (Resolve-Path -LiteralPath $Requested).Path
    }
    $command = Get-Command $Name -ErrorAction SilentlyContinue |
        Select-Object -First 1
    if ($command) {
        return $command.Source
    }
    foreach ($candidate in $CandidatePath) {
        if ($candidate -and
            (Test-Path -LiteralPath $candidate -PathType Leaf)) {
            return (Resolve-Path -LiteralPath $candidate).Path
        }
    }
    throw "$Name was not found. Supply its path explicitly."
}

$manifestFullPath = Resolve-ProjectPath $ManifestPath
$manifest = Get-Content -LiteralPath $manifestFullPath -Raw |
    ConvertFrom-Json

foreach ($property in 'title', 'repositoryUrl', 'outputName', 'files') {
    if (-not $manifest.$property) {
        throw "Documentation manifest is missing '$property'."
    }
}

$inputFiles = [Collections.Generic.List[string]]::new()
$seen = [Collections.Generic.HashSet[string]]::new(
    [StringComparer]::OrdinalIgnoreCase)
foreach ($entry in $manifest.files) {
    $path = Resolve-ProjectPath ([string]$entry)
    if (-not (Test-Path -LiteralPath $path -PathType Leaf)) {
        throw "Documentation input was not found: $entry"
    }
    if (-not $seen.Add($path)) {
        throw "Documentation input is duplicated: $entry"
    }
    $inputFiles.Add($path)
}

if (-not $OutputPath) {
    $OutputPath = Join-Path 'output/pdf' $manifest.outputName
}
$outputFullPath = Resolve-ProjectPath $OutputPath
$outputDirectory = Split-Path -Parent $outputFullPath
$temporaryDirectory = Join-Path $RepositoryRoot 'tmp/pdfs/documentation'
New-Item -ItemType Directory -Force -Path $outputDirectory | Out-Null
New-Item -ItemType Directory -Force -Path $temporaryDirectory | Out-Null

$pandocCandidates = @(
    (Join-Path $env:LOCALAPPDATA 'Pandoc/pandoc.exe'),
    'C:/Program Files/Pandoc/pandoc.exe',
    (Join-Path $wspRoot 'tools/.cache/pandoc/pandoc.exe')
)
$localPdfLatex = Join-Path $env:LOCALAPPDATA `
    'Programs/MiKTeX/miktex/bin/x64/pdflatex.exe'
$latexCandidates = @($localPdfLatex)
$pandocPath = Find-Executable $Pandoc 'pandoc' $pandocCandidates
$pdfLatexPath = Find-Executable $PdfLatex 'pdflatex' $latexCandidates

if (-not $Version) {
    $gitVersion = & git -C $RepositoryRoot describe `
        --tags --always --dirty 2>$null
    if ($LASTEXITCODE -eq 0 -and $gitVersion) {
        $Version = "$gitVersion".Trim()
    }
    else {
        $Version = 'unversioned'
    }
}

$sourceRevision = & git -C $RepositoryRoot rev-parse HEAD 2>$null
if ($LASTEXITCODE -ne 0 -or -not $sourceRevision) {
    $sourceRevision = 'not available'
}
else {
    $sourceRevision = "$sourceRevision".Trim()
}
$shortSourceRevision = if ($sourceRevision -eq 'not available') {
    $sourceRevision
}
else {
    $sourceRevision.Substring(0, [Math]::Min(12, $sourceRevision.Length))
}

$pandocVersion = (& $pandocPath --version |
    Select-Object -First 1).Trim()
$latexVersion = (& $pdfLatexPath --version |
    Select-Object -First 1).Trim()
$buildDate = (Get-Date).ToString('yyyy-MM-dd')
$titleDate = "$buildDate — Version $Version — Commit " +
    $shortSourceRevision
$sharedHeader = Join-Path $wspRoot 'documentation/preamble.tex'
$linkFilter = Join-Path $wspRoot 'documentation/internal-links.lua'
$buildInformation = Join-Path $temporaryDirectory 'build-information.md'
$buildInformationLines = @(
    '# Build Information',
    '',
    '| Attribute | Value |',
    '| --- | --- |',
    "| Project | $($manifest.title) |",
    "| Version | $Version |",
    "| Source revision | $sourceRevision |",
    "| Build date | $buildDate |",
    "| Pandoc | $pandocVersion |",
    "| PDF engine | $latexVersion |",
    "| Manifest | $ManifestPath |"
)
$buildInformationLines | Set-Content -LiteralPath $buildInformation `
    -Encoding utf8

$arguments = [Collections.Generic.List[string]]::new()
$arguments.Add('--from=gfm+smart')
$arguments.Add('--standalone')
$arguments.Add('--file-scope')
$arguments.Add('--toc')
$arguments.Add('--toc-depth=3')
$arguments.Add('--number-sections')
$arguments.Add('--top-level-division=chapter')
$arguments.Add('--pdf-engine=' + $pdfLatexPath)
$arguments.Add('--output=' + $outputFullPath)
$arguments.Add('--resource-path=' + $RepositoryRoot)
$arguments.Add('--include-in-header=' + $sharedHeader)
$arguments.Add('--lua-filter=' + $linkFilter)
$arguments.Add('--variable=documentclass:report')
$arguments.Add('--variable=classoption:openany')
$arguments.Add('--variable=papersize:letter')
$arguments.Add('--variable=geometry:margin=0.85in')
$arguments.Add('--variable=fontsize:10pt')
$arguments.Add('--metadata=title:' + [string]$manifest.title)
if ($manifest.subtitle) {
    $arguments.Add('--metadata=subtitle:' + [string]$manifest.subtitle)
}
$repositoryUrl = [string]$manifest.repositoryUrl
$repositoryLink = '\href{' + $repositoryUrl + '}{\nolinkurl{' +
    $repositoryUrl + '}}'
$arguments.Add('--variable=author:' + $repositoryLink)
$arguments.Add('--metadata=date:' + $titleDate)
$arguments.Add('--metadata=version:' + $Version)
$arguments.Add('--metadata=source-revision:' + $sourceRevision)
$arguments.Add('--metadata=pandoc-version:' + $pandocVersion)
$arguments.Add('--metadata=pdf-engine-version:' + $latexVersion)
foreach ($header in $HeaderPath) {
    $arguments.Add('--include-in-header=' + (Resolve-ProjectPath $header))
}
foreach ($inputFile in $inputFiles) {
    $arguments.Add($inputFile)
}
$arguments.Add($buildInformation)

$logPath = Join-Path $temporaryDirectory 'pandoc.log'
$previousManifest = $env:WSP_DOCUMENT_MANIFEST
$env:WSP_DOCUMENT_MANIFEST = $manifestFullPath
Push-Location $RepositoryRoot
try {
    $output = & $pandocPath @arguments 2>&1
    $exitCode = $LASTEXITCODE
    $logText = ($output | ForEach-Object { $_.ToString() }) -join "`r`n"
    [IO.File]::WriteAllText($logPath, $logText)
    if ($exitCode -ne 0) {
        throw "Pandoc failed with exit code $exitCode. See $logPath"
    }
}
finally {
    Pop-Location
    $env:WSP_DOCUMENT_MANIFEST = $previousManifest
}

if (-not (Test-Path -LiteralPath $outputFullPath -PathType Leaf)) {
    throw "Documentation PDF was not created: $outputFullPath"
}
if ((Get-Item -LiteralPath $outputFullPath).Length -eq 0) {
    throw "Documentation PDF is empty: $outputFullPath"
}

Write-Output "Documentation PDF: $outputFullPath"
Write-Output "Version: $Version"
Write-Output "Source revision: $sourceRevision"
Write-Output $pandocVersion
Write-Output $latexVersion
