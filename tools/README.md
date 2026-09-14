# Tools

此資料夾保存 Playbook 的輔助工具。

## apply-preset.ps1

用途：將指定 Preset 所需的 `agents/*.md` 規則複製到目標 Project 的 `.ai-rules/`。

### 使用範例

```powershell
# 修 Bug。
.\tools\apply-preset.ps1 -Preset "bug-fix" -ProjectPath "D:\Projects\OrderSystem"

# 新功能。
.\tools\apply-preset.ps1 -Preset "new-feature" -ProjectPath "D:\Projects\OrderSystem"

# SQL 變更。
.\tools\apply-preset.ps1 -Preset "sql-change" -ProjectPath "D:\Projects\OrderSystem"

# System Design。
.\tools\apply-preset.ps1 -Preset "system-design" -ProjectPath "D:\Projects\OrderSystem"
```

### 行為

- 讀取 `presets/<preset>.md`。
- 找出其中引用的 `agents/*.md`。
- 清除目標 Project 既有 `.ai-rules/`。
- 只複製本次 Preset 需要的規則。
- 不修改 Project 的 `AGENTS.md`。

詳細說明請見 `docs/Preset_Sync.md`。
