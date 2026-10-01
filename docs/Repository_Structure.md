# Repository 結構關係圖

本圖呈現 Playbook 各資料夾的責任，以及規則如何用於實際 Project。方框內標示的 Project 檔案與資料夾屬於目標專案，依使用方式建立，不是本 Repository 內的實體目錄。

```mermaid
flowchart TD
    %% Playbook 保存共用規則、主任務、文件與導入工具。
    subgraph Playbook["AI-Developer-Playbook"]
        R["README.md：導覽"]
        P["presets/：主任務與建議 Workflow"]
        A["agents/：共用 Rule Module"]
        D["docs/：安裝、使用與架構文件"]
        T["templates/AGENTS.md：專案規則模板"]
        U["tools/apply-preset.ps1：Snapshot 同步"]
        C["CHANGELOG.md：正式變更紀錄"]
        R -->|查閱| D
        R -->|選擇任務| P
        P -->|引用規則| A
        D -->|說明導入| T
        D -->|說明同步| U
        U -->|讀取組合| P
        U -->|複製所需規則| A
        C -->|記錄版本與原因| R
    end

    %% Runtime 直接呼叫 Stage；Snapshot 同步只用於導入或相容模式。
    subgraph Project["實際 Project：按需建立"]
        PA["AGENTS.md：固定規則與索引入口"]
        PR[".ai-rules/：可選規則快照"]
        S["Stage / Skill：同一任務執行"]
        PD["docs/：正式文件與資料庫索引"]
        O[".ai-output/：一次性產物"]
        W["requirements/：可選來源與需求分析"]
        SP[".specify/、specs/ 或 openspec/：工具管理"]
        PA -->|提供專案規則| S
        PA -->|定位資料來源| PD
        PR -->|提供所需規則| S
        S -->|查閱與同步| PD
        S -->|產生暫存成果| O
        S -->|按需整理需求| W
        S -->|沿用正式 Spec| SP
        O -->|正式文件確認後移入| PD
    end

    T -->|導入時建立| PA
    U -->|導入或相容同步| PR
    A -->|按需提供執行規則| S
```

## 目錄責任與邊界

| 位置 | 保存內容 | 與其他位置的關係 |
| --- | --- | --- |
| Playbook `README.md` | 整體導覽與核心模型 | 連到詳細文件與圖表 |
| Playbook `presets/` | 主任務與建議流程 | 引用 `agents/`，可直接指定 Stage |
| Playbook `agents/` | 共用規則、Diagram Profile 與資料存取規範 | Stage 按需使用，避免規則複製 |
| Playbook `docs/` | 安裝、使用、架構、流程與規範 | 說明共用方法，不保存公司專有內容 |
| Playbook `templates/` | Project 規則模板 | 導入時建立 Project AGENTS.md；既有規則沿用 |
| Playbook `tools/` | 安裝、同步與 Snapshot 相容工具 | 不主導同一任務內的 Stage 切換 |
| Playbook `CHANGELOG.md` | 正式變更、目的與原因 | 與 Git commit 一起保存版本紀錄 |
| Project `AGENTS.md` | 專案固定規則與資料庫索引入口 | 定位 Project 文件；Stage 先讀 |
| Project `.ai-rules/` | 可選共用規則快照 | 可重建，不保存正式資料庫索引 |
| Project `docs/` | 已確認文件與資料存取索引 | 索引分總入口、各資料庫與必要跨資料庫流程 |
| Project `.ai-output/` | 一次性報告、圖、資料與暫存 | 不作為正式 Spec 的唯一依據 |
| Project `requirements/` | 可選原始來源、分析與需求圖 | 補足 Spec 前的需求理解，不重建正式 Spec |
| Project `.specify/`、`specs/`、`openspec/` | 選用 Spec Engine 的設定與正式產物 | 由對應工具依版本與設定管理，不要求全部建立 |

圖中的箭頭標示引用、導入、查閱或產出關係；工作先後順序請見 [Playbook 工作流程](Workflow.md)。Stage / Skill 是執行概念，不代表新增一個 `skills/` 目錄。

## 來源

- [README](../README.md)、[Architecture Definitions](Architecture_Definitions.md)：目錄責任、Runtime 與產物邊界。
- [Preset Application](Preset_Application.md)、[Stage Execution](Stage_Execution.md)：Preset、Stage 與 Snapshot 的關係。
- [Project 模板](../templates/AGENTS.md)、[Tools](../tools/README.md)：Project 導入與規則同步。
- [Spec Strategy](Spec_Strategy.md)：Requirement Workspace 與成熟工具的資料夾責任。
- [Data Access](Data_Access.md)：Project 資料庫索引位置與同步規則。
