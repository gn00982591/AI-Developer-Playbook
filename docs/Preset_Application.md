# Preset 套用方式

本文件定義如何把 `AI-Developer-Playbook` 的 Preset 實際套用到某個 Project。

## 核心模型

```text
Playbook = 規則母庫
Preset = 本次任務的規則選單
.ai-rules/ = 本次實際載入的規則
AGENTS.md = Project 固定規則
```

實際執行時：

```text
Project AGENTS.md
+
Project .ai-rules/
=
本次有效規則
```

## 引入使用方式

以下流程分為一次性設定與每次任務操作。

### 一次性設定

#### 步驟 1：準備中央 Playbook

```powershell
# 第一次使用時 Clone。
git clone https://github.com/gn00982591/AI-Developer-Playbook.git

# 已有 Playbook 時更新內容。
Set-Location "D:\AI-Developer-Playbook"
git pull
```

#### 步驟 2：建立 Project AGENTS.md

只有目標 Project 尚未存在 `AGENTS.md` 時才複製模板。

```powershell
# 避免覆蓋 Project 既有規則。
$ProjectPath = "D:\Projects\OrderSystem"
if (-not (Test-Path "$ProjectPath\AGENTS.md")) {
    Copy-Item ".\templates\AGENTS.md" "$ProjectPath\AGENTS.md"
}
```

#### 步驟 3：填寫 Project 固定內容

在 `AGENTS.md` 填寫 Tech Stack、Build/Test、DB、架構、目錄與業務限制。任務型規則不寫入此檔。

### 每次任務操作

#### 步驟 4：選擇 Preset

| 任務 | Preset |
| --- | --- |
| Bug 修正 | `bug-fix` |
| 新功能 | `new-feature` |
| SQL / SP / DB 變更 | `sql-change` |
| System Design / 交接文件 | `system-design` |
| Diff 快速複查 | `review-lite` |

#### 步驟 5：同步規則到 Project

```powershell
# 在 Playbook 根目錄執行，Preset 名稱不含 .md。
.\tools\apply-preset.ps1 -Preset "bug-fix" -ProjectPath "D:\Projects\OrderSystem"
```

工具會：

1. 讀取 `presets/bug-fix.md`。
2. 解析其中引用的 `agents/*.md`。
3. 清除舊的 `Project/.ai-rules/`。
4. 複製本次需要的規則。
5. 保留 `Project/AGENTS.md`。

#### 步驟 6：確認 .ai-rules/

```powershell
# 列出本次已載入規則。
Get-ChildItem "D:\Projects\OrderSystem\.ai-rules"
```

Bug Fix 的結果應為：

```text
.ai-rules/
├─ core.md
├─ explore.md
├─ apply.md
├─ testing.md
└─ token-saving.md
```

#### 步驟 7：以目標 Project 為工作目錄

在 Codex / ChatGPT Work 開啟 `D:\Projects\OrderSystem`，不要把中央 Playbook 當成本次開發工作目錄。

#### 步驟 8：輸入啟動 Prompt

```text
請先讀取專案根目錄 AGENTS.md，再讀取 .ai-rules/ 內的規則檔。
本次只使用這些規則處理任務，不要重新掃描中央 Playbook。

本次任務為 Bug Fix：
[描述問題]

先確認根因與影響範圍，再採最小修改完成修正與必要驗證。
```

#### 步驟 9：切換任務時重新套用

```powershell
# 範例：從目前任務切換成 Review Lite。
.\tools\apply-preset.ps1 -Preset "review-lite" -ProjectPath "D:\Projects\OrderSystem"
```

重新套用後，確認 `.ai-rules/`，再開啟新對話並輸入對應任務 Prompt；`AGENTS.md` 不需更換。

### 引入完成檢查

- Project 根目錄有 `AGENTS.md`。
- Project 根目錄有 `.ai-rules/`。
- `.ai-rules/` 只包含本次 Preset 所需規則。
- Agent 的工作目錄是實際 Project。
- 任務 Prompt 已要求讀取 `AGENTS.md` 與 `.ai-rules/`。

## 為什麼不直接把 Preset 內容寫進 AGENTS.md

`AGENTS.md` 應保存長期固定的 Project-specific 規則，例如：

- Tech Stack
- Build / Test 指令
- Folder / Architecture Notes
- Database Rules
- Business Constraints
- Project-specific Rules

Bug Fix、New Feature、SQL Change、System Design 等屬於任務型規則，應由 Preset 決定，不應反覆改寫 `AGENTS.md`。

## Project 建議結構

```text
Project/
├─ AGENTS.md
├─ .ai-rules/
│  ├─ core.md
│  ├─ token-saving.md
│  └─ ...本次任務需要的規則
├─ src/
└─ ...
```

`.ai-rules/` 是執行層，只放本次任務需要的規則。

## Preset 語法

Preset 使用 Markdown 編寫。同步工具會從反引號內解析 `agents/*.md` 路徑，因此每個規則必須使用以下格式：

````markdown
# Preset: Review Lite

適用情境說明。

## 載入規則

- `agents/core.md`
- `agents/code-review.md`
- `agents/token-saving.md`
````

規則：

- Preset 檔名使用小寫 kebab-case，例如 `bug-fix.md`、`review-lite.md`。
- 引用路徑必須是 `agents/<name>.md`。
- 被引用的檔案必須存在。
- Preset 只列出需要載入的模組，不重複撰寫 Agent 規則內容。

## Preset 套用指令

```powershell
# 套用 Bug Fix Preset。
.\tools\apply-preset.ps1 -Preset "bug-fix" -ProjectPath "D:\Projects\OrderSystem"

# 套用 Review Lite Preset。
.\tools\apply-preset.ps1 -Preset "review-lite" -ProjectPath "D:\Projects\OrderSystem"
```

這不是 `/Bug-Fix` Slash Command。Preset 名稱由 PowerShell 的 `-Preset` 參數傳入；套用完成後，再用一般文字告訴 Agent 本次任務內容。

## 套用 Bug Fix Preset

來源：`presets/bug-fix.md`

需要：

```text
agents/core.md
agents/explore.md
agents/apply.md
agents/testing.md
agents/token-saving.md
```

Project 中 materialize 成：

```text
.ai-rules/
├─ core.md
├─ explore.md
├─ apply.md
├─ testing.md
└─ token-saving.md
```

本次任務有效規則：

```text
AGENTS.md
+
.ai-rules/core.md
+
.ai-rules/explore.md
+
.ai-rules/apply.md
+
.ai-rules/testing.md
+
.ai-rules/token-saving.md
```

## 套用 New Feature Preset

```text
.ai-rules/
├─ core.md
├─ explore.md
├─ propose.md
├─ apply.md
├─ testing.md
├─ archive.md
└─ token-saving.md
```

建議啟動：

```text
請先讀 AGENTS.md 與 .ai-rules/。
本次是 New Feature，先確認需求與影響範圍，再依規格實作、驗證並整理變更結果。
```

## 套用 SQL Change Preset

```text
.ai-rules/
├─ core.md
├─ sql.md
├─ apply.md
├─ testing.md
└─ token-saving.md
```

若影響範圍不清楚，再加入 `explore.md`；若屬大型變更，再加入 `propose.md`。

建議啟動：

```text
請先讀 AGENTS.md 與 .ai-rules/。
本次是 SQL Change，僅分析與修改需求直接相關的 SQL / SP / DB 物件，採最小修改並執行必要驗證。
```

## 套用 System Design Preset

```text
.ai-rules/
├─ core.md
├─ explore.md
├─ system-design.md
└─ token-saving.md
```

純分析任務不載入 `apply.md` 與 `testing.md`。

建議啟動：

```text
請先讀 AGENTS.md 與 .ai-rules/。
本次是 System Design，只分析與文件化，不修改 Source Code；先搜尋定位，再讀必要檔案。
```

## 套用 Review Lite Preset

```text
.ai-rules/
├─ core.md
├─ code-review.md
└─ token-saving.md
```

建議啟動：

```text
請先讀 AGENTS.md 與 .ai-rules/。
本次只複查目前 git diff；只列出明確錯誤與回歸風險，不摘要正常程式碼。若必須擴大範圍，先說明原因。
```

若確認需要修改，切換至 `bug-fix` Preset。

## Rule Precedence

若規則衝突，建議優先順序：

```text
1. 使用者本次明確指示
2. Project AGENTS.md
3. 本次 .ai-rules/ 任務規則
4. Playbook 通用預設
```

Project 的實際限制應優先於通用 Playbook，但不得覆蓋使用者本次明確要求。

## Token 原則

- 不把整個 Playbook 複製到 Project。
- 不把所有 `agents/` 都載入 `.ai-rules/`。
- 只 materialize 本次 Preset 所列模組。
- 若需求已清楚，可刪除不必要的 `explore.md`。
- 不要求 Agent 每次重新掃描中央 Playbook。
- 任務完成後可清除 `.ai-rules/` 或切換成下一個 Preset。

核心原則：

```text
Load only required rules.
```

## 未來自動化

可再增加安裝/同步機制：

```text
選擇 Preset
↓
讀取 preset 所列 agents
↓
同步到 Project/.ai-rules/
↓
保留 Project/AGENTS.md 不變
↓
用固定啟動指令載入 AGENTS.md + .ai-rules/
```

未自動化前，也可手動複製所需規則檔案。
