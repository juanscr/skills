[CmdletBinding()]
param()

$ErrorActionPreference = "Stop"

$repositoryRoot = Split-Path -Parent $PSScriptRoot
$repositorySkills = Join-Path $repositoryRoot "skills"

if (-not (Get-Command copilot -ErrorAction SilentlyContinue)) {
    throw "Copilot CLI is not available on PATH."
}

$availableSkills = @(copilot skill list --json | ConvertFrom-Json)
$skillsRoot = [System.IO.Path]::GetFullPath($repositorySkills)
$registered = $availableSkills | Where-Object {
    $_.path -and
    [System.IO.Path]::GetFullPath($_.path).StartsWith(
        $skillsRoot + [System.IO.Path]::DirectorySeparatorChar,
        [System.StringComparison]::OrdinalIgnoreCase
    )
}

if (-not $registered) {
    & copilot skill add $repositorySkills
    if ($LASTEXITCODE -ne 0) {
        throw "Failed to register repository skills."
    }
}

$expectedSkills = @(
    Get-ChildItem -LiteralPath $repositorySkills -Directory |
        Where-Object { Test-Path (Join-Path $_.FullName "SKILL.md") } |
        Select-Object -ExpandProperty Name
)

$availableSkills = @(copilot skill list --json | ConvertFrom-Json)
$missingSkills = foreach ($name in $expectedSkills) {
    $match = $availableSkills | Where-Object {
        $_.name -eq $name -and
        $_.path -and
        [System.IO.Path]::GetFullPath($_.path).StartsWith(
            $skillsRoot + [System.IO.Path]::DirectorySeparatorChar,
            [System.StringComparison]::OrdinalIgnoreCase
        )
    }

    if (-not $match) {
        $name
    }
}

if ($missingSkills) {
    throw "Copilot did not register: $($missingSkills -join ', ')."
}

Write-Host "Registered $($expectedSkills.Count) repository skills."
Write-Host "Run /skills reload in active Copilot CLI sessions."
