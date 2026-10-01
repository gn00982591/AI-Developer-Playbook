# Explore Rules

適用於需求、問題原因或修改位置尚未清楚的任務。

## 目標

以最小探索範圍找出必要的現況流程、根因、影響檔案與修改方向。

## 規則

- 先搜尋，再讀檔案。
- 不全面掃描 Repository。
- 只讀與需求直接相關的程式。
- 不修改程式。
- 不做無關架構分析。
- 找到必要呼叫鏈即可。
- 找不到時再逐步擴大搜尋範圍。

## 建議輸出

1. Current Flow
2. Root Cause（問題診斷時）
3. Affected Files
4. Affected API / SP / Table
5. Proposed Direction
6. Unknowns

涉及資料存取時，另套用 [Data Access Rules](data-access.md)，沿用同版本已核對的索引與來源，只補讀本次直接相依內容。

## Findings 接續

- 記錄必要來源檔案、符號或需求來源，區分已確認事實、Pending / Assumption 與 Unknowns。
- 有涉及時補 UI、Business Rule、Data / Table Impact、State；不因分析建立全部文件。
- 優先沿用既有 Findings 與 Engine 產物，來源異動或缺漏才補查。
- 需求探索不強制提出根因；本階段不建立另一套正式 spec / plan / tasks。
