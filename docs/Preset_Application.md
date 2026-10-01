# Preset 套用方式

本文件定義 Preset 在新的 Stage / Skill Runtime 模型中的角色。

## 核心模型

```text
Playbook = 規則母庫
Preset = 主任務與預設 Workflow
Stage / Skill = 可直接呼叫的執行階段
Rule Module = Stage 使用的規則
AGENTS.md = Project 固定規則
PowerShell = 安裝 / 同步 / 相容性工具
```

日常任務不要求每次切換 Preset 都重新執行 PowerShell。

## 一次性設定

### 步驟 1：準備 Playbook

安裝到目標 Project 的 `.agents/AI-Developer-Playbook/`。PowerShell 與 CMD 的安裝、更新指令統一見 [Installation 第 2 節](Installation.md#2-安裝-playbook)。

### 步驟 2：建立 Project AGENTS.md

只在 Project 尚未存在 `AGENTS.md` 時建立。

`AGENTS.md` 保存：

- Tech Stack。
- Build / Test。
- Folder / Architecture Notes。
- Database Rules。
- Business Constraints。
- Project-specific Rules。

## 日常 Runtime

### 使用 Preset 啟動主任務

例如：

```text
Preset: bug-fix
問題：訂單狀態更新錯誤
```

或：

```text
Preset: system-design
範圍：Dispatch 模組
```

Preset 只定義主任務與預設流程，不需要重新 materialize `.ai-rules/`。

### 直接呼叫 Stage / Skill

同一任務內可以直接：

```text
Stage: explore
```

接著：

```text
Stage: propose
```

再接著：

```text
Stage: apply
```

最後：

```text
Stage: verify
Stage: review
```

切換 Stage 時保留前一階段 Findings、Spec、Diff 與 Test Result。

## System Design 範例

```text
Preset: system-design
```

預設可走：

```text
explore
→ analyze
→ diagram
→ document
→ review
```

若只需要圖：

```text
Stage: diagram
Profile: module-map
```

若要再補資料流：

```text
Stage: diagram
Profile: data-flow
```

不需要退出 System Design，也不需要執行 `apply-preset.ps1`。

## 多 Stage 串接

```text
本次任務：新增客戶篩選條件

Stage: explore
→ 確認現有實作與共用元件

Stage: propose
→ 決定最小修改方案

Stage: apply
→ 修改程式

Stage: verify
→ Build / Test / Diff

Stage: review
→ 檢查回歸風險
```

每個 Stage 只補讀必要資訊，不重新掃描完整 Repository。

## Stage 與 Rule Module 對應

| Stage / Skill | 主要規則 |
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

Stage 可搭配 `agents/core.md`、`agents/token-saving.md` 等共用規則。

## Profile / Modifier

Profile 與 Modifier 不建立新 Preset。

例如：

```text
Stage: diagram
Profile: call-chain
選項: compact
```

或：

```text
Preset: system-design
表: database
選項: risk
```

## `apply-preset.ps1` 的新定位

`tools/apply-preset.ps1` 保留作為 Snapshot 相容工具。

它仍會：

1. 讀取 `presets/<preset>.md`。
2. 解析 `agents/*.md`。
3. 重建目標 Project 的 `.ai-rules/`。
4. 複製 Preset 所需規則。

適合：

- 舊 Project 已採 `.ai-rules/` Snapshot。
- 測試某 Preset 包含哪些 Rule Module。
- 特殊離線 / 固定規則快照需求。

不適合：

- Explore → Apply 的日常 Stage 切換。
- System Design → Diagram → Review。
- 同一任務中串接多個 Skill。

因為它會重建 `.ai-rules/`，不應被當成 Runtime Orchestrator。

## Rule Precedence

```text
1. 使用者本次明確指示
2. Project AGENTS.md
3. 本次 Stage / Skill 規則
4. Playbook 通用規則
```

## Token 原則

```text
Load only required rules.
Reuse current task context.
Do not reinstall rules just to change stages.
```

避免：

- Stage 切換時重新掃描 Repository。
- 每次換工作階段都清空 `.ai-rules/`。
- 重複分析已確認的 Findings。
- 為單一 Stage 載入完整 Playbook。

詳細執行方式：`docs/Stage_Execution.md`。