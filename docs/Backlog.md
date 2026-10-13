# 待辦與續作紀錄

集中保存 Playbook 本身的待處理事項與未完成工作的接續資訊，避免只依賴對話記憶。

實際專案的工作記錄保留在該專案；此 Repository 不保存公司程式碼、連線資訊或機密內容。

## 記錄位置與責任

| 內容 | 保存位置 |
| --- | --- |
| Playbook 待辦索引 | 本文件總表 |
| Playbook 待辦處理內容與續作資訊 | `docs/backlog/active/<ID>-<slug>/`；完成並驗證通過且記入 CHANGELOG 後移除 |
| 實際專案待辦與續作索引 | 該專案的 `docs/Backlog.md`（需要時建立） |
| 未確認需求與待釐清問題 | 該專案的 `requirements/analysis/open-questions.md` |
| 已完成的正式 Playbook 變更 | [CHANGELOG.md](../CHANGELOG.md) 與 Git commit |

Playbook 待辦由本 Repository 的 Backlog 資料夾自行管理，不由 OpenSpec 或 Spec Kit 管理。實際專案的 Spec Engine 文件責任仍依 [Spec Engine Strategy](Spec_Strategy.md)。

## 維護與續作規則

1. 已決定追蹤的待辦加入總表，分配固定 ID 並建立 `docs/backlog/active/<ID>-<slug>/`；尚未確認的提議標示「待確認」，不得當成已授權實作。
2. 工作暫停或未完成時，同步總表與專屬資料夾的紀錄，保存已完成內容、剩餘工作、阻礙、相關文件及下一步。
3. 下次接續時先從總表連結讀取專屬資料夾的 `README.md`，再按需讀取 `findings.md`、`verification.md` 與相關附件，確認分支、commit 與相關來源是否有變動，只補查必要內容。
4. 不以對話記憶取代文件，也不因接續任務重新掃描整個 Repository。
5. 完成並驗證通過後，先將完成內容、修改原因與必要驗證結果記入 `CHANGELOG.md`，再移除總表項目及對應的 `active/` 處理資料夾，同步清理引用；完成紀錄與歷史細節由 CHANGELOG 與 Git commit 保存，不另存 Backlog 歸檔。未驗證、驗證失敗或尚未記入 CHANGELOG 時，仍保留於 Backlog。
6. 待辦記錄不代表修改授權；正式更新沿用 [README 控版規則](../README.md#控版規則)。

追蹤中的狀態：待確認、待處理、進行中、受阻、取消。已完成且驗證通過的項目記入 CHANGELOG 後移出總表，不保留「已完成」列；已移除的 ID 不重複使用。

## 待辦總表

| ID | 事項 | 狀態 | 更新日期 | 下一步 | 相關文件／續作紀錄 |
| --- | --- | --- | --- | --- | --- |

目前無追蹤中的待辦。

## 處理資料夾與紀錄格式

每筆 Playbook 待辦使用固定 ID 與簡短名稱建立專屬資料夾：

```text
docs/
├─ Backlog.md
└─ backlog/
   └─ active/
      └─ <ID>-<slug>/
         ├─ README.md
         ├─ findings.md
         └─ verification.md
```

| 文件 | 保存內容 |
| --- | --- |
| `README.md` | 目標、已確認範圍、狀態、Stage、分支與基準 commit、已完成進度、剩餘工作、阻礙、相關文件、下一步、完成條件與最後更新日期 |
| `findings.md` | 分析依據、逐項 Findings、分類、決策理由、相依與預計修改範圍；未分析或未確認內容明確標記 |
| `verification.md` | 已執行檢查、結果、尚未執行項目及相關 commit / diff；未驗證不得標記完成 |

其他附件按需存入同一資料夾，從上述文件連結。Backlog 總表只保存索引、狀態與下一步，不重複詳細處理內容；完成移除時同步清理受影響的連結。
