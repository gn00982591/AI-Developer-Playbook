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

## AI Developer Playbook 發版

每次同步 Playbook 變更到 GitHub 時，確認本次是否發新版本。正式版本以 `CHANGELOG.md`、Git Tag 與已發佈的 GitHub Release 一起交付。

1. 合併前將版本號、日期與本版更新摘要寫入 `CHANGELOG.md`，納入同一批變更。
2. 合併後確認 `main` 的版本提交已包含本版變更與更新紀錄，將同名 Tag（例如 `v0.30`）指向該提交。若已有同名 Tag，先核對指向；指向不同時記錄差異。
3. 在 GitHub Releases 使用同名 Tag 發佈 Release，摘要沿用該版更新紀錄。若已有該版草稿，接續處理；若已發佈，核對內容與指向。
4. 回查 GitHub Releases 頁面與 Tag 指向，交付版本號、提交及 Release 連結。遇到權限或工具限制時，列出實際已完成的項目與待發佈的版本。

只同步工作分支或尚未發版的變更時，保留於 `CHANGELOG.md` 的「下一版」，正式發版時再依上述步驟處理。
