# Playbook Architecture Definitions

本文件整理 AI Developer Playbook 的核心概念與責任邊界。

## 核心原則

日常執行不應靠 PowerShell 在不同 Preset 間反覆切換規則。Preset 負責描述「主任務」，Stage / Skill 負責可直接呼叫的「階段能力」，Rule Module 提供各能力所需規則。

```text
使用者需求
   │
   ├─ Preset（可選）
   │   └─ 主任務與預設流程
   │
   ├─ Stage / Skill
   │   └─ 可直接呼叫的執行階段
   │
   ├─ Rule / Profile
   │   └─ 執行方式與輸出策略
   │
   ├─ Modifier
   │   └─ 本次附加條件
   │
   ├─ Registry / Data References
   │   └─ 可重用資產與可信資料來源
   │
   └─ Output Management
       └─ 產物存放位置
```

PowerShell 只屬於安裝、同步、相容性工具，不主導 Runtime Flow。

## 定義總表

| 名稱 | 責任 | 使用方式 |
| --- | --- | --- |
| Preset | 定義完整任務與預設 Stage 順序 | 可直接指定主任務 |
| Workflow | 描述多個 Stage 的建議順序 | 由 Preset 或使用者選用 |
| Stage / Skill | 可獨立呼叫的執行能力 | 可直接指定，不必切 Preset |
| Rule Module | 定義 Stage 執行時的規則 | 由 Stage / Skill 引用 |
| Profile | 某類輸出的具體策略 | 可在 Stage 中指定 |
| Modifier | 本次附加需求 | 可與 Preset / Stage 同時指定 |
| Output Management | 統一 AI 產物位置 | 全域規則 |
| Reusable Registry | 記錄共用元件與 Pattern | 執行前按需查詢 |
| Data References | 提供可信專案資料參照 | 待後續細化 |

## 1. Preset

Preset 代表大的任務類型，例如：

```text
bug-fix
new-feature
sql-change
system-design
review-lite
```

Preset 應負責：

- 任務目標。
- 預設 Workflow。
- 建議 Stage。
- 預設 Rule / Profile。
- 完成條件。

Preset 不代表 Runtime 規則切換開關，也不要求每次透過 `apply-preset.ps1` 重新 materialize `.ai-rules/`。

例如 `system-design` 可以定義：

```text
Discover → Analyze → Diagram → Document → Review
```

但執行中的任一 Stage 都可以被單獨呼叫。

## 2. Workflow

Workflow 是多個 Stage 的建議流程。

例如：

```text
Bug Fix
Understand → Locate → Analyze → Modify → Verify → Review

System Design
Discover → Analyze → Diagram → Document → Review
```

Workflow 不是不可中斷的程序。可依任務：

- 從中間 Stage 開始。
- 略過不需要的 Stage。
- 在同一工作上下文中補呼叫其他 Stage。
- 重複某一 Stage 而不重建整個流程。

## 3. Stage / Skill

Stage / Skill 是日常操作的主要執行單位。

例如：

```text
explore
propose
apply
verify
review
diagram
archive
```

使用者可以直接要求：

```text
Stage: explore
```

或：

```text
Stage: diagram
Profile: call-chain
```

也可以在同一任務中依序呼叫：

```text
explore
→ propose
→ apply
→ verify
```

### Flow Continuity

切換 Stage 不得清除或替換目前的工作上下文。

Stage 應沿用：

- 已確認的需求。
- 前一階段 Findings。
- 已讀取的相關檔案。
- 已產出的 Spec / Tasks。
- 已完成的 Diff / Test Result。
- 本次任務的 Modifier 與輸出需求。

因此：

```text
Stage 切換 ≠ 規則安裝
Stage 切換 ≠ 清空 .ai-rules/
Stage 切換 ≠ 重新開始任務
```

## 4. Rule Module

`agents/` 保存最小化規則模組，例如：

```text
agents/core.md
agents/explore.md
agents/propose.md
agents/apply.md
agents/testing.md
agents/diagramming.md
agents/code-review.md
agents/token-saving.md
```

Rule Module 負責「怎麼做」，不負責 Runtime 切換。

Stage / Skill 可以引用一個或多個 Rule Module。例如：

```text
Stage: verify
→ testing.md
→ token-saving.md
```

## 5. Profile

Profile 是某個 Stage 內的具體處理策略。

Diagram Profile：

```text
module-map
business-flow
call-chain
state-transition
data-flow
```

例如：

```text
Stage: diagram
Profile: module-map
```

Profile 不建立新的頂層 Preset。

## 6. Modifier

Modifier 是本次附加需求，不主導完整 Workflow。

```text
圖:
- module-map
- data-flow

表:
- modules
- database

選項:
- compact
- risk
- diff-review
```

Preset、Stage、Profile、Modifier 可以同時存在，例如：

```text
Preset: system-design
Stage: diagram
Profile: module-map
選項: compact
```

## 7. Runtime 與 PowerShell 邊界

### Runtime

主任務開始後，應直接呼叫 Preset / Stage / Skill，不執行 PowerShell 切換。

```text
同一任務 Context
├─ Stage: explore
├─ Stage: propose
├─ Stage: apply
├─ Stage: verify
└─ Stage: review
```

### PowerShell

`tools/apply-preset.ps1` 保留作為舊 Snapshot 模式與相容性工具。

可用於：

- 第一次導入。
- 測試某個 Preset 的規則組合。
- 舊專案仍採 `.ai-rules/` Snapshot 模式。

不建議用於：

- 同一任務中 Stage 切換。
- System Design → Diagram → Review 這類流程內切換。
- 多 Skill 並行或串接時重新安裝規則。

## 8. Output Management

一次性 AI 產物預設集中：

```text
.ai-output/
├─ reports/
├─ diagrams/
├─ images/
├─ data/
└─ temp/
```

正式文件確認後才進入 `docs/`。

基本規則：

1. AI 不自行建立其他頂層輸出資料夾。
2. 依產物用途分類，不依 AI 工具分類。
3. Preset / Stage 不自行決定另一套輸出位置。

## 9. Reusable Registry

對高度重複但可能隔很久才再次出現的功能，使用 Registry，而不是依賴 AI 記憶。

建議專案維護：

```text
.ai-rules/reusable-patterns.md
```

狀態：

```text
local
candidate
shared
```

流程：

```text
新需求
→ 搜尋既有實作
→ 查 Registry
→ 判斷沿用 / 擴充 / 新增
```

## 10. Data References

Data References 已列入架構，但尚未完成定義。

暫定責任：提供 Stage / Skill 執行時可查詢的可靠專案資料來源，避免重掃與重新猜測。

可能包含：

```text
database
api
business-rules
status-codes
integrations
```

後續再決定與 Registry、AGENTS.md、`.ai-rules/` 的邊界。

## 最終責任模型

```text
Preset
「我要完成什麼任務」
        │
        └─ Workflow
           「預設怎麼走」
                │
                ├─ Stage / Skill A
                ├─ Stage / Skill B
                └─ Stage / Skill C
                     │
                     ├─ Rule Module
                     ├─ Profile
                     └─ Modifier

Registry / Data References
→ 提供可重用知識

Output Management
→ 統一管理產物
```

核心原則：

> Preset 負責編排；Stage / Skill 負責執行；Rule Module 負責規則；PowerShell 不負責 Runtime Flow。