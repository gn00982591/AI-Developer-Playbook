# Apply Rules

適用於正式規格與 Tasks，或 Lightweight 方案與驗收已確認、可以開始修改程式的任務。

## 規則

- 正式變更依所選 Engine 的規格與 Tasks 實作；Lightweight 依已確認方案、影響範圍與驗收實作，不強制建立 Spec。
- Engine 原生 implement / apply 與本 Stage 共用同一份 Tasks 和結果，不重做已完成項目。
- 發現需求或設計缺口時補查必要來源或列出待確認事項，不把假設當成已確認需求。
- 採最小修改。依模組與功能群組放置端點、資料存取及測試。跨模組能力沿用共用層，搬移時核對依賴、註冊、呼叫契約、測試及文件。
- 不重新做需求分析。
- 不重新探索整個 Repository。
- 不做無關 Refactor。
- 優先只修改 Affected Files。
- 只有遇到缺漏、編譯錯誤或必要依賴時才擴大搜尋。
- 完成後執行必要 Build / Test。
- 回報實際修改檔案與驗證結果。

依已確認的[開發資安控制](../docs/security/README.md)實作。若新增資料流、權限範圍或外部依賴，先補查直接相關的控制與驗收條件。

涉及資料存取時，另套用 [Data Access Rules](data-access.md)，沿用同版本已核對的索引與來源，只補讀本次直接相依內容。

涉及前端實作或集中語系資料來源切換時，載入 [前端共用元件與語系](frontend.md)。 Snapshot 優先載入同名規則，缺少時從已安裝的 Playbook 補讀。
