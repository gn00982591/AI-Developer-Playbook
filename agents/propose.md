# Propose Rules

適用於需求已確認，需要整理方案或引導所選 Spec Engine 建立正式變更的任務。

## 規則

- 優先使用 Explore Findings。
- 不重新掃描 Repository。
- 只有 Findings 明確不足時才補充必要搜尋。
- 規格保持精簡，避免重複描述已知背景。

## 按需檢查的內容

- Scope
- Out of Scope
- Current Behavior
- Expected Behavior
- Technical Design
- Affected Files
- DB Impact
- Acceptance Criteria
- Tasks

涉及資料存取時，另套用 [Data Access Rules](data-access.md)，沿用同版本已核對的索引與來源，只補讀本次直接相依內容。

## 產物責任

- 沿用已確認路徑；尚未分流時依 [Spec Engine Strategy](../docs/Spec_Strategy.md) 判斷。
- 正式變更引用所選 Engine 的規格、設計與 Tasks；上述項目用於檢查缺口，不建立另一套同義文件。
- Lightweight 只整理實作所需方案、影響範圍與驗收條件；Tasks 按需列出，不強制建立正式 Spec。
- 保留來源引用與 Pending / Assumption，未確認內容不得當成實作依據。
