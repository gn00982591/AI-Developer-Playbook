# Playbook Architecture Definitions

本文件整理 AI Developer Playbook 的核心概念與責任邊界。

目的不是立即把每個概念都實作成獨立檔案，而是先統一名詞，避免 Preset、Workflow、規則、圖表、輸出與共用元件互相混用。

## 核心原則

```text
Preset
  ↓
Workflow
  ↓
Stage
  ↓
Rule / Profile
  ↓
Modifier
  ↓
Output Management
```

另外由 Registry 與 Data References 提供跨需求可重複使用的專案知識。

## 定義總表

| 名稱 | 責任 | 解決的問題 | 是否由使用者直接指定 |
| --- | --- | --- | --- |
| Preset | 定義大的任務類型 | 這次要完成什麼工作 | 是 |
| Workflow | 定義可重複使用的工作流程 | 任務要依什麼流程完成 | 通常否 |
| Stage | Workflow 內的一個步驟 | 將大流程拆成可組合的小段 | 通常否 |
| Rule Module | 定義跨流程的行為規則 | 每個步驟應遵守什麼原則 | 否 |
| Profile | 定義某類輸出的具體策略 | 同一 Stage 下不同輸出如何處理 | 可指定 |
| Modifier | 本次任務的附加需求 | 不建立新 Preset 也能調整輸出 | 是 |
| Output Management | 統一管理 AI 產物位置 | 避免不同 AI 各自建立輸出目錄 | 否 |
| Reusable Registry | 記錄可重複使用的元件與 Pattern | 避免隔很久後重新做出另一套 | 否 |
| Data References | 提供可靠的專案資料參照 | 避免每次重新猜測或全專案重掃 | 待後續定義 |

---

## 1. Preset

Preset 代表「大的任務類型」，不是每一個小功能都建立一個 Preset。

例如：

```text
bug-fix
new-feature
sql-change
system-design
review-lite
```

Preset 應負責：

- 任務目標。
- 需要載入哪些規則。
- 預設 Workflow。
- 必要驗證或完成條件。

不應建立：

```text
module-map preset
data-flow preset
api-table preset
risk-analysis preset
```

這些應由 Profile 或 Modifier 處理。

---

## 2. Workflow

Workflow 代表「完成任務時可重複使用的流程」。

目的：不要讓每個 Preset 都各自重新定義完整流程。

例如 Bug Fix：

```text
Understand
→ Locate
→ Analyze
→ Modify
→ Verify
→ Review
```

例如 New Feature：

```text
Understand
→ Impact Analysis
→ Reuse Check
→ Design
→ Implement
→ Verify
→ Review
```

不同 Preset 可以共用相同 Workflow 或 Stage，例如：

```text
impact-analysis
reuse-check
verification
review
```

Workflow 是否需要正式建立 `workflows/` 目錄，後續再依實際重複程度決定，不要求第一版立即建立。

---

## 3. Stage

Stage 是 Workflow 裡的一個可重複步驟。

例如 System Design：

```text
Discover
Analyze
Diagram
Document
Review
```

Stage 的目的：

- 細化大流程。
- 讓不同 Preset 共用部分流程。
- 可以依任務需要執行、略過或縮小範圍。
- 避免每個小工作都變成另一個 Preset。

---

## 4. Rule Module

Rule Module 負責「怎麼做」，不是「這次要做什麼」。

目前 `agents/` 即屬於這一層，例如：

```text
agents/core.md
agents/explore.md
agents/testing.md
agents/token-saving.md
agents/diagramming.md
```

後續可能新增的共用規則包括：

```text
output-management
reuse-and-shared-components
```

是否建立實際檔案，應等規則內容定案後再處理。

---

## 5. Profile

Profile 是某個領域或 Stage 內的「具體處理策略」。

目前 Diagram Profile：

```text
module-map
business-flow
call-chain
state-transition
data-flow
```

Profile 不應變成新的頂層 Preset。

例如：

```text
Preset: system-design
Stage: Diagram
Profile: module-map
```

---

## 6. Modifier

Modifier 是本次任務的附加需求。

目的是避免為每個小需求建立新的 Preset、Agent 或 Component。

建議概念：

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

Modifier 只表示「這次額外需要什麼」，不應自己主導完整 Workflow。

後續應建立一張「我要做什麼 → 使用什麼 Modifier」的對照表，讓使用者不需要記住底層規則檔。

---

## 7. Output Management

不同 AI 不應自行決定輸出位置。

建議原則：

```text
.ai-output/
├─ reports/
├─ diagrams/
├─ images/
├─ data/
└─ temp/
```

責任區分：

```text
.ai-output/
= AI 一次性工作產物

docs/
= 已確認需要長期保留的正式文件
```

基本規則：

1. 所有一次性 AI 產物預設集中於 `.ai-output/`。
2. AI 不得自行建立其他頂層輸出目錄。
3. 依產物用途分類，不依 ChatGPT、Codex、Claude、Cursor 等 AI 工具分類。
4. 正式文件確認後才進入 `docs/`。
5. Preset 不自行決定輸出目錄，由共用 Output Management 規則管理。

此項目前為架構定義，實際規則檔與腳本支援待後續實作。

---

## 8. Reusable Registry

對於「很久才再次遇到，但其實高度重複」的功能，不應依賴 AI 記憶。

典型案例：

- 下拉選單。
- 日期區間。
- Status Mapping。
- API Wrapper。
- 權限處理。
- Table / Modal / Pagination。
- 共用 Query。

建議每個實際 Project 維護 Registry，例如：

```text
.ai-rules/reusable-patterns.md
```

建議狀態：

```text
local
→ 目前只供單一功能使用

candidate
→ 已出現重複跡象，值得追蹤

shared
→ 正式共用，不應再建立平行實作
```

範例：

| Pattern | 狀態 | 實作位置 | Data Source | 使用範圍 |
| --- | --- | --- | --- | --- |
| Plant Selector | shared | `PlantSelect.vue` | `/Utils/GetPlant` | 全域 |
| Customer Selector | candidate | 多個頁面 | `/Utils/GetCustomer` | 訂單 |
| Date Range | shared | `DateRange.vue` | - | 查詢頁 |

建議流程：

```text
新需求
→ 搜尋既有實作
→ 查 Reusable Registry
→ 判斷沿用 / 擴充 / 新增
```

原則上不要看到第二次使用就強制抽象；先記錄 candidate，重複程度足夠後再正式 shared，避免過度設計。

---

## 9. Data References

Data References 已列入整體架構，但目前尚未完成定義。

暫定責任：

> 提供 AI 在執行 Workflow 時可查詢的可靠專案資料來源，避免每次重新掃描、重新猜測或重複建立相同知識。

可能包含：

```text
database
api
business-rules
status-codes
integrations
```

目前先保留概念，不建立正式目錄與規則；後續討論完成後再決定與 Registry、AGENTS.md、`.ai-rules/` 的邊界。

---

## 整體責任模型

```text
使用者需求
   │
   ├─ Preset
   │   └─ 我要完成什麼任務
   │
   ├─ Workflow / Stage
   │   └─ 任務依什麼流程執行
   │
   ├─ Rule / Profile
   │   └─ 每個步驟怎麼做
   │
   ├─ Modifier
   │   └─ 這次額外需要什麼
   │
   ├─ Registry / Data References
   │   └─ 有哪些既有知識與可重用資產
   │
   └─ Output Management
       └─ 產物放在哪裡
```

## 目前先做與暫不做

### 先固定

- Preset、Workflow、Stage、Rule Module、Profile、Modifier 的名詞與邊界。
- Output Management 的方向。
- Reusable Registry 的方向。
- Data References 保留成待討論項目。

### 暫不實作

- 不立即新增大量小 Preset。
- 不立即把每個 Stage 都拆成獨立檔案。
- 不立即修改 `apply-preset.ps1` 支援 Workflow / Modifier。
- 不立即建立 `.ai-output/`。
- 不立即建立 Reusable Registry Template。
- 不立即建立 Data References 目錄。

等各概念確認後，再依最小修改原則逐步實作。