# AI Developer Playbook

個人的 AI 開發工作方法與規則母版。

### 安裝

第一次導入 Playbook、建立 Project `AGENTS.md`、確認 `.ai-rules/` / PowerShell 定位：

**[`docs/Installation.md`](docs/Installation.md)**

### 使用

日常如何啟動 Preset、直接呼叫 Stage / Skill、串接多個階段、使用 Diagram Profile：

**[`docs/Usage.md`](docs/Usage.md)**

## Runtime 執行模型＋核心責任

Preset 定義主任務與預設 Workflow；Workflow 編排 Stage / Skill；各階段依需要載入 Rule Module、Profile 與 Modifier。

| 類型 | 責任 | 範例 |
| --- | --- | --- |
| Preset | 定義主任務與預設流程 | `bug-fix`、`system-design` |
| Workflow | 定義多個 Stage 的建議順序 | Explore → Apply → Verify |
| Stage / Skill | 可直接呼叫的執行能力 | `explore`、`apply`、`review` |
| Rule Module | 定義怎麼做 | `agents/explore.md` |
| Profile | 特定輸出策略 | `call-chain` |
| Modifier | 本次附加需求 | `compact`、`risk` |

完整定義：[`docs/Architecture_Definitions.md`](docs/Architecture_Definitions.md)。

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

PowerShell 負責第一次安裝、同步與 Snapshot 相容，不負責 Runtime Flow。

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

待處理與未完成事項集中索引於 **[待辦與續作紀錄](docs/Backlog.md)**；每筆 Playbook 待辦由 `docs/backlog/active/<ID>-<slug>/` 獨立保存處理內容，不由 OpenSpec 或 Spec Kit 管理。中斷前更新進度、剩餘工作與下一步，續作時從索引讀取對應資料夾；完成並驗證通過後整個資料夾移至 `docs/backlog/archive/`，同步更新索引狀態與連結。

只有明確確認「更新 Playbook」或「這版確認，可以更新」後才修改 Repository。

每次正式修改應：

- 建立 Git commit。
- 更新 `CHANGELOG.md`。
- 保留修改目的與原因。
- 優先最小修改與規則重用。
