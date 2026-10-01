# Code Review Rules

適用於程式碼審查與變更檢查。

## 規則

- 優先檢查本次 Diff，不全面重讀 Repository。
- 先找 correctness、regression、資料一致性、安全性與測試缺口，再看風格問題。
- 不把個人偏好當成必修修改。
- 問題要指出具體檔案、區段與影響。
- 若無法確認，標記為待驗證，不自行推測成缺陷。
- 對高風險問題優先排序。
- Review 結論應區分：必修、建議、待確認。

涉及資料存取時，另套用 [Data Access Rules](data-access.md)，沿用同版本已核對的索引與來源，只補讀本次直接相依內容。

## 規格與驗證一致性

- 正式變更按需核對 Engine 的相關規格、Tasks 與驗收；Lightweight 核對已確認方案，不強制建立 Spec。
- 比對需求、實作與驗證證據，只補讀 Diff 直接相關產物。
- 分開回報程式審查、規格一致性與實測結果；Engine 文件檢查不替代 Build / Test。
