[CmdletBinding()]
param()

$ErrorActionPreference = "Stop"

$repositoryRoot = Split-Path -Parent $PSScriptRoot
$repositorySkills = Join-Path $repositoryRoot "skills"
$personalSkills = Join-Path $HOME ".copilot\skills"

if (-not (Get-Command copilot -ErrorAction SilentlyContinue)) {
    throw "Copilot CLI is not available on PATH."
}

$deprecatedSkills = @(
    @{ Name = "azure-devops-workflow"; Directory = "azure-devops-workflow" }
    @{ Name = "continue-plan"; Directory = "continue-plan" }
    @{ Name = "design-plan"; Directory = "design-plan" }
    @{ Name = "deslop"; Directory = "deslop" }
    @{ Name = "domain-modeling"; Directory = "domain-modelling" }
    @{ Name = "execute-phase"; Directory = "execute-phase" }
    @{ Name = "juan-pr-review"; Directory = "juan-pr-review" }
    @{ Name = "mos3-rust-development"; Directory = "mos3-rust-development" }
    @{ Name = "human-voice"; Directory = "human-voice" }
    @{ Name = "refactoring-code"; Directory = "refactoring-code" }
    @{ Name = "writing-for-agents"; Directory = "writing-for-agents" }
)

$availableSkills = @(copilot skill list --json | ConvertFrom-Json)

foreach ($skill in $deprecatedSkills) {
    $installed = $availableSkills | Where-Object {
        $_.source -eq "personal-copilot" -and $_.name -eq $skill.Name
    }

    if ($installed) {
        & copilot skill remove $skill.Name
        if ($LASTEXITCODE -ne 0) {
            throw "Failed to remove deprecated skill '$($skill.Name)'."
        }
    }

    $legacyPath = Join-Path $personalSkills $skill.Directory
    if (Test-Path $legacyPath) {
        Remove-Item -LiteralPath $legacyPath -Recurse -Force
    }
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

$unexpectedPersonalSkills = @(
    Get-ChildItem -LiteralPath $personalSkills -Directory -ErrorAction SilentlyContinue |
        Where-Object { $_.Name -ne "repository-locations" } |
        Select-Object -ExpandProperty Name
)

if ($unexpectedPersonalSkills) {
    throw "Unexpected personal skills remain: $($unexpectedPersonalSkills -join ', ')."
}

Write-Host "Registered $($expectedSkills.Count) repository skills."
Write-Host "Preserved personal skill: repository-locations."
Write-Host "Run /skills reload in active Copilot CLI sessions."
