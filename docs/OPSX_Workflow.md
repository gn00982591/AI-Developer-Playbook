# OpenSpec 整合流程

## 定位

本文件說明 Playbook 與 OpenSpec 的配合方式，通用 Stage 仍由 agents/ 管理。分流沿用 [Spec Engine Strategy](Spec_Strategy.md)；Spec Kit 與 Lightweight 不必執行本流程。

## 前置確認

- 沿用已確認的 OpenSpec 路徑、Findings 與產物。
- 核對專案已安裝版本、設定、Skill / Command 與產物位置；缺少能力時列出缺漏，不把語意 Stage 當成已安裝命令。
- 官方 `/opsx:propose` 等入口可依平台映射不同名稱，以專案實際生成入口為準，不固定要求 `/opsx-propose`。

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
