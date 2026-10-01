# AI Developer Playbook

個人的 AI 開發工作方法與規則母版。

本 Repository 用來保存可跨公司、跨專案重複使用的 AI 開發流程、Prompt、Token 節省原則、Preset、Stage / Skill 與工作 SOP；不保存公司專有程式碼、帳號、連線資訊、正式資料或其他機密內容。

## Start Here

為避免 README 後續重整時把安裝步驟與實際使用方式一起改掉，兩者改為獨立文件維護。

建議固定閱讀順序：

```text
1. Installation
2. Usage
3. 需要時再查詳細架構文件
```

### 1. 安裝

第一次導入 Playbook、建立 Project `AGENTS.md`、確認 `.ai-rules/` / PowerShell 定位：

**[`docs/Installation.md`](docs/Installation.md)**

### 2. 使用

日常如何啟動 Preset、直接呼叫 Stage / Skill、串接多個階段、使用 Diagram Profile：

**[`docs/Usage.md`](docs/Usage.md)**

> README 只保存整體導覽與核心模型；安裝與使用細節以以上兩份文件為準。

## 目的

- 保存可長期沿用的 AI 開發方法。
- 管理 ChatGPT / Codex 等 AI 的開發流程。
- 降低大型 Repository 重複掃描與重複分析造成的 Token 浪費。
- 將主任務、執行階段、共用規則與專案差異分離。
- 讓流程可直接呼叫不同 Stage，而不是每次重新安裝或切換規則。

## 核心模型

```text
Preset
「我要完成什麼主任務」
        │
        └─ Workflow
           「預設怎麼走」
                │
                ├─ Stage / Skill
                ├─ Stage / Skill
                └─ Stage / Skill
                     │
                     ├─ Rule Module
                     ├─ Profile
                     └─ Modifier
```

核心原則：

> Preset 負責編排；Stage / Skill 負責執行；Rule Module 負責規則；PowerShell 不負責 Runtime Flow。

## 核心責任

| 類型 | 責任 | 範例 |
| --- | --- | --- |
| Preset | 定義主任務與預設流程 | `bug-fix`、`system-design` |
| Workflow | 定義多個 Stage 的建議順序 | Explore → Apply → Verify |
| Stage / Skill | 可直接呼叫的執行能力 | `explore`、`apply`、`review` |
| Rule Module | 定義怎麼做 | `agents/explore.md` |
| Profile | 特定輸出策略 | `call-chain` |
| Modifier | 本次附加需求 | `compact`、`risk` |

完整定義：[`docs/Architecture_Definitions.md`](docs/Architecture_Definitions.md)。

## Runtime 執行模型

日常操作不要求每次切換 Preset 都執行 `apply-preset.ps1`。

主任務開始後，直接在同一 Context 中呼叫需要的 Stage：

```text
Stage: explore
→ Stage: propose
→ Stage: apply
→ Stage: verify
→ Stage: review
```

例如 System Design：

```text
Preset: system-design

Stage: explore
Stage: diagram
Profile: module-map
Stage: review
```

切換 Stage 時：

- 保留目前任務 Context。
- 沿用 Findings、Spec、Diff、Test Result。
- 不清空 `.ai-rules/`。
- 不重新掃描整個 Repository。
- 不重新執行 PowerShell。

詳細 Runtime 規則：[`docs/Stage_Execution.md`](docs/Stage_Execution.md)。

## Preset

目前主任務 Preset：

```text
bug-fix
new-feature
sql-change
system-design
review-lite
```

Preset 不應為每個小功能建立一個版本。

例如以下不建立頂層 Preset：

```text
module-map
data-flow
api-table
risk-analysis
```

這些應使用 Profile 或 Modifier。

## Stage / Skill

第一版沿用既有 `agents/` 作為 Rule Module，不複製另一套規則。

| Stage / Skill | 主要規則 |
| --- | --- |
| `explore` | `agents/explore.md` |
| `propose` | `agents/propose.md` |
| `apply` | `agents/apply.md` |
| `verify` | `agents/testing.md` |
| `review` | `agents/code-review.md` |
| `diagram` | `agents/diagramming.md` |
| `archive` | `agents/archive.md` |
| `sql` | `agents/sql.md` |
| `system-design` | `agents/system-design.md` |

標準平台中立語意：

```text
Stage: explore
```

或：

```text
Stage: diagram
Profile: call-chain
選項: compact
```

實際操作範例統一放在 [`docs/Usage.md`](docs/Usage.md)。

## System Design 與 Diagram Profile

| Diagram Profile | 用途 |
| --- | --- |
| `module-map` | 模組、責任、系統邊界與高階相依 |
| `business-flow` | 業務步驟、判斷與結果 |
| `call-chain` | 入口到各層或外部服務的呼叫順序 |
| `state-transition` | 狀態、事件、條件與轉移 |
| `data-flow` | 資料來源、轉換、儲存與消費端 |

Diagram Profile 是圖的種類，不是頂層 Preset。

詳細 Mermaid 規則：`agents/diagramming.md`。

## 資料存取與多資料庫

涉及資料庫時套用 [agents/data-access.md](agents/data-access.md)：先查專案資料庫索引、ContextProcedures、Result 與 SQL 本體，再決定沿用或修改。阻擋逐筆補查、取完整候選後篩選及可在資料庫完成卻由 C# 拼接的查詢。

產生或修改資料存取程式時，同步所屬資料庫 MD；跨資料庫整合另記錄批次範圍、交易與一致性。規則與文件格式見 [docs/Data_Access.md](docs/Data_Access.md)，實際公司資訊保留在 Project。

## PowerShell 的定位

`tools/apply-preset.ps1` 保留，但定位為：

- 第一次導入或特殊同步。
- 舊 `.ai-rules/` Snapshot 模式相容工具。
- 固定某一組規則快照。
- 測試某個 Preset 的 Rule Module 組合。

不再用於同一任務內的 Stage 切換。

```text
PowerShell = 安裝 / 同步 / 相容性
Stage / Skill = 日常 Runtime 執行
```

安裝與 Snapshot 指令統一放在 [`docs/Installation.md`](docs/Installation.md)。

## 與實際 Project 的關係

```text
AI-Developer-Playbook
├─ agents/      共用 Rule Module
├─ presets/     主任務與預設流程
├─ docs/        安裝、使用、架構文件
└─ tools/       安裝 / 同步 / 相容工具
        │
        ▼
實際 Project
├─ AGENTS.md    Project 固定規則與 Playbook 入口
├─ .agents/
│  └─ AI-Developer-Playbook/  獨立控版的規則母庫
├─ .ai-rules/   可選的本地規則 / Registry / Snapshot
├─ .ai-output/  一次性 AI 產物
└─ docs/        正式文件
```

## Output Management

一次性 AI 產物建議統一：

```text
.ai-output/
├─ reports/
├─ diagrams/
├─ images/
├─ data/
└─ temp/
```

正式文件確認後才移入 `docs/`。

## Token 節省原則

```text
Scan once.
Document once.
Reuse afterward.
Load only required rules.
```

優先：

- Search first。
- Read only relevant files。
- Minimal change。
- Reuse previous findings。
- Limit test scope。
- Stage 只載入需要的 Rule Module。

## Repository 結構

圖表導覽：

- **[Repository 結構關係圖](docs/Repository_Structure.md)**：依資料夾與檔案層級查看實際目錄，點選檔名開啟內容。
- **[Playbook 工作流程](docs/Workflow.md)**：需求分流、Stage 執行、資料存取檢查與交付流程。

## Rule Precedence

```text
1. 使用者本次明確指示
2. Project AGENTS.md
3. 本次 Stage / Skill 規則
4. Playbook 通用規則
```

## 控版規則

待處理與未完成事項集中索引於 **[待辦與續作紀錄](docs/Backlog.md)**；每筆 Playbook 待辦由 `docs/backlog/active/<ID>-<slug>/` 獨立保存處理內容，不由 OpenSpec 或 Spec Kit 管理。中斷前更新進度、剩餘工作與下一步，續作時從索引讀取對應資料夾；完成並驗證通過後整個資料夾移至 `docs/backlog/archive/`，同步更新索引狀態與連結。

只有明確確認「更新 Playbook」或「這版確認，可以更新」後才修改 Repository。

每次正式修改應：

- 建立 Git commit。
- 更新 `CHANGELOG.md`。
- 保留修改目的與原因。
- 優先最小修改與規則重用。

## 文件導覽

| 文件 | 用途 |
| --- | --- |
| [`docs/Installation.md`](docs/Installation.md) | 第一次安裝、導入、Snapshot / PowerShell 定位 |
| [`docs/Usage.md`](docs/Usage.md) | 日常 Preset、Stage / Skill、Profile 操作 |
| [`docs/Data_Access.md`](docs/Data_Access.md) | ContextProcedures 前置檢查、多資料庫索引與同步完成條件 |
| [`docs/Architecture_Definitions.md`](docs/Architecture_Definitions.md) | 架構名詞與責任邊界 |
| [`docs/Stage_Execution.md`](docs/Stage_Execution.md) | Runtime Flow Continuity |
| [`docs/Preset_Application.md`](docs/Preset_Application.md) | Preset 與 Runtime / Snapshot 關係 |
| [`docs/Preset_Sync.md`](docs/Preset_Sync.md) | `.ai-rules/` Snapshot 同步細節 |

## 設計原則摘要

```text
Playbook = 規則母庫
Preset = 主任務 / 流程編排
Stage / Skill = 可直接呼叫的階段能力
Rule Module = 執行規則
Profile / Modifier = 本次輸出調整
PowerShell = 安裝 / 同步 / 相容性工具
AGENTS.md = Project 固定規則
```

README 負責導覽，Installation 與 Usage 分開維護，避免後續架構調整時再次遺失安裝或使用步驟。
