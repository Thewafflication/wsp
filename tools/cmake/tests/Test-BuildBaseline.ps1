[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$cmake = (Get-Command cmake -ErrorAction Stop).Source
$sourceRoot = $PSScriptRoot
$workRoot = Join-Path ([IO.Path]::GetTempPath()) (
    'wsp-cmake-tests-' + [guid]::NewGuid().ToString('N'))

function Invoke-CMakeCheck {
    param(
        [Parameter(Mandatory)][string[]]$Arguments,
        [Parameter(Mandatory)][int]$ExpectedExitCode,
        [Parameter(Mandatory)][string]$Name
    )

    $output = & $cmake @Arguments 2>&1
    $exitCode = $LASTEXITCODE
    if ($exitCode -ne $ExpectedExitCode) {
        $text = ($output | ForEach-Object { $_.ToString() }) -join "`n"
        throw (
            "$Name returned $exitCode; expected $ExpectedExitCode.`n$text")
    }
    Write-Output "[PASS] $Name"
}

New-Item -ItemType Directory -Path $workRoot | Out-Null
try {
    $hardeningBuild = Join-Path $workRoot 'hardening'
    Invoke-CMakeCheck @(
        '-S', $sourceRoot,
        '-B', $hardeningBuild,
        '-DWSP_ENABLE_STATIC_ANALYSIS=OFF'
    ) 0 'CMake hardening configuration succeeds'
    Invoke-CMakeCheck @(
        '--build', $hardeningBuild,
        '--config', 'Release'
    ) 0 'CMake hardened fixture builds'

    $generatorLine = Get-Content -LiteralPath (
        Join-Path $hardeningBuild 'CMakeCache.txt') |
        Where-Object { $_ -match '^CMAKE_GENERATOR:INTERNAL=' } |
        Select-Object -First 1
    $generator = $generatorLine -replace '^CMAKE_GENERATOR:INTERNAL=', ''
    $analysisGeneratorSupported =
        $generator -match '(^Ninja|Makefiles|WMake)'

    $analysisBuild = Join-Path $workRoot 'analysis'
    $analysisExpected = if ($analysisGeneratorSupported) { 0 } else { 1 }
    $analysisName = if ($analysisGeneratorSupported) {
        'CMake static-analysis configuration succeeds'
    } else {
        'CMake static analysis rejects an unenforced generator'
    }
    Invoke-CMakeCheck @(
        '-S', $sourceRoot,
        '-B', $analysisBuild,
        '-DWSP_ENABLE_HARDENING=OFF',
        '-DWSP_ENABLE_STATIC_ANALYSIS=ON',
        "-DWSP_CLANG_TIDY_EXECUTABLE:FILEPATH=$cmake"
    ) $analysisExpected $analysisName

    $missingTool = Join-Path $workRoot 'missing-clang-tidy.exe'
    $missingToolBuild = Join-Path $workRoot 'missing-tool'
    Invoke-CMakeCheck @(
        '-S', $sourceRoot,
        '-B', $missingToolBuild,
        '-DWSP_ENABLE_HARDENING=OFF',
        '-DWSP_ENABLE_STATIC_ANALYSIS=ON',
        "-DWSP_CLANG_TIDY_EXECUTABLE:FILEPATH=$missingTool"
    ) 1 'CMake static analysis rejects a missing analyzer'

    $missingConfig = Join-Path $workRoot 'missing-clang-tidy.yml'
    $missingConfigBuild = Join-Path $workRoot 'missing-config'
    Invoke-CMakeCheck @(
        '-S', $sourceRoot,
        '-B', $missingConfigBuild,
        '-DWSP_ENABLE_HARDENING=OFF',
        '-DWSP_ENABLE_STATIC_ANALYSIS=ON',
        "-DWSP_CLANG_TIDY_EXECUTABLE:FILEPATH=$cmake",
        "-DWSP_CLANG_TIDY_CONFIG:FILEPATH=$missingConfig"
    ) 1 'CMake static analysis rejects a missing configuration'

    $invalidHardeningBuild = Join-Path $workRoot 'invalid-hardening'
    Invoke-CMakeCheck @(
        '-S', $sourceRoot,
        '-B', $invalidHardeningBuild,
        '-DWSP_ENABLE_HARDENING=OFF',
        '-DWSP_REQUIRE_STACK_PROTECTION=ON',
        '-DWSP_ENABLE_STATIC_ANALYSIS=OFF'
    ) 1 'CMake rejects disabled required stack protection'
}
finally {
    $resolvedWorkRoot = (Resolve-Path -LiteralPath $workRoot `
        -ErrorAction SilentlyContinue).Path
    if ($resolvedWorkRoot -and
        $resolvedWorkRoot.StartsWith([IO.Path]::GetTempPath(),
            [StringComparison]::OrdinalIgnoreCase) -and
        (Split-Path -Leaf $resolvedWorkRoot) -like 'wsp-cmake-tests-*') {
        Remove-Item -LiteralPath $resolvedWorkRoot -Recurse -Force
    }
}

Write-Output 'All WSP CMake build-baseline tests passed.'
exit 0
