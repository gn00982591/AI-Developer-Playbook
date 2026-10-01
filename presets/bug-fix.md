# Preset: Bug Fix

適用於問題原因尚未完全確定的 Bug 修正。

## 載入規則

- `agents/core.md`
- `agents/data-access.md`（涉及資料存取時套用；Snapshot 一併複製）
- `agents/explore.md`
- `agents/apply.md`
- `agents/testing.md`
- `agents/token-saving.md`

## 建議流程

```text
Explore → Apply → Test
```

小型修正保留 Lightweight；影響擴大、正式行為變更或需求不確定時，依 [Spec Engine Strategy](../docs/Spec_Strategy.md) 重新判斷路徑，沿用所選 Engine，必要時加入 `propose.md` 與 Archive。

## 完成條件

核對原始症狀、預期行為與受影響路徑，執行必要回歸驗證；分別列出已通過、失敗與未執行項目，未驗證不得宣告修正完成。
