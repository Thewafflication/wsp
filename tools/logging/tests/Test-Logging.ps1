[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$loggingRoot = Split-Path -Parent $PSScriptRoot
$modulePath = Join-Path $loggingRoot 'Wsp.Logging.psm1'
$testRoot = Join-Path ([IO.Path]::GetTempPath()) (
    'wsp-logging-tests-' + [guid]::NewGuid().ToString('N'))
$logPath = Join-Path $testRoot 'nested\powershell.log'

New-Item -ItemType Directory -Path $testRoot | Out-Null
try {
    Import-Module $modulePath -Force
    Set-WspLogConfiguration -ConsoleLevel Off -FileLevel Debug -Color Never
    Set-WspLogFile -Path $logPath -Truncate
    Write-WspDebug 'diagnostic value=42'
    Write-WspPass 'verification passed'
    Close-WspLog

    $records = Get-Content -LiteralPath $logPath
    if ($records.Count -ne 2) {
        throw "Expected two file records; found $($records.Count)."
    }
    if ($records[0] -notmatch
        '^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}Z \[DEBUG\] diagnostic') {
        throw 'Debug record format is invalid.'
    }
    if ($records[1] -notmatch '\[PASS \] verification passed$') {
        throw 'Pass record format is invalid.'
    }
    if (($records -join "`n").Contains("`e[")) {
        throw 'File output contains an ANSI escape sequence.'
    }
}
finally {
    Remove-Module Wsp.Logging -ErrorAction SilentlyContinue
    if (Test-Path -LiteralPath $testRoot) {
        Remove-Item -LiteralPath $testRoot -Recurse -Force
    }
}

Write-Output '[PASS] PowerShell logging file sink'
