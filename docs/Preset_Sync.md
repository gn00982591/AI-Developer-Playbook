# Preset 同步工具

本文件說明如何使用 `tools/apply-preset.ps1`，將指定 Preset 所需的規則同步到目標 Project 的 `.ai-rules/`。

## 目的

將原本手動挑選與複製規則的流程自動化：

```text
選擇 Preset
↓
讀取 presets/<preset>.md
↓
解析其中引用的 agents/*.md
↓
清除目標 Project/.ai-rules/
↓
複製 Preset 規則與共用 security/ 目錄
```

Project 的 `AGENTS.md` 不會被修改。

## 使用方式

在 `AI-Developer-Playbook` 根目錄執行：

PowerShell 範例請先進入 `D:\WorkGit\YFYTMSWeb\.agents\AI-Developer-Playbook`。從 CMD 呼叫的完整指令見 [Installation Snapshot 說明](Installation.md#snapshot-相容模式)；腳本仍需要 PowerShell。

```powershell
# 套用 Bug Fix Preset 到指定 Project。
.\tools\apply-preset.ps1 `
    -Preset "bug-fix" `
    -ProjectPath "D:\WorkGit\YFYTMSWeb"
```

其他 Preset：

```powershell
# 新功能。
.\tools\apply-preset.ps1 -Preset "new-feature" -ProjectPath "D:\WorkGit\YFYTMSWeb"

# SQL 變更。
.\tools\apply-preset.ps1 -Preset "sql-change" -ProjectPath "D:\WorkGit\YFYTMSWeb"

# System Design。
.\tools\apply-preset.ps1 -Preset "system-design" -ProjectPath "D:\WorkGit\YFYTMSWeb"
```

## 執行結果

以 `bug-fix` 為例，Project 會得到：

```text
Project/
├─ AGENTS.md
└─ .ai-rules/
   ├─ core.md
   ├─ data-access.md
   ├─ explore.md
   ├─ apply.md
   ├─ frontend.md
   ├─ testing.md
   └─ token-saving.md
```

切換成 `system-design` 後，工具會先清除舊 `.ai-rules/`，再建立：

```text
.ai-rules/
├─ core.md
├─ data-access.md
├─ explore.md
├─ system-design.md
├─ frontend.md
├─ diagramming.md
└─ token-saving.md
```

每次同步也會產生 `.ai-rules/security/README.md` 及對應主題。程式開發任務依索引按需讀取。首次導入或更新時，由 [Installation](Installation.md#2-安裝-playbook) 登記專案入口。

## 建議 Git 設定

`.ai-rules/` 是 Runtime 規則快照，建議不要 Commit 到實際 Project。

在 Project 的 `.gitignore` 加入：

```gitignore
# AI Developer Playbook runtime rules
.ai-rules/
```

真正的 Source of Truth 是中央 Playbook：

```text
AI-Developer-Playbook/
├─ agents/
├─ presets/
└─ tools/apply-preset.ps1
```

而 Project 長期保存的則是：

```text
AGENTS.md
```

## Agent / Codex 啟動方式

同步完成後，在任務開始時使用：

```text
請先讀取專案根目錄 AGENTS.md，再讀取 .ai-rules/ 內的規則檔。
本次只使用這些規則處理任務，不要重新掃描中央 Playbook。
```

## 注意事項

- 工具會刪除目標 Project 既有的 `.ai-rules/` 後重建。
- 不要在 `.ai-rules/` 放需要永久保存的手動內容。
- Preset 必須以 Markdown code reference 的方式列出 `agents/*.md`，工具才會解析到。
- 若 Preset 引用不存在的 Agent 規則，工具會停止並顯示錯誤。
- `ProjectPath` 必須是已存在的目錄。

## 核心原則

```text
Playbook = Source of Truth
Preset = Rule Selection
.ai-rules/ = Runtime Snapshot
AGENTS.md = Project-specific Rules
```

## 資料存取規則與專案索引

各 Preset 的 Snapshot 一併複製 data-access.md；只有涉及資料存取時套用。實際資料庫索引保存在 Project 的 docs/data-access/ 或既有正式位置，不放入會被清除的 .ai-rules/。同步工具只複製規則，不生成專案索引；格式與維護流程見 [Data Access](Data_Access.md)。

同步或核對參照時，以 Preset 的 `agents/*.md` 清單與共用資安目錄為準；保留來源版本與同步日期。Snapshot 步驟使用 `.ai-rules/` 下的同名規則和 `security/` 索引。規則中的母庫文件連結可從已安裝的 Playbook 開啟。
