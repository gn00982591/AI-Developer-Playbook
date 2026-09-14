# Preset 套用方式

本文件定義如何把 `AI-Developer-Playbook` 的 Preset 實際套用到某個 Project。

## 核心模型

```text
Playbook = 規則母庫
Preset = 本次任務的規則選單
.ai-rules/ = 本次實際載入的規則
AGENTS.md = Project 固定規則
```

實際執行時：

```text
Project AGENTS.md
+
Project .ai-rules/
=
本次有效規則
```

## 為什麼不直接把 Preset 內容寫進 AGENTS.md

`AGENTS.md` 應保存長期固定的 Project-specific 規則，例如：

- Tech Stack
- Build / Test 指令
- Folder / Architecture Notes
- Database Rules
- Business Constraints
- Project-specific Rules

Bug Fix、New Feature、SQL Change、System Design 等屬於任務型規則，應由 Preset 決定，不應反覆改寫 `AGENTS.md`。

## Project 建議結構

```text
Project/
├─ AGENTS.md
├─ .ai-rules/
│  ├─ core.md
│  ├─ token-saving.md
│  └─ ...本次任務需要的規則
├─ src/
└─ ...
```

`.ai-rules/` 是執行層，只放本次任務需要的規則。

## 套用 Bug Fix Preset

來源：`presets/bug-fix.md`

需要：

```text
agents/core.md
agents/explore.md
agents/apply.md
agents/testing.md
agents/token-saving.md
```

Project 中 materialize 成：

```text
.ai-rules/
├─ core.md
├─ explore.md
├─ apply.md
├─ testing.md
└─ token-saving.md
```

本次任務有效規則：

```text
AGENTS.md
+
.ai-rules/core.md
+
.ai-rules/explore.md
+
.ai-rules/apply.md
+
.ai-rules/testing.md
+
.ai-rules/token-saving.md
```

## 套用 New Feature Preset

```text
.ai-rules/
├─ core.md
├─ explore.md
├─ propose.md
├─ apply.md
├─ testing.md
├─ archive.md
└─ token-saving.md
```

## 套用 SQL Change Preset

```text
.ai-rules/
├─ core.md
├─ sql.md
├─ apply.md
├─ testing.md
└─ token-saving.md
```

若影響範圍不清楚，再加入 `explore.md`；若屬大型變更，再加入 `propose.md`。

## 套用 System Design Preset

```text
.ai-rules/
├─ core.md
├─ explore.md
├─ system-design.md
└─ token-saving.md
```

純分析任務不載入 `apply.md` 與 `testing.md`。

## 切換 Preset

切換任務時，不修改 `AGENTS.md`。

例如：

```text
Bug Fix
↓
清除/替換 .ai-rules/
↓
System Design
```

切換後 `.ai-rules/` 只保留新 Preset 需要的規則，避免舊任務規則殘留。

## Rule Precedence

若規則衝突，建議優先順序：

```text
1. 使用者本次明確指示
2. Project AGENTS.md
3. 本次 .ai-rules/ 任務規則
4. Playbook 通用預設
```

Project 的實際限制應優先於通用 Playbook，但不得覆蓋使用者本次明確要求。

## Token 原則

- 不把整個 Playbook 複製到 Project。
- 不把所有 `agents/` 都載入 `.ai-rules/`。
- 只 materialize 本次 Preset 所列模組。
- 若需求已清楚，可刪除不必要的 `explore.md`。
- 任務完成後可清除 `.ai-rules/` 或切換成下一個 Preset。

核心原則：

```text
Load only required rules.
```

## 未來自動化

可再增加安裝/同步機制：

```text
選擇 Preset
↓
讀取 preset 所列 agents
↓
同步到 Project/.ai-rules/
↓
保留 Project/AGENTS.md 不變
```

未自動化前，也可手動複製所需規則檔案。
