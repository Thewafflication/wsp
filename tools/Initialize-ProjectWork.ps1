[CmdletBinding(SupportsShouldProcess)]
param(
    [Parameter(Mandatory)]
    [string] $ProjectRoot
)

$ErrorActionPreference = 'Stop'
$root = (Resolve-Path -LiteralPath $ProjectRoot).Path
if (-not (Test-Path -LiteralPath $root -PathType Container)) {
    throw 'ProjectRoot must be an existing directory.'
}
$templates = Join-Path $PSScriptRoot '../processes'
$files = @{
    'PROJECT-WORK.md' = 'project-work-template.md'
    'AGENT-TASKS.md' = 'agent-tasks-template.md'
}
foreach ($name in $files.Keys) {
    $target = Join-Path $root $name
    if (Test-Path -LiteralPath $target) {
        Write-Output "Preserved existing $name"
        continue
    }
    if ($PSCmdlet.ShouldProcess($target, 'Create project work entry point')) {
        # CreateNew prevents replacing a file created concurrently by the owner.
        $source = Join-Path $templates $files[$name]
        $bytes = [IO.File]::ReadAllBytes($source)
        $stream = [IO.File]::Open($target, [IO.FileMode]::CreateNew)
        try { $stream.Write($bytes, 0, $bytes.Length) }
        finally { $stream.Dispose() }
        Write-Output "Created $name"
    }
}
Write-Output 'Link PROJECT-WORK.md from AGENTS.md or README.md and fill in the actual project contracts and tasks before marking work ready.'
