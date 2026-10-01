# Repository 結構關係圖

依「Repository → 資料夾 → 檔案」呈現實際目錄層級。點選檔名可直接開啟對應內容。

- **AI-Developer-Playbook/**

    - **agents/** — 共用規則

        - [core.md](../agents/core.md)
        - [data-access.md](../agents/data-access.md)
        - [explore.md](../agents/explore.md)
        - [propose.md](../agents/propose.md)
        - [apply.md](../agents/apply.md)
        - [archive.md](../agents/archive.md)
        - [sql.md](../agents/sql.md)
        - [git.md](../agents/git.md)
        - [testing.md](../agents/testing.md)
        - [system-design.md](../agents/system-design.md)
        - [diagramming.md](../agents/diagramming.md)
        - [code-review.md](../agents/code-review.md)
        - [token-saving.md](../agents/token-saving.md)

    - **presets/** — 主任務與建議流程

        - [requirement-intake.md](../presets/requirement-intake.md)
        - [bug-fix.md](../presets/bug-fix.md)
        - [new-feature.md](../presets/new-feature.md)
        - [sql-change.md](../presets/sql-change.md)
        - [system-design.md](../presets/system-design.md)
        - [review-lite.md](../presets/review-lite.md)

    - **docs/** — 安裝、使用與架構文件

        - [Backlog.md](../docs/Backlog.md)
        - `backlog/active/<ID>-<slug>/` — 有未完成待辦時建立；目前無待辦處理資料夾

        - [Installation.md](../docs/Installation.md)
        - [Usage.md](../docs/Usage.md)
        - [Workflow.md](../docs/Workflow.md)
        - [Repository_Structure.md](../docs/Repository_Structure.md)
        - [Data_Access.md](../docs/Data_Access.md)
        - [Architecture_Definitions.md](../docs/Architecture_Definitions.md)
        - [Stage_Execution.md](../docs/Stage_Execution.md)
        - [Spec_Strategy.md](../docs/Spec_Strategy.md)
        - [OPSX_Workflow.md](../docs/OPSX_Workflow.md)
        - [Token_Saving.md](../docs/Token_Saving.md)
        - [Preset_Application.md](../docs/Preset_Application.md)
        - [Preset_Sync.md](../docs/Preset_Sync.md)

    - **templates/** — 專案規則模板

        - [AGENTS.md](../templates/AGENTS.md)

    - **tools/** — 安裝、同步與相容工具

        - [apply-preset.ps1](../tools/apply-preset.ps1)
        - [README.md](../tools/README.md)

    - [README.md](../README.md)
    - [CHANGELOG.md](../CHANGELOG.md)

工作執行順序請見 [Playbook 工作流程](Workflow.md)。實際 Project 的資料夾責任請見 [Architecture Definitions](Architecture_Definitions.md) 與 [Spec Strategy](Spec_Strategy.md)。
