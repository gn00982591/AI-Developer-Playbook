param (
    [Parameter(Mandatory = $true)]
    [string]$ProjectPath
)

$ErrorActionPreference = 'Stop'
$PlaybookPath = Split-Path -Parent $PSScriptRoot
$ProjectRoot = (Resolve-Path -LiteralPath $ProjectPath).ProviderPath
$ExpectedPlaybookPath = Join-Path $ProjectRoot '.agents/AI-Developer-Playbook'
if ((Resolve-Path -LiteralPath $ExpectedPlaybookPath).ProviderPath -ne $PlaybookPath) {
    throw 'Expected Playbook under the target project at .agents/AI-Developer-Playbook.'
}

$SecurityIndex = Join-Path $PlaybookPath 'docs/security/README.md'
if (-not (Test-Path -LiteralPath $SecurityIndex -PathType Leaf)) {
    throw "Security workflow index missing: $SecurityIndex"
}

$CommentsGuide = Join-Path $PlaybookPath 'agents/code-comments.md'
if (-not (Test-Path -LiteralPath $CommentsGuide -PathType Leaf)) {
    throw "Code comments guide missing: $CommentsGuide"
}

$ProgressGuide = Join-Path $PlaybookPath 'agents/project-progress.md'
if (-not (Test-Path -LiteralPath $ProgressGuide -PathType Leaf)) {
    throw "Project progress guide missing: $ProgressGuide"
}

$ProjectAgents = Join-Path $ProjectRoot 'AGENTS.md'
$Template = Join-Path $PlaybookPath 'templates/AGENTS.md'
if (-not (Test-Path -LiteralPath $ProjectAgents)) {
    Copy-Item -LiteralPath $Template -Destination $ProjectAgents
} else {
    $Reader = [System.IO.StreamReader]::new($ProjectAgents, $true)
    try {
        $ExistingRules = $Reader.ReadToEnd()
        $Encoding = $Reader.CurrentEncoding
    } finally {
        $Reader.Dispose()
    }
    $TemplateRules = Get-Content -LiteralPath $Template -Raw -Encoding UTF8
    $Newline = [Environment]::NewLine
    if ($ExistingRules.Contains("`r`n")) {
        $Newline = "`r`n"
    } elseif ($ExistingRules.Contains("`n")) {
        $Newline = "`n"
    }

    $Entries = foreach ($Workflow in @('security-workflow', 'code-comments', 'project-progress')) {
        # Older templates and documented manual entries already load this rule.
        if ($Workflow -eq 'project-progress' -and
            $ExistingRules -cmatch '(?m)^[^\r\n]*更新進度時，載入[^\r\n]*agents/project-progress\.md') {
            continue
        }
        $Marker = "<!-- ai-developer-playbook:$Workflow -->"
        if (-not $ExistingRules.Contains($Marker)) {
            $EndMarker = "<!-- /ai-developer-playbook:$Workflow -->"
            $BlockPattern = '(?s)' + [regex]::Escape($Marker) + '.*?' + [regex]::Escape($EndMarker)
            $Block = [regex]::Match($TemplateRules, $BlockPattern)
            if (-not $Block.Success) {
                throw "Workflow entry missing from AGENTS.md template: $Workflow"
            }
            $Block.Value -replace '\r?\n', $Newline
        }
    }
    if ($Entries) {
        $Separator = $Newline + $Newline
        $Entry = $Entries -join $Separator
        [System.IO.File]::AppendAllText($ProjectAgents, "$Separator$Entry$Newline", $Encoding)
    }
}

Write-Host "Security, code comments, and project progress workflows registered in $ProjectAgents"
