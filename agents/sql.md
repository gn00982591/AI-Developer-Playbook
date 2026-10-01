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
