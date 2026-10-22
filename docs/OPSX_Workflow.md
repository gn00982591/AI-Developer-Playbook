# OpenSpec 整合流程

## 定位

本文件說明 Playbook 與 OpenSpec 的配合方式，通用 Stage 仍由 agents/ 管理。分流沿用 [Spec Engine Strategy](Spec_Strategy.md)；Spec Kit 與 Lightweight 不必執行本流程。

## 前置確認

- 沿用已確認的 OpenSpec 路徑、Findings 與產物。
- 核對專案已安裝版本、設定、Skill / Command 與產物位置；缺少能力時列出缺漏，不把語意 Stage 當成已安裝命令。
- 官方 `/opsx:propose` 等入口可依平台映射不同名稱，以專案實際生成入口為準，不固定要求 `/opsx-propose`。

## 原生能力直接引用（Adopt）與版本相容

- **Adopt：** OpenSpec 已提供的 proposal / specs / design / tasks、狀態與進度查詢、差異檢視、規格檢查、驗證及歸檔，優先使用專案已安裝版本的原生能力。Playbook 只引用操作入口和產物，不複製規格或再做另一套流程。
- **Extend：** 原生能力未涵蓋的企業需求，才補 UI、Business Rule、Data / Table Impact、System Design、SQL、Build / Test 與 Review；補強需能說明具體缺口。
- **Keep：** 保留 Playbook 的需求來源分析、規則載入、資料存取與 Token 節省原則。
- **Remove：** 重疊的同義產物與流程要求，先確認相依及使用情境，再作最小移除，不因改用 OpenSpec 而刪除通用 Stage。

### 執行前與升級時

1. 確認專案是否實際安裝 OpenSpec，核對版本、schema、平台所產生的 Skill / Command、設定及產物位置；未安裝時不假設可執行原生命令。
2. 優先使用該版本**實際支援**的 Status / Diff / Validate / Verify / Archive 等能力；若功能名稱、參數或入口有差異，以安裝版本的說明及可用命令為準，不硬編固定指令。
3. OpenSpec 發布新版本不代表 Playbook 或專案會自動更新。升級前比對官方 Release Notes 與現行整合規則，記錄新增功能、破壞性變更及必要的相容調整；未受影響者維持不變。
4. 沿用原有 Findings 和正式 OpenSpec 產物。OpenSpec 的規格／文件檢查不能替代實際 Build、Test、Diff 及必要的企業驗收。
5. 任何 Playbook Repository 修改仍需使用者明確確認，且保留 Git commit 與 CHANGELOG；不得以相容性檢查為由自動改寫其他 Project。

## 階段與責任

| 階段 | OpenSpec 責任 | Playbook 最小補強 |
| --- | --- | --- |
| Explore（需要時） | 探索方向 | 沿用 Findings，補 UI、業務、資料、狀態影響與來源 |
| Propose | 依所選 schema 管理 proposal / specs / design / tasks | 核對範圍、驗收及企業分析缺口，不另建正式 Spec |
| Apply | 實作與更新正式 Tasks | 最小修改、資料存取與 SQL 規則，不重做已完成 Tasks |
| Verify / Review | 該版本可用的檢查能力 | 核對需求、Diff、驗收與實測，分開回報文件及執行驗證 |
| Archive | 歸檔與 Current Truth / Delta 同步 | 核對完成條件及結果，不另建歸檔機制 |

## 執行條件

1. 位置或原因不清楚才 Explore；已有 Findings 只補缺漏。
2. 正式變更產物由 OpenSpec 管理，企業來源與分析按需引用 requirements/。
3. 實作前確認規格、Tasks 與驗收；Engine 原生 Apply 與 Playbook Stage 共用同一份 Tasks。
4. 按風險完成必要驗證；文件檢查不替代 Build / Test，失敗、未執行與限制如實列出。
5. 完成且必要驗證通過後，依專案版本的原生機制歸檔。

同一任務保留 Context，不重掃 Repository，不因切換 Stage 執行 PowerShell。

## 來源

- [OpenSpec 官方文件](https://github.com/Fission-AI/OpenSpec)：產物、流程與平台命令差異。
- [Stage Execution](Stage_Execution.md)：Context 延續與規則對應。
- [Archive Rules](../agents/archive.md)：完成及歸檔責任。
