[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
$powerShell = (Get-Process -Id $PID).Path

function Invoke-CheckedCommand {
    param([string]$Command, [string[]]$Arguments)

    & $Command @Arguments
    if ($LASTEXITCODE -ne 0) {
        throw "$Command $($Arguments -join ' ') failed ($LASTEXITCODE)."
    }
}

Push-Location $root
try {
    Invoke-CheckedCommand python @('tools/tests/test_source_style.py')
    Invoke-CheckedCommand $powerShell @(
        '-NoProfile', '-File', 'tools/tests/run-tests.ps1')
    $build = 'output/tests/logging'
    Invoke-CheckedCommand cmake @(
        '-S', 'tools/logging/tests', '-B', $build)
    Invoke-CheckedCommand cmake @(
        '--build', $build, '--config', 'Release')
    Invoke-CheckedCommand ctest @(
        '--test-dir', $build, '-C', 'Release',
        '--output-on-failure', '--no-tests=error')
    Invoke-CheckedCommand cmake @(
        "-DWSP_LOG_FILE=$root/output/tests/cmake-logging.log",
        '-P', 'tools/logging/tests/Test-CMakeLogging.cmake')
    Invoke-CheckedCommand python @(
        'tools/tests/test_pre_commit.py')
}
finally {
    Pop-Location
}
