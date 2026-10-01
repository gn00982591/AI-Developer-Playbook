# AI Developer Playbook

個人的 AI 開發工作方法與規則母版。

### 安裝

第一次導入 Playbook、建立 Project `AGENTS.md`、確認 `.ai-rules/` / PowerShell 定位：

**[`docs/Installation.md`](docs/Installation.md)**

### 使用

日常如何啟動 Preset、直接呼叫 Stage / Skill、串接多個階段、使用 Diagram Profile：

**[`docs/Usage.md`](docs/Usage.md)**

## 執行模型

Preset 定義主任務與預設 Workflow；Workflow 描述 Stage / Skill 的建議順序。執行各階段時，按需載入 Rule Module、Profile 與 Modifier。

### 各類型的責任

| 類型 | 責任 | 範例 |
| --- | --- | --- |
| Preset | 定義任務目標與預設流程 | `bug-fix`、`system-design` |
| Workflow | 描述多個階段的建議順序 | `explore` → `apply` → `verify` |
| Stage / Skill | 執行可獨立呼叫的階段能力 | `explore`、`apply`、`review` |
| Rule Module | 提供階段執行規則 | `agents/explore.md` |
| Profile | 指定輸出的具體策略 | `module-map`、`call-chain` |
| Modifier | 補充本次需求或輸出條件 | `compact`、`risk` |

完整定義見 [Architecture Definitions](docs/Architecture_Definitions.md)。需求分流依 [Spec Engine Strategy](docs/Spec_Strategy.md)：正式變更沿用 Spec Kit 或 OpenSpec 產物，小型明確變更保留 Lightweight；既有路徑與成果直接接續。

### 日常執行方式

可使用 Preset 啟動主任務，也可以直接呼叫 Stage / Skill。Workflow 是建議順序，可依需求從中間開始、略過不需要的階段，或重複執行某個階段。

一般修改流程：

`explore` → `propose` → `apply` → `verify` → `review`

System Design 範例：

```text
# 啟動系統設計任務。
Preset: system-design

# 分析現有結構。
Stage: explore

# 依模組關係繪圖。
Stage: diagram
Profile: module-map

# 複查分析與圖表。
Stage: review
```

以上是 Playbook 的語意格式，平台可映射成原生 Skill 或 Command。

### 階段間的上下文延續

同一任務切換 Stage 時，保留需求、Findings、Decisions、Spec / Tasks、相關檔案、Diff、Test Result 與輸出條件。只有缺少必要資訊或來源異動時，才補讀相關資料。

切換 Stage 不清空 `.ai-rules/`、不重新掃描整個 Repository，也不重新執行 `apply-preset.ps1`。

詳細規則見 [Stage Execution](docs/Stage_Execution.md)。

### PowerShell 的定位

`apply-preset.ps1` 用於第一次導入、規則同步、規則組合測試，以及舊 Snapshot 模式相容。日常任務直接在同一 Context 中呼叫 Stage / Skill，無須透過 PowerShell 切換。

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
| [`docs/Repository_Structure.md`](docs/Repository_Structure.md) | Repository 目錄與檔案導覽 |
| [`docs/Workflow.md`](docs/Workflow.md) | 需求分流、Stage 執行與交付流程 |
| [`docs/Backlog.md`](docs/Backlog.md) | 待辦索引與中斷續作紀錄 |
| [`CHANGELOG.md`](CHANGELOG.md) | 正式版本更新紀錄 |

## 控版規則

待處理與未完成事項集中索引於 **[待辦與續作紀錄](docs/Backlog.md)**；每筆 Playbook 待辦由 `docs/backlog/active/<ID>-<slug>/` 獨立保存處理內容，不由 OpenSpec 或 Spec Kit 管理。中斷前更新進度、剩餘工作與下一步，續作時從索引讀取對應資料夾；完成並驗證通過且記入 `CHANGELOG.md` 後，移除 Backlog 總表項目與對應處理資料夾；完成紀錄由 CHANGELOG 與 Git commit 保存。

只有明確確認「更新 Playbook」或「這版確認，可以更新」後才修改 Repository。

每次正式修改應：

- 建立 Git commit。
- 更新 `CHANGELOG.md`。
- 保留修改目的與原因。
- 優先最小修改與規則重用。
