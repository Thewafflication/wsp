[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [string]$RepositoryRoot,

    [string]$RequirementsPath = 'docs',

    [string]$TestSpecificationsPath = 'docs',

    [string]$TestImplementationsPath = 'tests',

    [string[]]$TraceabilityPath = @(),

    [switch]$AllowManualTests
)

$ErrorActionPreference = 'Stop'
$RepositoryRoot = (Resolve-Path -LiteralPath $RepositoryRoot).Path

function Resolve-ProjectPath {
    param([Parameter(Mandatory)][string]$Path)

    if ([IO.Path]::IsPathRooted($Path)) {
        return (Resolve-Path -LiteralPath $Path).Path
    }
    $candidate = Join-Path $RepositoryRoot $Path
    return (Resolve-Path -LiteralPath $candidate).Path
}

$requirementsRoot = Resolve-ProjectPath $RequirementsPath
$specificationsRoot = Resolve-ProjectPath $TestSpecificationsPath
$implementationsRoot = Resolve-ProjectPath $TestImplementationsPath
$traceabilityFiles = @($TraceabilityPath | ForEach-Object {
    Resolve-ProjectPath $_
})
$failures = [Collections.Generic.List[string]]::new()

$requirementFiles = @(Get-ChildItem -LiteralPath $requirementsRoot `
    -Recurse -File -Filter 'req-*.md')
$specificationFiles = @(Get-ChildItem -LiteralPath $specificationsRoot `
    -Recurse -File -Filter 'tc-*.tex')
$implementationFiles = @(Get-ChildItem -LiteralPath $implementationsRoot `
    -Recurse -File | Where-Object {
        $_.Name -match '^(?:run-)?tc-(\d{4})(?:-.*)?\.ps1$'
    })

function New-ArtifactMap {
    param(
        [Parameter(Mandatory)][IO.FileInfo[]]$Files,
        [Parameter(Mandatory)][string]$Pattern,
        [Parameter(Mandatory)][string]$Kind,
        [switch]$AllowMultiple
    )

    $map = @{}
    foreach ($file in $Files) {
        if ($file.BaseName -notmatch $Pattern) {
            $failures.Add("$Kind has an invalid filename: $($file.FullName)")
            continue
        }
        $id = $Matches[1]
        if ($map.ContainsKey($id)) {
            if (-not $AllowMultiple) {
                $failures.Add("Duplicate $Kind identifier $id.")
            }
        }
        else {
            $map[$id] = $file
        }
    }
    return $map
}

$requirements = New-ArtifactMap -Files $requirementFiles `
    -Pattern '^req-(\d{4})(?:-|$)' -Kind 'requirement'
$specifications = New-ArtifactMap -Files $specificationFiles `
    -Pattern '^tc-(\d{4})(?:-|$)' -Kind 'test specification'
$implementations = New-ArtifactMap -Files $implementationFiles `
    -Pattern '^(?:run-)?tc-(\d{4})(?:-|$)' -Kind 'test implementation' `
    -AllowMultiple

foreach ($id in $requirements.Keys) {
    $contents = Get-Content -LiteralPath $requirements[$id].FullName -Raw
    $forwardText = [Collections.Generic.List[string]]::new()
    $forwardText.Add($contents)
    foreach ($traceabilityFile in $traceabilityFiles) {
        $matchingLines = Get-Content -LiteralPath $traceabilityFile |
            Where-Object { $_ -match "\bREQ-$id\b" }
        foreach ($line in $matchingLines) {
            $forwardText.Add($line)
        }
    }
    $references = @([regex]::Matches(
        ($forwardText -join "`n"),
        '\bTC-(\d{4})\b') |
        ForEach-Object { $_.Groups[1].Value } | Sort-Object -Unique)
    if ($references.Count -eq 0) {
        $failures.Add("REQ-$id has no TC-NNNN verification reference.")
    }
    foreach ($testId in $references) {
        if (-not $specifications.ContainsKey($testId)) {
            $failures.Add("REQ-$id references missing TC-$testId.")
        }
    }
}

foreach ($id in $specifications.Keys) {
    $contents = Get-Content -LiteralPath $specifications[$id].FullName -Raw
    $references = @([regex]::Matches($contents, '\bREQ-(\d{4})\b') |
        ForEach-Object { $_.Groups[1].Value } | Sort-Object -Unique)
    if ($references.Count -eq 0) {
        $failures.Add("TC-$id has no REQ-NNNN back-reference.")
    }
    foreach ($requirementId in $references) {
        if (-not $requirements.ContainsKey($requirementId)) {
            $failures.Add("TC-$id references missing REQ-$requirementId.")
        }
    }
    if (-not $AllowManualTests -and
        -not $implementations.ContainsKey($id)) {
        $failures.Add("TC-$id has no automated PowerShell implementation.")
    }
}

foreach ($id in $implementations.Keys) {
    if (-not $specifications.ContainsKey($id)) {
        $failures.Add("Test implementation TC-$id has no specification.")
    }
}

if ($failures.Count -gt 0) {
    $failures | ForEach-Object { Write-Error $_ }
    exit 1
}

Write-Output (
    "Traceability passed for $($requirements.Count) requirement(s), " +
    "$($specifications.Count) test specification(s), and " +
    "$($implementations.Count) implementation(s).")
