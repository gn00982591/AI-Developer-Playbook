# Core Rules

所有開發任務預設套用的核心規則。

## 原則

- 採最小修改（Minimal Change）。
- 不修改與需求無關的程式。
- 不進行無關 Refactor。
- 資訊不足時明確列出缺漏，不自行推測未知需求。
- 先搜尋定位，再讀取必要檔案。
- 避免全面掃描 Repository。
- 優先沿用既有 Findings、Spec、Tasks 與驗證結果。
- 每個階段只完成自己的責任，不重做上一階段工作。
- 回報實際修改內容、影響範圍與驗證結果。

## 安全邊界

- 不保存或複製公司機密、帳密、Connection String、正式資料或專有程式碼到個人 Playbook。
- 專案特殊規則應保留在該 Project 的 `AGENTS.md` 或 `project-rules.md`。
