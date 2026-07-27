$script:WspLogFile = $null
$script:WspConsoleLevel = 'Info'
$script:WspFileLevel = 'Debug'
$script:WspColorMode = 'Auto'

$script:WspLevelValues = @{
    Debug = 0
    Info = 1
    Pass = 2
    Warn = 3
    Error = 4
    Off = 5
}

$script:WspTags = @{
    Debug = 'DEBUG'
    Info = 'INFO '
    Pass = 'PASS '
    Warn = 'WARN '
    Error = 'ERROR'
}

$script:WspColors = @{
    Debug = "`e[33m"
    Info = "`e[34m"
    Pass = "`e[32m"
    Warn = "`e[93m"
    Error = "`e[31m"
}

function Test-WspColorEnabled {
    if ($env:NO_COLOR) {
        return $false
    }
    if ($script:WspColorMode -eq 'Always') {
        return $true
    }
    if ($script:WspColorMode -eq 'Never') {
        return $false
    }
    return -not [Console]::IsOutputRedirected
}

function Set-WspLogConfiguration {
    [CmdletBinding()]
    param(
        [ValidateSet('Debug', 'Info', 'Pass', 'Warn', 'Error', 'Off')]
        [string]$ConsoleLevel = $script:WspConsoleLevel,

        [ValidateSet('Debug', 'Info', 'Pass', 'Warn', 'Error', 'Off')]
        [string]$FileLevel = $script:WspFileLevel,

        [ValidateSet('Auto', 'Never', 'Always')]
        [string]$Color = $script:WspColorMode
    )

    $script:WspConsoleLevel = $ConsoleLevel
    $script:WspFileLevel = $FileLevel
    $script:WspColorMode = $Color
}

function Set-WspLogFile {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][string]$Path,
        [switch]$Truncate
    )

    $resolvedPath = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath(
        $Path)
    $parent = Split-Path -Parent $resolvedPath
    if ($parent) {
        New-Item -ItemType Directory -Force -Path $parent | Out-Null
    }
    if ($Truncate) {
        [IO.File]::WriteAllText($resolvedPath, '')
    }
    else {
        $stream = [IO.File]::Open(
            $resolvedPath,
            [IO.FileMode]::Append,
            [IO.FileAccess]::Write,
            [IO.FileShare]::ReadWrite)
        $stream.Dispose()
    }
    $script:WspLogFile = $resolvedPath
}

function Close-WspLog {
    [CmdletBinding()]
    param()

    $script:WspLogFile = $null
}

function Write-WspLog {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ValidateSet('Debug', 'Info', 'Pass', 'Warn', 'Error')]
        [string]$Level,

        [Parameter(Mandatory)][AllowEmptyString()][string]$Message
    )

    $tag = $script:WspTags[$Level]
    $record = "[$tag] $Message"
    if ($script:WspLevelValues[$Level] -ge
        $script:WspLevelValues[$script:WspConsoleLevel]) {
        if (Test-WspColorEnabled) {
            $record = "$($script:WspColors[$Level])[$tag]`e[0m $Message"
        }
        if ($Level -eq 'Error') {
            [Console]::Error.WriteLine($record)
        }
        else {
            [Console]::Out.WriteLine($record)
        }
    }
    if ($script:WspLogFile -and
        $script:WspLevelValues[$Level] -ge
        $script:WspLevelValues[$script:WspFileLevel]) {
        $timestamp = [DateTimeOffset]::UtcNow.ToString(
            'yyyy-MM-ddTHH:mm:ssZ',
            [Globalization.CultureInfo]::InvariantCulture)
        $line = "$timestamp [$tag] $Message$([Environment]::NewLine)"
        [IO.File]::AppendAllText($script:WspLogFile, $line)
    }
}

function Write-WspDebug {
    [CmdletBinding()]
    param([Parameter(Mandatory)][AllowEmptyString()][string]$Message)
    Write-WspLog -Level Debug -Message $Message
}

function Write-WspInfo {
    [CmdletBinding()]
    param([Parameter(Mandatory)][AllowEmptyString()][string]$Message)
    Write-WspLog -Level Info -Message $Message
}

function Write-WspPass {
    [CmdletBinding()]
    param([Parameter(Mandatory)][AllowEmptyString()][string]$Message)
    Write-WspLog -Level Pass -Message $Message
}

function Write-WspWarning {
    [CmdletBinding()]
    param([Parameter(Mandatory)][AllowEmptyString()][string]$Message)
    Write-WspLog -Level Warn -Message $Message
}

function Write-WspError {
    [CmdletBinding()]
    param([Parameter(Mandatory)][AllowEmptyString()][string]$Message)
    Write-WspLog -Level Error -Message $Message
}

Export-ModuleMember -Function @(
    'Set-WspLogConfiguration',
    'Set-WspLogFile',
    'Close-WspLog',
    'Write-WspLog',
    'Write-WspDebug',
    'Write-WspInfo',
    'Write-WspPass',
    'Write-WspWarning',
    'Write-WspError'
)
