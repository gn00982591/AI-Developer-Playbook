# AGENTS.md Template

本模板用於每個實際專案的專屬規則。中央通用規則由 `AI-Developer-Playbook` 管理；此檔只保存該 Project 的差異。

## Runtime Rule Loading

開始任何任務前：

1. 先讀取本 Project 根目錄的 `AGENTS.md`。
2. 若存在 `.ai-rules/`，再讀取其中所有本次任務需要的 Markdown 規則檔。
3. 將 `AGENTS.md + .ai-rules/` 視為本次有效規則。
4. 不要因為引用 Playbook，就重新讀取整個 `AI-Developer-Playbook` Repository。
5. 只有 `.ai-rules/` 缺少必要規則時，才回到 Playbook 補充對應模組。

規則優先順序：

```text
1. 使用者本次明確指示
2. Project AGENTS.md
3. Project .ai-rules/
4. Playbook 通用預設
```

建議啟動指令：

```text
請先讀取專案根目錄 AGENTS.md，再讀取 .ai-rules/ 內的規則檔。
本次只使用這些規則處理任務，不要重新掃描中央 Playbook。
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

## Preset Materialization

Preset 不直接遠端引用。請將 Preset 所列的 `agents/*.md` 同步或複製到本 Project 的 `.ai-rules/`。

例如 Bug Fix：

```text
.ai-rules/
├─ core.md
├─ explore.md
├─ apply.md
├─ testing.md
└─ token-saving.md
```

切換任務時，替換 `.ai-rules/` 內容；`AGENTS.md` 保持不變。
