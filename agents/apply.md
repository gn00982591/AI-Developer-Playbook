# Apply Rules

適用於正式規格與 Tasks，或 Lightweight 方案與驗收已確認、可以開始修改程式的任務。

## 規則

- 正式變更依所選 Engine 的規格與 Tasks 實作；Lightweight 依已確認方案、影響範圍與驗收實作，不強制建立 Spec。
- Engine 原生 implement / apply 與本 Stage 共用同一份 Tasks 和結果，不重做已完成項目。
- 發現需求或設計缺口時補查必要來源或列出待確認事項，不把假設當成已確認需求。
- 採最小修改。
- 不重新做需求分析。
- 不重新探索整個 Repository。
- 不做無關 Refactor。
- 優先只修改 Affected Files。
- 只有遇到缺漏、編譯錯誤或必要依賴時才擴大搜尋。
- 完成後執行必要 Build / Test。
- 回報實際修改檔案與驗證結果。

涉及資料存取時，另套用 [Data Access Rules](data-access.md)，沿用同版本已核對的索引與來源，只補讀本次直接相依內容。
