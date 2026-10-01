# Preset: SQL Change

適用於 Stored Procedure、SQL 查詢、資料表欄位與資料庫邏輯變更。

## 載入規則

- `agents/core.md`
- `agents/data-access.md`（涉及資料存取時套用；Snapshot 一併複製）
- `agents/sql.md`
- `agents/apply.md`
- `agents/testing.md`
- `agents/token-saving.md`

## 建議流程

```text
確認影響範圍 → Apply → Test
```

若問題位置不清楚，先加入 `explore.md`；若變更較大，加入 `propose.md`。

## 分流與完成條件

小型明確 SQL 調整採 Lightweight；正式變更依 [Spec Engine Strategy](../docs/Spec_Strategy.md) 選擇 Engine，不只以加入 propose 取代正式變更管理。

驗證受影響資料與行為，依 data-access 規則同步資料存取 MD；未執行項目與限制明列。
