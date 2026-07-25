[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [string]$TestCaseTex,

    [Parameter(Mandatory)]
    [string]$EvidenceTex,

    [Parameter(Mandatory)]
    [string]$OutputTex,

    [string]$TestCaseLibrary =
        (Join-Path $PSScriptRoot '..\testing\test-case-library.tex'),

    [string]$PdfLatex
)

$ErrorActionPreference = 'Stop'
$testCasePath = (Resolve-Path -LiteralPath $TestCaseTex).Path
$evidencePath = (Resolve-Path -LiteralPath $EvidenceTex).Path
$libraryPath = (Resolve-Path -LiteralPath $TestCaseLibrary).Path
$outputPath = $ExecutionContext.SessionState.Path.
    GetUnresolvedProviderPathFromPSPath($OutputTex)
$outputDirectory = Split-Path -Parent $outputPath

New-Item -ItemType Directory -Force -Path $outputDirectory | Out-Null

$source = Get-Content -LiteralPath $testCasePath -Raw
$evidence = Get-Content -LiteralPath $evidencePath -Raw
$latexLibraryPath = $libraryPath.Replace('\', '/')
$inputPattern = '\\input\{[^}]*test-case-library\.tex\}'

if ($source -notmatch $inputPattern) {
    throw 'Test case does not input test-case-library.tex.'
}
if ([regex]::Matches($source, '\\end\{document\}').Count -ne 1) {
    throw 'Test case must contain exactly one \end{document} command.'
}

$source = [regex]::Replace(
    $source,
    $inputPattern,
    "\input{$latexLibraryPath}")
$report = $source -replace '\\end\{document\}',
    "$evidence`r`n\end{document}"

Set-Content -LiteralPath $outputPath -Value $report -Encoding utf8

if ($PdfLatex) {
    $pdfLatexPath = (Resolve-Path -LiteralPath $PdfLatex).Path
    Push-Location $outputDirectory
    try {
        & $pdfLatexPath -interaction=nonstopmode -halt-on-error `
            -output-directory $outputDirectory $outputPath
        if ($LASTEXITCODE -ne 0) {
            throw "PDFLaTeX failed with exit code $LASTEXITCODE."
        }
    }
    finally {
        Pop-Location
    }
}

Write-Output $outputPath
