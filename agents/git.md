# Git Rules

適用於 Branch、Commit、Diff 與版本控制相關任務。

## 規則

- 修改前先確認目前 Branch 與工作目錄狀態。
- 不覆蓋使用者尚未提交的變更。
- Commit 應只包含本次 Change 相關內容。
- Commit message 要能說明變更目的，不使用無意義訊息。
- Review 時以 Git Diff 為主要依據，不重新掃描整個 Repository。
- 需要建立 Branch 時，名稱應能反映需求或變更主題。
- 不執行 force push、history rewrite 或破壞性操作，除非使用者明確要求。
