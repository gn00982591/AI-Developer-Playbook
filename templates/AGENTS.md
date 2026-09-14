# AGENTS.md Template

本模板用於每個實際專案的專屬規則。中央通用規則由 `AI-Developer-Playbook` 管理；此檔只保存該 Project 的差異。

## Rule Loading Model

本 Project 使用以下規則模型：

```text
AGENTS.md
+
.ai-rules/
=
本次有效規則
```

- `AGENTS.md`：Project 固定規則。
- `.ai-rules/`：依本次 Preset 載入的任務規則。
- 切換任務時只替換 `.ai-rules/`，不需要改寫 `AGENTS.md`。

若規則衝突，建議優先順序：

```text
1. 使用者本次明確指示
2. Project AGENTS.md
3. Project .ai-rules/
4. Playbook 通用預設
```

## Project Overview

- Project Name:
- Purpose:
- Main Modules:

## Tech Stack

- Backend:
- Frontend:
- Database:
- Other:

## Build / Test

```text
# 填入本專案實際可執行的 Build / Test 指令
```

## Folder / Architecture Notes

- 主要入口：
- Service / Domain：
- Data Access：
- Database / SP：
- External Integrations：

## Project-specific Rules

- 僅填本專案特有規則。
- 不重複中央 Playbook 的通用規則。
- 不保存帳號、密碼、Token、Connection String 或機密資料。

## Business Constraints

- 待填。

## Database Rules

- 待填。

## Validation Notes

- 待填。

## Recommended Playbook Preset

依任務選擇，例如：

- Bug Fix：`presets/bug-fix.md`
- New Feature：`presets/new-feature.md`
- SQL Change：`presets/sql-change.md`
- System Design：`presets/system-design.md`

Preset 實際套用方式請見 `docs/Preset_Application.md`。
