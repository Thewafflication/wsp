[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [string]$Path,

    [switch]$RequireControlFlowGuard
)

$ErrorActionPreference = 'Stop'
$resolvedPath = (Resolve-Path -LiteralPath $Path).Path
$bytes = [IO.File]::ReadAllBytes($resolvedPath)

function Test-ByteRange {
    param(
        [Parameter(Mandatory)][long]$Offset,
        [Parameter(Mandatory)][long]$Count
    )

    return $Offset -ge 0 -and $Count -ge 0 -and
        $Offset -le $bytes.LongLength - $Count
}

function Read-UInt16 {
    param([Parameter(Mandatory)][long]$Offset)

    if (-not (Test-ByteRange $Offset 2)) {
        throw "$resolvedPath has a truncated PE field at offset $Offset."
    }
    return [BitConverter]::ToUInt16($bytes, [int]$Offset)
}

function Read-UInt32 {
    param([Parameter(Mandatory)][long]$Offset)

    if (-not (Test-ByteRange $Offset 4)) {
        throw "$resolvedPath has a truncated PE field at offset $Offset."
    }
    return [BitConverter]::ToUInt32($bytes, [int]$Offset)
}

if (-not (Test-ByteRange 0 64) -or
    $bytes[0] -ne [byte][char]'M' -or
    $bytes[1] -ne [byte][char]'Z') {
    throw "$resolvedPath is not a PE image: DOS header is missing."
}

$peOffset = [long](Read-UInt32 0x3c)
if (-not (Test-ByteRange $peOffset 24) -or
    $bytes[$peOffset] -ne [byte][char]'P' -or
    $bytes[$peOffset + 1] -ne [byte][char]'E' -or
    $bytes[$peOffset + 2] -ne 0 -or
    $bytes[$peOffset + 3] -ne 0) {
    throw "$resolvedPath is not a PE image: PE signature is missing."
}

$machine = Read-UInt16 ($peOffset + 4)
$optionalHeaderSize = Read-UInt16 ($peOffset + 20)
$optionalHeaderOffset = $peOffset + 24
if ($optionalHeaderSize -lt 72 -or
    -not (Test-ByteRange $optionalHeaderOffset $optionalHeaderSize)) {
    throw "$resolvedPath has a truncated PE optional header."
}

$magic = Read-UInt16 $optionalHeaderOffset
switch ($magic) {
    0x010b {
        $imageFormat = 'PE32'
        $requireHighEntropy = $false
    }
    0x020b {
        $imageFormat = 'PE32+'
        $requireHighEntropy = $true
    }
    default {
        throw (
            "$resolvedPath has unsupported optional-header magic " +
            ('0x{0:x4}.' -f $magic))
    }
}

$machineNames = @{
    0x014c = 'x86'
    0x8664 = 'x64'
    0xaa64 = 'ARM64'
}
$machineName = $machineNames[[int]$machine]
if (-not $machineName) {
    $machineName = 'machine-{0:x4}' -f $machine
}

$dllCharacteristics = Read-UInt16 ($optionalHeaderOffset + 70)
$requiredFlags = [ordered]@{
    0x0040 = 'DYNAMIC_BASE'
    0x0100 = 'NX_COMPAT'
}
if ($requireHighEntropy) {
    $requiredFlags.Add(0x0020, 'HIGH_ENTROPY_VA')
}
if ($RequireControlFlowGuard) {
    $requiredFlags.Add(0x4000, 'GUARD_CF')
}

$missingFlags = [Collections.Generic.List[string]]::new()
$presentFlags = [Collections.Generic.List[string]]::new()
foreach ($entry in $requiredFlags.GetEnumerator()) {
    if (($dllCharacteristics -band [int]$entry.Key) -eq 0) {
        $missingFlags.Add($entry.Value)
    }
    else {
        $presentFlags.Add($entry.Value)
    }
}

if ($missingFlags.Count -gt 0) {
    Write-Error (
        "$resolvedPath is missing required PE hardening flag(s): " +
        ($missingFlags -join ', ') +
        ('. DllCharacteristics=0x{0:x4}.' -f $dllCharacteristics))
    exit 1
}

Write-Output (
    "PE hardening passed: $resolvedPath ($imageFormat $machineName; " +
    ($presentFlags -join ', ') + ').')
exit 0
