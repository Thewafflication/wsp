[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$toolsRoot = Split-Path -Parent $PSScriptRoot
$powerShell = (Get-Process -Id $PID).Path
$workRoot = Join-Path ([IO.Path]::GetTempPath()) (
    'wsp-tool-tests-' + [guid]::NewGuid().ToString('N'))

function Invoke-ToolTest {
    param(
        [Parameter(Mandatory)][string]$Script,
        [Parameter(Mandatory)][string[]]$Arguments,
        [Parameter(Mandatory)][int]$ExpectedExitCode,
        [Parameter(Mandatory)][string]$Name
    )

    $output = & $powerShell -NoProfile -File $Script @Arguments 2>&1
    $exitCode = $LASTEXITCODE
    if ($exitCode -ne $ExpectedExitCode) {
        $text = ($output | ForEach-Object { $_.ToString() }) -join "`n"
        throw (
            "$Name returned $exitCode; expected $ExpectedExitCode.`n$text")
    }
    Write-Output "[PASS] $Name"
}

function Write-Fixture {
    param(
        [Parameter(Mandatory)][string]$Path,
        [Parameter(Mandatory)][string]$Value
    )

    $parent = Split-Path -Parent $Path
    New-Item -ItemType Directory -Force -Path $parent | Out-Null
    Set-Content -LiteralPath $Path -Value $Value -Encoding utf8
}

New-Item -ItemType Directory -Path $workRoot | Out-Null
try {
    $parseFailures = [Collections.Generic.List[string]]::new()
    Get-ChildItem -LiteralPath $toolsRoot -File -Filter '*.ps1' |
        ForEach-Object {
            $tokens = $null
            $errors = $null
            [Management.Automation.Language.Parser]::ParseFile(
                $_.FullName,
                [ref]$tokens,
                [ref]$errors) | Out-Null
            foreach ($error in $errors) {
                $parseFailures.Add(
                    "$($_.Name):$($error.Extent.StartLineNumber): " +
                    $error.Message)
            }
        }
    if ($parseFailures.Count -gt 0) {
        throw ($parseFailures -join "`n")
    }
    Write-Output '[PASS] PowerShell syntax'

    $traceRoot = Join-Path $workRoot 'traceability'
    Write-Fixture (Join-Path $traceRoot 'docs\req-0001-example.md') `
        "# REQ-0001`n`nVerified by TC-0001."
    Write-Fixture (Join-Path $traceRoot 'docs\tc-0001-example.tex') `
        '% Verifies REQ-0001.'
    Write-Fixture (Join-Path $traceRoot 'tests\tc-0001-example.ps1') `
        'exit 0'
    $traceabilityTool = Join-Path $toolsRoot 'Test-Traceability.ps1'
    $traceArguments = @(
        '-RepositoryRoot', $traceRoot,
        '-RequirementsPath', 'docs',
        '-TestSpecificationsPath', 'docs',
        '-TestImplementationsPath', 'tests'
    )
    Invoke-ToolTest $traceabilityTool $traceArguments 0 `
        'Traceability accepts complete links'
    Write-Fixture (Join-Path $traceRoot 'docs\req-0001-example.md') `
        "# REQ-0001`n`nMissing verification link."
    Invoke-ToolTest $traceabilityTool $traceArguments 1 `
        'Traceability rejects missing links'

    $evidenceRoot = Join-Path $workRoot 'evidence'
    $evidenceFile = Join-Path $evidenceRoot `
        'tc-0001-execution-evidence.tex'
    Write-Fixture $evidenceFile '\item[Overall Status] Pass'
    $evidenceTool = Join-Path $toolsRoot 'Test-TestEvidence.ps1'
    $evidenceArguments = @(
        '-EvidenceDirectory', $evidenceRoot,
        '-ExpectedCount', '1'
    )
    Invoke-ToolTest $evidenceTool $evidenceArguments 0 `
        'Evidence accepts one passing result'
    Write-Fixture $evidenceFile '\item[Overall Status] Fail'
    Invoke-ToolTest $evidenceTool $evidenceArguments 1 `
        'Evidence rejects a failing result'

    $reportRoot = Join-Path $workRoot 'report'
    $testCase = Join-Path $reportRoot 'tc-0001.tex'
    $reportEvidence = Join-Path $reportRoot 'evidence.tex'
    $reportOutput = Join-Path $reportRoot 'generated\report.tex'
    Write-Fixture $testCase @'
\documentclass{article}
\input{wsp/testing/test-case-library.tex}
\begin{document}
Test specification.
\end{document}
'@
    Write-Fixture $reportEvidence 'Execution evidence marker.'
    $reportTool = Join-Path $toolsRoot 'New-TestReport.ps1'
    $reportArguments = @(
        '-TestCaseTex', $testCase,
        '-EvidenceTex', $reportEvidence,
        '-OutputTex', $reportOutput
    )
    Invoke-ToolTest $reportTool $reportArguments 0 `
        'Report generation succeeds'
    $reportText = Get-Content -LiteralPath $reportOutput -Raw
    if ($reportText -notmatch 'Execution evidence marker\.') {
        throw 'Generated report did not contain its evidence.'
    }
    Write-Output '[PASS] Generated report contains evidence'

    $sourceRoot = Join-Path $workRoot 'source-quality'
    $sourceFile = Join-Path $sourceRoot 'src\example.c'
    $doxyfile = Join-Path $sourceRoot 'Doxyfile'
    $fakeDoxygen = Join-Path $sourceRoot 'fake-doxygen.ps1'
    Write-Fixture $sourceFile @'
/** @file */
/** Return success. */
int example(void)
{
    return 0;
}
'@
    Write-Fixture $doxyfile '# Test Doxyfile'
    Write-Fixture $fakeDoxygen 'exit 0'
    $sourceTool = Join-Path $toolsRoot 'Test-CSourceQuality.ps1'
    $sourceArguments = @(
        '-RepositoryRoot', $sourceRoot,
        '-SourcePath', 'src',
        '-Doxyfile', 'Doxyfile',
        '-Doxygen', $fakeDoxygen
    )
    Invoke-ToolTest $sourceTool $sourceArguments 0 `
        'C source quality accepts documented short lines'
    $longLine = '/' + ('*' * 80) + '/'
    Write-Fixture $sourceFile "/** @file */`n$longLine"
    Invoke-ToolTest $sourceTool $sourceArguments 1 `
        'C source quality rejects long lines'

    $warningRoot = Join-Path $workRoot 'warnings'
    $buildLog = Join-Path $warningRoot 'build.log'
    $summary = Join-Path $warningRoot 'summary.md'
    Write-Fixture $buildLog @'
example.c(10): warning C4100: unreferenced parameter
Build completed.
'@
    $warningTool = Join-Path $toolsRoot `
        'Write-BuildWarningSummary.ps1'
    $warningArguments = @(
        '-LogPath', $buildLog,
        '-SummaryPath', $summary
    )
    Invoke-ToolTest $warningTool $warningArguments 0 `
        'Warning summary succeeds'
    $summaryText = Get-Content -LiteralPath $summary -Raw
    if ($summaryText -notmatch '1 warning line') {
        throw 'Warning summary did not report the expected warning.'
    }
    Write-Output '[PASS] Warning summary contains warning count'

    $documentationRoot = Join-Path $workRoot 'documentation'
    $manifest = Join-Path $documentationRoot 'manifest.json'
    Write-Fixture $manifest @'
{
  "title": "Invalid fixture",
  "repositoryUrl": "https://github.com/example/wsp-tests",
  "outputName": "invalid.pdf",
  "files": ["missing.md"]
}
'@
    $documentationTool = Join-Path $toolsRoot `
        'Build-Documentation.ps1'
    $documentationArguments = @(
        '-RepositoryRoot', $documentationRoot,
        '-ManifestPath', 'manifest.json'
    )
    Invoke-ToolTest $documentationTool $documentationArguments 1 `
        'Documentation build rejects a missing manifest input'
}
finally {
    $resolvedWorkRoot = (Resolve-Path -LiteralPath $workRoot `
        -ErrorAction SilentlyContinue).Path
    if ($resolvedWorkRoot -and
        $resolvedWorkRoot.StartsWith([IO.Path]::GetTempPath(),
            [StringComparison]::OrdinalIgnoreCase) -and
        (Split-Path -Leaf $resolvedWorkRoot) -like 'wsp-tool-tests-*') {
        Remove-Item -LiteralPath $resolvedWorkRoot -Recurse -Force
    }
}

Write-Output 'All WSP common-tool tests passed.'
