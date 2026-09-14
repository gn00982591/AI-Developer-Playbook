# AI Developer Playbook

個人的 AI 開發工作方法與規則母版。

本 Repository 用來保存可跨公司、跨專案重複使用的 AI 開發流程、Prompt、Token 節省原則、Preset、Stage / Skill 與工作 SOP；不保存公司專有程式碼、帳號、連線資訊、正式資料或其他機密內容。

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

另外由 Registry / Data References 提供可重用知識，由 Output Management 統一管理產物位置。

核心原則：

> Preset 負責編排；Stage / Skill 負責執行；Rule Module 負責規則；PowerShell 不負責 Runtime Flow。

## Runtime 執行模型

日常操作不再要求每次切換 Preset 都執行 `apply-preset.ps1`。

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

詳細規則：`docs/Stage_Execution.md`。

## Preset、Stage、Rule 的責任

| 類型 | 責任 | 範例 |
| --- | --- | --- |
| Preset | 定義主任務與預設流程 | `bug-fix`、`system-design` |
| Workflow | 定義多個 Stage 的建議順序 | Explore → Apply → Verify |
| Stage / Skill | 可直接呼叫的執行能力 | `explore`、`apply`、`review` |
| Rule Module | 定義怎麼做 | `agents/explore.md` |
| Profile | 特定輸出策略 | `call-chain` |
| Modifier | 本次附加需求 | `compact`、`risk` |

完整定義：`docs/Architecture_Definitions.md`。

## Stage / Skill 直接呼叫

第一版先沿用既有 `agents/` 作為 Rule Module，不複製另一套規則。

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

標準語意格式：

```text
Stage: explore
```

或：

```text
Stage: diagram
Profile: call-chain
選項: compact
```

這是 Playbook 的平台中立語意。未來可由 ChatGPT、Codex、Cursor、Claude 等 Adapter 映射成各平台原生 Skill / Command。

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

## System Design 與 Diagram Profile

System Design 可使用 `agents/diagramming.md` 的 Diagram Profile：

| Diagram Profile | 用途 |
| --- | --- |
| `module-map` | 模組、責任、系統邊界與高階相依 |
| `business-flow` | 業務步驟、判斷與結果 |
| `call-chain` | 入口到各層或外部服務的呼叫順序 |
| `state-transition` | 狀態、事件、條件與轉移 |
| `data-flow` | 資料來源、轉換、儲存與消費端 |

使用方式：

```text
Stage: diagram
Profile: data-flow
```

不需要先退出 System Design，也不需要重新套用 Preset。

## PowerShell 的定位

`tools/apply-preset.ps1` 保留，但定位改為：

- 舊 `.ai-rules/` Snapshot 模式相容工具。
- 測試某個 Preset 的規則組合。
- 第一次導入或特殊同步用途。

不再建議用於：

- 同一任務中 Explore → Apply 的切換。
- System Design → Diagram → Review 的流程切換。
- 多個 Skill 串接時重新安裝規則。

換句話說：

```text
PowerShell = 安裝 / 同步 / 相容性
Stage / Skill = 日常 Runtime 執行
```

## 與實際 Project 的關係

```text
AI-Developer-Playbook
├─ agents/      共用 Rule Module
├─ presets/     主任務與預設流程
├─ docs/        架構與使用說明
└─ tools/       安裝 / 同步 / 相容工具
        │
        ▼
實際 Project
├─ AGENTS.md    Project 固定規則
├─ .ai-rules/   可選的本地規則 / Registry / Snapshot
├─ .ai-output/  一次性 AI 產物
└─ docs/        正式文件
```

`AGENTS.md` 保存長期 Project-specific 規則，例如 Tech Stack、Build/Test、DB 規範、架構與業務限制。

## Reusable Registry

高度重複、但可能隔很久才再次遇到的功能，不依賴 AI 記憶。

建議 Project 維護：

```text
.ai-rules/reusable-patterns.md
```

狀態：

```text
local
candidate
shared
```

新需求先：

```text
搜尋既有實作
→ 查 Registry
→ 判斷沿用 / 擴充 / 新增
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

不同 AI 不應各自建立 `chatgpt-output/`、`codex-output/`、`results/` 等頂層目錄。

## OPSX 標準流程

```text
Explore
↓
Findings
↓
Propose
↓
Spec / Tasks
↓
Apply
↓
Diff / Test
↓
Archive
```

但這不是強制一次全部執行。

| 狀況 | 建議流程 |
| --- | --- |
| 不知道問題在哪 | Explore → Propose → Apply → Verify |
| 已知道問題與修改位置 | Propose → Apply → Verify |
| 規格非常清楚 | Apply → Verify |
| 只想複查 | Review |
| 只需要畫圖 | Diagram + Profile |

## Token 節省原則

```text
Scan once.
Document once.
Reuse afterward.
Load only required rules.
```

避免：

- 全 Repository 重複掃描。
- Stage 切換時重新理解同一需求。
- 為簡單任務讀取全部 Rule Module。
- 為了切換流程重新跑 PowerShell。

優先：

- Search first。
- Read only relevant files。
- Minimal change。
- Reuse previous findings。
- Limit test scope。
- Stage 只載入需要的 Rule Module。

## Repository 結構

```text
AI-Developer-Playbook/
├─ agents/
│  ├─ core.md
│  ├─ explore.md
│  ├─ propose.md
│  ├─ apply.md
│  ├─ archive.md
│  ├─ sql.md
│  ├─ git.md
│  ├─ testing.md
│  ├─ system-design.md
│  ├─ diagramming.md
│  ├─ code-review.md
│  └─ token-saving.md
│
├─ presets/
│  ├─ bug-fix.md
│  ├─ new-feature.md
│  ├─ sql-change.md
│  ├─ system-design.md
│  └─ review-lite.md
│
├─ docs/
│  ├─ Architecture_Definitions.md
│  ├─ Stage_Execution.md
│  ├─ OPSX_Workflow.md
│  ├─ Token_Saving.md
│  ├─ Preset_Application.md
│  └─ Preset_Sync.md
│
├─ templates/
│  └─ AGENTS.md
│
├─ tools/
│  ├─ apply-preset.ps1
│  └─ README.md
│
└─ CHANGELOG.md
```

## Rule Precedence

若規則衝突，建議順序：

```text
1. 使用者本次明確指示
2. Project AGENTS.md
3. 本次 Stage / Skill 規則
4. Playbook 通用規則
```

## 控版規則

只有明確確認「更新 Playbook」或「這版確認，可以更新」後才修改 Repository。

每次正式修改應：

- 建立 Git commit。
- 更新 `CHANGELOG.md`。
- 保留修改目的與原因。
- 優先最小修改與規則重用。

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

目標不是建立越來越大的 Prompt，也不是每切一個流程就重裝規則，而是建立一套可以在同一任務 Context 中直接組合、切換與重複使用的能力。