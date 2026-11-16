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

$ProjectAgents = Join-Path $ProjectRoot 'AGENTS.md'
$Template = Join-Path $PlaybookPath 'templates/AGENTS.md'
$Marker = '<!-- ai-developer-playbook:security-workflow -->'
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
    if (-not $ExistingRules.Contains($Marker)) {
        $TemplateRules = Get-Content -LiteralPath $Template -Raw -Encoding UTF8
        $BlockPattern = '(?s)<!-- ai-developer-playbook:security-workflow -->.*?<!-- /ai-developer-playbook:security-workflow -->'
        $Block = [regex]::Match($TemplateRules, $BlockPattern)
        if (-not $Block.Success) {
            throw 'Security workflow entry missing from AGENTS.md template.'
        }
        $Newline = [Environment]::NewLine
        if ($ExistingRules.Contains("`r`n")) {
            $Newline = "`r`n"
        } elseif ($ExistingRules.Contains("`n")) {
            $Newline = "`n"
        }
        $Entry = $Block.Value -replace '\r?\n', $Newline
        [System.IO.File]::AppendAllText($ProjectAgents, "$Newline$Newline$Entry$Newline", $Encoding)
    }
}

Write-Host "Security workflow registered in $ProjectAgents"
