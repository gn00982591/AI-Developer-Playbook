# Usage

本文件只負責 **AI Developer Playbook 的日常使用方式**。

若尚未完成第一次導入，請先閱讀：[`docs/Installation.md`](./Installation.md)。

> 建議閱讀順序：**Installation → Usage**。

## 1. 使用模型

```text
Preset
「我要完成什麼主任務」
        │
        └─ Workflow
           「預設怎麼走」
                │
                ├─ Stage / Skill
                ├─ Stage / Skill
                └─ Stage / Skill
                     │
                     ├─ Rule Module
                     ├─ Profile
                     └─ Modifier
```

核心原則：

```text
Preset = 主任務 / 流程編排
Stage / Skill = 日常 Runtime 執行能力
Rule Module = 執行規則
Profile / Modifier = 本次輸出調整
PowerShell = 安裝 / 同步 / Snapshot 相容工具
```

日常任務中，不要因為切換 Stage 就重新執行 `apply-preset.ps1`。

## 2. 啟動主任務：Preset

目前主要 Preset：

```text
requirement-intake
bug-fix
new-feature
sql-change
system-design
review-lite
```

標準語意：

```text
Preset: bug-fix
問題：訂單狀態更新錯誤
```

或：

```text
Preset: system-design
範圍：Dispatch 模組
```

Preset 是主任務入口與建議 Workflow，不是把所有能力綁死在單一流程裡。

## 3. 直接執行 Stage / Skill

可以在同一任務 Context 直接呼叫：

```text
Stage: explore
```

```text
Stage: propose
```

```text
Stage: apply
```

```text
Stage: verify
```

```text
Stage: review
```

```text
Stage: diagram
Profile: call-chain
```

切換 Stage 時應沿用目前已有的：

- User Request。
- Findings。
- Decisions。
- Spec / Tasks。
- Relevant Files。
- Diff。
- Test Result。
- Output Requirements。

只有缺少該 Stage 必要資訊時才補讀，不重新掃描整個 Repository。

## 4. 多個 Stage 串接

### Bug Fix

```text
Preset: bug-fix
問題：訂單狀態更新錯誤

Stage: explore
→ 找根因與影響範圍

Stage: propose
→ 整理最小修改方案

Stage: apply
→ 修改程式

Stage: verify
→ Build / Test / Diff

Stage: review
→ 複查回歸風險
```

### 已知道修改位置

不需要硬走完整流程：

```text
Stage: propose
Stage: apply
Stage: verify
```

### 規格非常清楚

```text
Stage: apply
Stage: verify
```

### 只想複查

```text
Preset: review-lite
```

或直接：

```text
Stage: review
```

## 5. System Design

啟動：

```text
Preset: system-design
範圍：Dispatch 模組
```

可依需求直接呼叫不同階段，不需要重新切換 Preset：

```text
Stage: explore
Stage: diagram
Profile: module-map
Stage: review
```

如果後續想再補資料流：

```text
Stage: diagram
Profile: data-flow
```

如果要查看呼叫鏈：

```text
Stage: diagram
Profile: call-chain
```

## 6. Diagram Profile

Diagram Profile 是「圖的種類」，不是頂層 Preset。

| Profile | 用途 |
| --- | --- |
| `module-map` | 模組、責任、系統邊界與高階相依 |
| `business-flow` | 業務步驟、判斷與結果 |
| `call-chain` | 入口到各層或外部服務的呼叫順序 |
| `state-transition` | 狀態、事件、條件與轉移 |
| `data-flow` | 資料來源、轉換、儲存與消費端 |

例如：

```text
Stage: diagram
Profile: state-transition
```

可以再加入 Modifier：

```text
Stage: diagram
Profile: call-chain
選項: compact
```

詳細 Mermaid 規則由 `agents/diagramming.md` 管理。

## 7. SQL 任務

可從 Preset 啟動：

```text
Preset: sql-change
需求：調整訂單查詢條件
```

也可以在目前任務中直接使用 SQL Stage / Skill：

```text
Stage: sql
```

若 SQL 變更同時需要程式修改，可接續：

```text
Stage: sql
Stage: apply
Stage: verify
Stage: review
```

## 8. New Feature

```text
Preset: new-feature
需求：新增客戶篩選條件
```

建議依需求清楚程度選擇：

```text
尚未分流
→ requirement-intake（需要時）→ Route

大型、新系統或不確定需求
→ Spec Kit 規格／規劃／Tasks → 實作 → Verify / Review

既有系統正式變更
→ OpenSpec 變更產物 → 實作 → Verify / Review → 原生歸檔

小型明確功能
→ Lightweight：按需 explore / propose → apply → verify → review（依風險）
```

不要為了符合形式而強制執行不必要的 Stage。

## 9. Review Lite

適合：

- 已修改完成，只想再看一次。
- 只檢查 Diff。
- 只檢查指定 Commit。
- 只檢查指定檔案。
- 希望降低 Token 消耗。

例如：

```text
Preset: review-lite
範圍：目前 Git Diff
```

或：

```text
Stage: review
範圍：目前 Git Diff
```

原則：

```text
Diff → Findings
```

不要因為複查又重新掃描整個 Repository。

## 10. Stage / Skill 與 Rule Module 對應

| Stage / Skill | 主要 Rule Module |
| --- | --- |
| `explore` | `agents/explore.md` |
| `propose` | `agents/propose.md` |
| `apply` | `agents/apply.md` |
| `verify` | `agents/testing.md` |
| `review` | `agents/code-review.md` |
| `diagram` | `agents/diagramming.md` |
| `archive` | `agents/archive.md` |
| `sql` | `agents/sql.md` |
| `system-design` | `agents/system-design.md` |

共用規則可再搭配：

```text
agents/core.md
agents/token-saving.md
```

## 11. PowerShell 什麼時候才用

`tools/apply-preset.ps1` 只建議用於：

- 第一次導入或特殊同步。
- 舊 `.ai-rules/` Snapshot 專案。
- 固定一組規則快照。
- 測試某個 Preset 實際會載入哪些 Rule Module。

PowerShell 範例請先進入 `D:\WorkGit\YFYTMSWeb\.agents\AI-Developer-Playbook`。從 CMD 呼叫的完整指令見 [Installation Snapshot 說明](Installation.md#snapshot-相容模式)；腳本仍需要 PowerShell。

例如：

```powershell
# Snapshot 相容模式：將 system-design Preset 同步到指定 Project。
.\tools\apply-preset.ps1 -Preset "system-design" -ProjectPath "D:\WorkGit\YFYTMSWeb"
```

以下情況不要重新跑 PowerShell：

```text
Explore → Apply
System Design → Diagram
Diagram module-map → data-flow
Apply → Verify → Review
```

這些全部屬於同一任務 Context 內的 Runtime Flow。

## 12. 建議日常操作方式

最常用的操作可以簡化成：

```text
1. 告訴 AI 主任務或直接指定 Stage
2. AI 先讀 Project AGENTS.md
3. 只搜尋與目前任務有關的程式碼
4. 沿用已確認 Findings
5. 需要時直接切換下一個 Stage
6. 不重裝規則、不重掃 Repository
7. 最後 Verify / Review
```

例如完整一句：

```text
Preset: bug-fix
問題：儲存後產生重複資料。
先 Stage: explore 找根因，確認後 Stage: propose，採最小修改，再 Stage: apply、verify、review。
```

或 System Design：

```text
Preset: system-design
範圍：Dispatch。
先分析現有結構，再用 Stage: diagram / Profile: module-map；需要時補 call-chain 與 data-flow，不要重掃已確認內容。
```

## 13. 資料存取與多資料庫

涉及資料庫時，無論使用哪個 Preset 或直接 Stage，都先套用 [Data Access Rules](../agents/data-access.md)。

1. 從 Project AGENTS.md 找到資料庫總索引；預設為 docs/data-access/README.md。
2. 確認相關資料庫與 Context，再查各資料庫索引。
3. 讀 ContextProcedures、Result 定義與 SP／Function 本體，核對既有能力後決定實作方式。
4. 檢查逐筆補查、取完整候選後篩選及可合併查詢的 C# 拼接。
5. 產生或修改程式時，同步所屬資料庫 MD；涉及跨資料庫時同步流程文件。
6. 驗證結果與查詢成本，記錄無法執行的項目。

既有索引沿用，不建立重複文件。完整欄位、生成步驟與驗收案例見 [Data Access](Data_Access.md)。此版本定義同步規範，未提供自動生成器。

## 14. 延伸文件

需要更深入規則時再查：

- `docs/Stage_Execution.md`：Stage / Skill Runtime 詳細規則。
- `docs/Preset_Application.md`：Preset 與 Runtime / Snapshot 邊界。
- `docs/Architecture_Definitions.md`：Preset、Stage、Rule Module、Profile 等正式定義。
- `docs/Preset_Sync.md`：Snapshot 同步機制。
- `agents/diagramming.md`：Mermaid 與 Diagram Profile 規則。

## Spec Engine 接續

分流沿用 [Spec Engine Strategy](Spec_Strategy.md)。正式產物由所選 Engine 管理，Engine 原生實作與 Playbook Stage 共用同一份 Tasks，不重複實作；Lightweight 不強制建立正式 Spec。命令與產物位置依專案已安裝版本及設定確認。

## 會議紀錄

直接以自然語言提出需求，無須新增 Preset 或安裝平台專用範本：

```text
請將以下逐字稿整理為會議紀錄，依六大分類產生 PDF。
會議內容：……
```

按需載入 [Meeting Minutes Rules](../agents/meeting-minutes.md)，整理會議基本資訊、議題、討論、決議、待辦與待確認事項。若已安裝個人「會議紀錄 Meeting Minutes」範本，可沿用其版面；沒有個人範本仍依共用規則完成 PDF。流程入口見 [Workflow](Workflow.md)。

## 週報

產出、整理或更新週報時，依 [Weekly Report Rules](../agents/weekly-report.md) 確認期間與專案指定範本，再核對本期內容及交付格式。

## 程式註解與技術說明

新增、修改或審查程式時，依專案 `AGENTS.md` 的入口查閱註解規範。未指定時使用 [程式註解與技術說明](../agents/code-comments.md)，涵蓋日常開發、集中補寫及完成檢查。

## 驗收與交接

依 [驗證紀錄與接續](../agents/testing.md#驗證紀錄與接續) 填寫既有驗收產物。專案文件記錄工具版本、實際指令、用途與更新界線。日常按階段選讀規則並沿用上下文。使用 Snapshot 時依 [Preset 同步](Preset_Sync.md) 核對來源與引用。

| 虛構情境 | 從 Preset 到驗收 | 預期證據 |
| --- | --- | --- |
| 來源條件有差異的新功能 | [Requirement Intake](../presets/requirement-intake.md) → [來源核實](../agents/core.md#現行規格來源與決策核實) → 若採 OpenSpec，依 [前置確認](OPSX_Workflow.md#前置確認) 核對有效規格與 Delta。 | 範例業務手冊 v3 與有效規格 v2 的條件不同。追到原決策、確認日期、程式入口及驗收情境。記錄已裁決要同步的條件及仍待決策的例外。 |
| 受保護的據點 CRUD | [New Feature](../presets/new-feature.md) → [資安索引](security/README.md) → [工作階段驗收](security/身分授權與資料存取.md#工作階段與受保護回應) 及 [保存結果驗收](security/敏感資料與稽核復原.md#錯誤回應與保存結果)。 | 逐端點核對合法、越權、表單開啟後撤權、非法輸入、過期版本與回滾。A 的成功和 401 在 B 登入後送達，B 的登入、畫面及草稿維持正確。 |
| 含既有資料的據點 SQL 升級 | [SQL Change](../presets/sql-change.md) → [階層、有限值域與欄位契約](../agents/data-access.md#階層有限值域與欄位契約) 及 [遷移與退役](security/套件建置與部署.md#遷移與退役)。 | 兩個舊來源各有編號 42，確認映射可區分來源且主從關聯正確。驗空庫、含資料升級、重跑、受控失敗及新舊入口。 |
| 多根據點及附屬列 | [System Design](../presets/system-design.md) 或 [SQL Change](../presets/sql-change.md) → [階層、有限值域與欄位契約](../agents/data-access.md#階層有限值域與欄位契約)。 | 在同一隔離範圍建兩個有效根，再於另一範圍建立有效父項。驗合法附屬列可保存。分別驗證跨根、跨範圍新增與改掛，以及缺必填、填不適用欄位、參照錯誤類型均遭拒。查回原階層確認無異動。 |
| 據點翻譯由 JSON 切換至 SQL | [New Feature](../presets/new-feature.md) 或 [Review Lite](../presets/review-lite.md) → [集中語系現況與資料來源切換](../agents/frontend.md#集中語系現況與資料來源切換)。 | 維護、按需載入與快取已實作，開發 API 仍讀寫 JSON，本機 SQL 表與種子已部署，SQL 接線與目標環境端到端驗收待完成。切換後以實際 API 保存並在重啟後查回，核對版本與快取，再驗部分失敗保留舊內容、重試及身分隔離。 |

交接紀錄範例（虛構，待執行）：測試負責人在隔離 SQL 環境，以專案指定的遷移身分，用版本庫的升級腳本及含兩筆舊編號 42 的測試資料執行「驗證既有資料升級」。將實際命令、輸出及映射查詢存入原驗收紀錄。兩個來源皆可追到各自的新鍵，關聯一致且重跑無第二份映射時通過。目標庫部署與正式驗收另列。
