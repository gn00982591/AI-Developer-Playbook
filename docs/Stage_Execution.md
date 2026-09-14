# Stage / Skill Direct Execution

本文件定義 Playbook 的 Runtime 執行方式。

## 目的

日常任務中，不應為了從 Explore 切到 Apply、從 System Design 切到 Diagram，反覆執行 PowerShell 重新安裝或替換規則。

主任務開始後，應在同一 Context 中直接呼叫所需 Stage / Skill。

## 基本模型

```text
Preset
→ 決定主任務與預設流程

Stage / Skill
→ 直接執行某個階段

Rule Module
→ 提供該 Stage 的規則

Profile / Modifier
→ 調整本次輸出
```

PowerShell 只保留給第一次導入、同步、測試或舊 Snapshot 模式。

## 直接呼叫方式

以下是 Playbook 的標準語意格式，不依賴特定 AI 平台的 Slash Command 實作。

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

若平台支援 Agent / Skill / Command，可由平台 Adapter 將相同名稱映射成原生呼叫方式；Playbook 本身不綁死特定平台語法。

## 同一任務串接多個 Stage

```text
本次任務：修正訂單狀態錯誤

Stage: explore
→ 找根因與影響範圍

Stage: propose
→ 整理最小修改方案

Stage: apply
→ 依方案修改

Stage: verify
→ Build / Test / Diff

Stage: review
→ 最後複查回歸風險
```

Stage 切換時沿用同一任務 Context，不重新讀取整個 Repository，也不重新 materialize `.ai-rules/`。

## Preset 與 Stage 的關係

Preset 是便利的「主任務入口」，不是唯一入口。

例如：

```text
Preset: system-design
```

可以預設：

```text
explore
→ analyze
→ diagram
→ document
→ review
```

但使用者也可以只做：

```text
Stage: diagram
Profile: module-map
```

或在 System Design 進行中補：

```text
Stage: review
```

不需要重新切換 Preset。

## Flow Continuity

每個 Stage 執行前先沿用目前已存在的任務狀態：

- User Request
- Findings
- Decisions
- Spec / Tasks
- Relevant Files
- Diff
- Test Result
- Modifier
- Output Requirements

只有缺少執行該 Stage 所需資訊時，才補讀必要資料。

禁止因 Stage 切換而：

- 清除前一階段結果。
- 重新掃描整個 Repository。
- 清空 `.ai-rules/`。
- 重新跑 `apply-preset.ps1`。
- 把前一階段已確認事項重新分析一次。

## Rule Module 對應

第一版先沿用現有 `agents/`，不複製另一套 Skill 規則。

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

共用規則可再搭配 `agents/core.md`、`agents/token-saving.md`。

這樣 Stage / Skill 與 Rule Module 分離，避免規則複製。

## Diagram 範例

```text
Stage: diagram
Profile: call-chain
選項: compact
```

AI 應：

1. 沿用目前已確認的分析結果。
2. 只補讀畫圖必要資訊。
3. 套用 `agents/diagramming.md`。
4. 使用 `call-chain` Profile。
5. 不重新執行完整 System Design。

## PowerShell 的新定位

`tools/apply-preset.ps1` 是相容性工具，不是 Runtime Orchestrator。

```text
第一次導入 / 舊 Snapshot 模式
→ 可以使用 PowerShell

同一任務內切 Stage
→ 不使用 PowerShell
```

未來若新增平台 Adapter，可將 `Stage: explore`、`Stage: apply` 等語意直接映射為 ChatGPT / Codex / Cursor / Claude 各自的 Skill 或 Command，而不改變 Playbook 的流程定義。