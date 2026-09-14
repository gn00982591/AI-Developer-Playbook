param (
    # 要套用的 Preset 名稱，例如 bug-fix、new-feature、sql-change、system-design。
    [Parameter(Mandatory = $true)]
    [string]$Preset,

    # 實際開發專案的根目錄。
    [Parameter(Mandatory = $true)]
    [string]$ProjectPath
)

# 取得目前 apply-preset.ps1 所在的 tools 資料夾。
$ToolsPath = $PSScriptRoot

# Playbook 根目錄位於 tools 的上一層。
$PlaybookPath = Split-Path -Parent $ToolsPath

# 組出 Preset 檔案完整路徑。
$PresetPath = Join-Path $PlaybookPath "presets\$Preset.md"

# Project 中實際載入 AI 規則的位置。
$TargetRulesPath = Join-Path $ProjectPath ".ai-rules"

# 檢查 Preset 是否存在。
if (-not (Test-Path $PresetPath)) {
    throw "找不到 Preset：$PresetPath"
}

# 檢查 Project 是否存在，避免輸入錯誤路徑後建立到錯誤位置。
if (-not (Test-Path $ProjectPath)) {
    throw "找不到 Project：$ProjectPath"
}

# 讀取 Preset 全部內容。
$PresetContent = Get-Content -Path $PresetPath -Encoding UTF8

# 從 Preset 中抓出類似 `agents/core.md` 的規則路徑。
$AgentFiles = foreach ($Line in $PresetContent) {
    if ($Line -match '`(agents\/[^`]+\.md)`') {
        # 將 Markdown 中的 / 轉成 Windows 路徑格式。
        $Matches[1].Replace('/', '\')
    }
}

# 移除重複規則。
$AgentFiles = $AgentFiles | Sort-Object -Unique

# 如果完全沒有找到 agents 規則，代表 Preset 格式可能有問題。
if (-not $AgentFiles) {
    throw "Preset 中沒有找到任何 agents/*.md 規則：$PresetPath"
}

# 如果舊的 .ai-rules 已存在，先整個清除，避免上一個 Preset 的規則殘留。
if (Test-Path $TargetRulesPath) {
    Remove-Item -Path $TargetRulesPath -Recurse -Force
}

# 建立新的 .ai-rules。
New-Item -Path $TargetRulesPath -ItemType Directory -Force | Out-Null

foreach ($AgentFile in $AgentFiles) {
    # Playbook 中來源規則的完整路徑。
    $SourceFile = Join-Path $PlaybookPath $AgentFile

    # 只取檔案名稱，例如 agents\core.md → core.md。
    $FileName = Split-Path -Path $AgentFile -Leaf

    # Project 中的目的檔案位置。
    $DestinationFile = Join-Path $TargetRulesPath $FileName

    # 確認來源規則真的存在。
    if (-not (Test-Path $SourceFile)) {
        throw "Preset 引用了不存在的規則：$SourceFile"
    }

    # 將本次需要的規則複製到 Project。
    Copy-Item -Path $SourceFile -Destination $DestinationFile -Force

    Write-Host "載入規則：$FileName"
}

Write-Host ""
Write-Host "Preset 套用完成：$Preset"
Write-Host "Project：$ProjectPath"
Write-Host "Rules：$TargetRulesPath"
