# Preset: Requirement Intake

用於需求尚未確定應走 Spec Kit、OpenSpec 或 Lightweight Flow 的入口階段。

## 目標

先整理需求來源與不確定性，再決定後續 Spec Engine；不要在入口階段重做完整 spec / plan / tasks。

## 建議 Workflow

```text
Collect
→ Clarify
→ Analyze Impact
→ Diagram（需要才做）
→ Route
```

## 載入規則

- `agents/core.md`
- `agents/data-access.md`（涉及資料存取時套用；Snapshot 一併複製）
- `agents/explore.md`
- `agents/diagramming.md`（需要圖表時）
- `agents/token-saving.md`

## Requirement Workspace

若需求來自訪談、文件、截圖、既有 UI 或多輪討論，可建立 `requirements/` 工作區保存來源與分析。

詳細結構與責任：`docs/Spec_Strategy.md`。

## Router

### Spec Kit

選擇條件：大型、新功能、需求仍有明顯不確定性、需要完整 specification → plan → tasks → implementation 流程。

### OpenSpec

選擇條件：既有系統的中小型正式變更，需要 Current Truth / Delta Change 與正式變更紀錄。

### Lightweight Flow

選擇條件：Bug、小型 SQL/UI/Validation 調整，需求與修改位置已清楚，不值得建立完整 Spec Artifact。

## 完成條件

至少確認：

- 問題或需求目標。
- 已知範圍。
- 主要來源。
- 重要未確認事項。
- UI / Business / Data / State 影響（有涉及才整理）。
- 建議後續路徑：Spec Kit / OpenSpec / Lightweight。

## 限制

- 不因為使用本 Preset 就建立全部 Requirement Workspace 子資料夾。
- 不複製 Spec Kit / OpenSpec 已管理的正式 Artifact。
- 不把 Pending / Assumption 寫成已確認需求。
- 不為了畫圖重新掃描已確認內容。
