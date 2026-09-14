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
需求尚不清楚
→ explore → propose → apply → verify

需求已確認
→ propose → apply → verify

規格與位置都明確
→ apply → verify
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

例如：

```powershell
# Snapshot 相容模式：將 system-design Preset 同步到指定 Project。
.\tools\apply-preset.ps1 -Preset "system-design" -ProjectPath "D:\Projects\OrderSystem"
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

## 13. 延伸文件

需要更深入規則時再查：

- `docs/Stage_Execution.md`：Stage / Skill Runtime 詳細規則。
- `docs/Preset_Application.md`：Preset 與 Runtime / Snapshot 邊界。
- `docs/Architecture_Definitions.md`：Preset、Stage、Rule Module、Profile 等正式定義。
- `docs/Preset_Sync.md`：Snapshot 同步機制。
- `agents/diagramming.md`：Mermaid 與 Diagram Profile 規則。
