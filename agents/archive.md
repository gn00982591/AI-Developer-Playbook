# Archive Rules

適用於變更已完成，需要整理與歸檔的任務。

## 規則

## 生命週期

- 正式變更沿用所選 Engine 的歸檔或完成機制，不另建正式產物目錄，也不虛構原生命令。
- OpenSpec 的 Current Truth / Delta 同步依專案版本核對，不重寫 Engine 歸檔邏輯。
- Lightweight 按需整理方案、Diff 與驗證，不強制建立 Spec / Tasks 或歸檔目錄。
- Playbook 自身待辦依 [Backlog](../docs/Backlog.md) 處理，CHANGELOG 與 Git commit 保存完成紀錄。
- 未完成、驗證失敗或未執行必要驗證時保留續作資訊，不宣告完成。

## 輸入

按所選路徑只沿用必要輸入：

- Engine Spec / Tasks，或 Lightweight 已確認方案
- Git Diff
- Build / Test Result

不要：

- 重新掃描 Repository。
- 重新做需求分析。
- 重新解釋已確認需求。
- 為了歸檔而重新讀取大量 Source Code。
