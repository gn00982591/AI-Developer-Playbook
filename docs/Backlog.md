# 待辦與續作紀錄

集中保存 Playbook 本身的待處理事項與未完成工作的接續資訊，避免只依賴對話記憶。

實際專案的工作記錄保留在該專案；此 Repository 不保存公司程式碼、連線資訊或機密內容。

## 記錄位置與責任

| 內容 | 保存位置 |
| --- | --- |
| Playbook 待辦與中斷後的續作資訊 | 本文件 |
| 實際專案待辦與續作索引 | 該專案的 `docs/Backlog.md`（需要時建立） |
| 未確認需求與待釐清問題 | 該專案的 `requirements/analysis/open-questions.md` |
| Spec Kit / OpenSpec 的正式工作清單 | 對應功能或變更的 `tasks.md`，Backlog 僅連結與摘要 |
| 已完成的正式 Playbook 變更 | [CHANGELOG.md](../CHANGELOG.md) 與 Git commit |

沿用 [Spec Engine Strategy](Spec_Strategy.md) 的文件責任，不複製另一套 spec / plan / tasks。

## 維護與續作規則

1. 已決定追蹤的待辦加入總表；尚未確認的提議標示「待確認」，不得當成已授權實作。
2. 工作暫停或未完成時，更新狀態與續作紀錄，保存已完成內容、剩餘工作、阻礙、相關文件及下一步。
3. 下次接續時先讀對應紀錄與正式 tasks，確認分支、commit 與相關來源是否有變動，只補查必要內容。
4. 不以對話記憶取代文件，也不因接續任務重新掃描整個 Repository。
5. 完成後更新狀態，保留驗證結果與 commit；未驗證或驗證失敗不得標記完成。
6. 待辦記錄不代表修改授權；正式更新沿用 [README 控版規則](../README.md#控版規則)。

狀態：待確認、待處理、進行中、受阻、已完成、取消。

## 待辦總表

| ID | 事項 | 狀態 | 更新日期 | 下一步 | 相關文件／續作紀錄 |
| --- | --- | --- | --- | --- | --- |
| PB-001 | AI-Developer-Playbook 第二階段 Gap Analysis | 待處理 | 2026-10-01 | 逐項檢查現有 Agent / Preset，記錄 Gap 與 Adopt / Extend / Keep / Remove 分類 | [續作紀錄](#pb-001ai-developer-playbook-第二階段-gap-analysis)、[Spec Engine Strategy](Spec_Strategy.md) |

## PB-001：AI-Developer-Playbook 第二階段 Gap Analysis

- 目標與已確認範圍：依既定 Spec Engine Strategy，逐項檢查現有 Agent / Preset 的能力與責任邊界，完成 Gap 分類並依結果調整 Repository。
- 目前 Stage、分支與基準 commit：第二階段 Gap Analysis 待處理；尚未建立第二階段工作分支，基準 commit 尚未記錄，續作時先確認。
- 已完成內容與已確認決策：
  - 已定義 Spec Kit / OpenSpec / Lightweight 分流方向。
  - 已定義 Requirement Workspace 的定位與文件責任。
  - 已定義 Gap 標準 Adopt / Extend / Keep / Remove。
- 剩餘工作：
  - 逐項檢查 `new-feature`、`propose`、`explore`、`system-design`、`diagram`、`sql`、`bug-fix`、`review` 等現有 Agent / Preset。
  - 完成各項 Gap 與 Adopt / Extend / Keep / Remove 分類，記錄理由、相依及調整範圍。
  - 依分類結果實際調整 Repository，沿用成熟能力並保留最小必要補強。
  - 同步 README、Usage、Architecture、CHANGELOG。
  - 檢查規則、流程、文件責任、產物與引用的一致性。
- 卡住原因／待確認事項：目前無已知阻礙；本次已明確授權新增 Backlog 紀錄，後續實際調整仍依 README 控版規則確認。
- 相關檔案、Findings、Spec／Tasks 或 Diff：以 [Spec Engine Strategy](Spec_Strategy.md) 為已確認方向；檢查 `agents/`、`presets/`，並同步 [README](../README.md)、[Usage](Usage.md)、[Architecture](Architecture_Definitions.md)、[CHANGELOG](../CHANGELOG.md)。尚未建立第二階段逐項 Findings 或正式 Tasks。
- 已執行驗證、結果及尚未執行的檢查：已確認 Spec Engine Strategy 記載上述分流、Requirement Workspace 與 Gap 標準；尚未完成現有 Agent / Preset 逐項分類、實際調整及整體一致性檢查，不標記完成。
- 下一個可執行步驟與完成條件：續作先讀本紀錄與 Spec Engine Strategy，確認分支、基準 commit 及相關來源變動，再從 `new-feature` 開始逐項記錄 Gap 與分類；全部項目完成分類、依確認結果調整 Repository、同步相關文件且一致性檢查通過後，才能標記已完成。
- 最後更新日期：2026-10-01。

## 續作紀錄格式

每項已開始但未完成的工作，以相同 ID 建立小節並填寫：

- 目標與已確認範圍。
- 目前 Stage、分支與基準 commit（尚未建立時明記）。
- 已完成內容與已確認決策。
- 剩餘工作。
- 卡住原因／待確認事項（無則明記）。
- 相關檔案、Findings、Spec／Tasks 或 Diff 連結。
- 已執行驗證、結果及尚未執行的檢查。
- 下一個可執行步驟與完成條件。
- 最後更新日期。
