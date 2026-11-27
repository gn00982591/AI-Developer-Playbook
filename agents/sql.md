# SQL Rules

適用於 SQL Server、Stored Procedure、查詢與資料庫變更任務。

## 規則

- SQL 內容需要保留清楚註解，說明目的與非直覺邏輯。
- 使用臨時表時，建立前先使用 `DROP TABLE IF EXISTS #TempName`。
- 優先採最小 SQL 修改，不順手重構無關查詢。
- 修改資料型別、條件、JOIN、GROUP BY 或交易邏輯前，先確認影響範圍。
- 不自行推測資料欄位或 Schema；資訊不足時列出缺漏。
- 涉及資料更新時，先區分查詢驗證與正式修改語句。
- 回報受影響的 Stored Procedure、Table、Column 與可能的相依項目。

涉及資料存取時，另套用 [Data Access Rules](data-access.md)，沿用同版本已核對的索引與來源，只補讀本次直接相依內容。

## 分流與驗證

- 小型明確調整保留 Lightweight；正式變更依 [Spec Engine Strategy](../docs/Spec_Strategy.md) 分流，沿用所選 Engine 產物。
- 在既有產物記錄有涉及的 Table / Column / Key、讀寫、交易、相容性、驗收與復原方式，不另建 DB Spec。
- 按需驗證正常、邊界、異常、重複執行與交易一致性；回報實測結果及無環境而未執行項目。

## SQL Server 與 ORM 相容驗證

- 依 [資料存取規則](data-access.md) 核對欄位、代碼、配號與保存契約。採用允許跳號的 SQL Server Sequence 時，以唯一性與關聯一致性驗收。
- 專案使用 EF Core 時，可從實際保存入口核對新的或已載入追蹤的 Entity、`DbContext` 生成值映射、`SaveChangesAsync()` 的交易範圍及主鍵回讀。依專案實際架構與映射測試。
- SP 增減參數前，盤點實際呼叫端、預設值及回傳契約。多個入口需共用處理時，優先沿用共用方法，必要時最小幅新增。單一入口依既有契約調整。附呼叫端清單，驗證原有及新使用方式的相容結果。

SQL 初始化、資料升級與退役依 [遷移與退役](../docs/security/套件建置與部署.md#遷移與退役) 驗證。
