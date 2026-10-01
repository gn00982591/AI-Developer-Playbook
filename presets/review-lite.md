# Preset: Review Lite

適用於希望 Agent 再檢查一次，但只審查本次變更、避免大量 Token 的情況。

## 載入規則

- `agents/core.md`
- `agents/data-access.md`（涉及資料存取時套用；Snapshot 一併複製）
- `agents/code-review.md`
- `agents/token-saving.md`

## 檢查範圍

1. 優先檢查目前 `git diff`、指定 Commit 或指定檔案。
2. 只列出明確錯誤、回歸風險、資料一致性、安全性與必要測試缺口。
3. 不摘要正常程式碼，不重新分析整個 Repository。
4. 若必須讀取 Diff 以外的檔案，先說明原因並限制在直接相依範圍。
5. Review 結論最多列出 10 項，依風險排序。

## 建議流程

```text
Diff → Findings → 必要時局部驗證
```

預設不載入 Explore、Apply 與 Testing。若確認需要修改，切換至 `bug-fix` Preset。

正式變更按需引用 Engine 產物與驗收；Lightweight 核對已確認方案。程式審查、規格一致性與實測結果分開回報；維持 Diff 優先及最多 10 項 Findings，不額外執行完整 Engine 流程。
