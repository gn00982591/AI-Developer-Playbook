# Tools

此資料夾保存 Playbook 的輔助工具。

## apply-preset.ps1

用途：將指定 Preset 所需的 `agents/*.md` 規則複製到目標 Project 的 `.ai-rules/`。

### 使用範例

PowerShell 範例請先進入 `D:\WorkGit\YFYTMSWeb\.agents\AI-Developer-Playbook`。從 CMD 呼叫的完整指令見 [Installation Snapshot 說明](../docs/Installation.md#snapshot-相容模式)；腳本仍需要 PowerShell。

```powershell
# 修 Bug。
.\tools\apply-preset.ps1 -Preset "bug-fix" -ProjectPath "D:\WorkGit\YFYTMSWeb"

# 新功能。
.\tools\apply-preset.ps1 -Preset "new-feature" -ProjectPath "D:\WorkGit\YFYTMSWeb"

# SQL 變更。
.\tools\apply-preset.ps1 -Preset "sql-change" -ProjectPath "D:\WorkGit\YFYTMSWeb"

# System Design。
.\tools\apply-preset.ps1 -Preset "system-design" -ProjectPath "D:\WorkGit\YFYTMSWeb"

# 低 Token 複查。
.\tools\apply-preset.ps1 -Preset "review-lite" -ProjectPath "D:\WorkGit\YFYTMSWeb"
```

### 語法說明

`-Preset` 傳入 `presets/` 中不含副檔名的檔名，例如 `bug-fix` 或 `review-lite`。

這套工具不會建立 `/Bug-Fix` Slash Command；套用語法是 PowerShell 指令。

### 行為

- 讀取 `presets/<preset>.md`。
- 找出其中引用的 `agents/*.md`。
- 清除目標 Project 既有 `.ai-rules/`。
- 只複製本次 Preset 需要的規則。
- 不修改 Project 的 `AGENTS.md`。

詳細說明請見 `docs/Preset_Sync.md`。
