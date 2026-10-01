# Changelog

所有正式確認後的 Playbook 更新記錄於此。

## v0.13 - 2026-10-01

### Added

- 新增 agents/data-access.md，統一 ContextProcedures／Result／SQL 前置檢查、資料存取方式決策與效能阻擋條件。
- 新增 docs/Data_Access.md，定義專案總入口、各資料庫索引、跨資料庫流程、生成／重新生成時的 MD 同步步驟與八項驗收案例。

### Changed

- Core、六個既有 Preset 與直接 Stage 流程接入共用資料存取規則；Snapshot 一併複製，非資料存取任務不套用。
- README、Usage、架構定義、Preset 同步說明與 Project AGENTS.md 模板補入導覽及索引責任。
- 設計與 Review 阻擋可合併查詢的 C# 拼接、迴圈逐筆補查與完整候選取回後篩選；必要跨資料庫 Service 整合須記錄理由、批次範圍及交易／一致性。
- 程式與相關資料庫 MD 必須在同一變更同步，索引與來源不一致不得視為完成。

### Compatibility

- 沿用既有 Preset／Stage 與 PowerShell 同步工具，不新增頂層 Preset、不修改工具。
- 只建立共用規範；未提供自動索引生成器或 EF Core Power Tools 掛鉤，實際專案索引不保存於 Playbook。

### Reason

先核對既有資料存取能力，避免另造重複 SP 或以多次查詢補組結果。依資料庫分層的索引讓 AI 定位相關來源，同時保留原始程式及 SQL 的判定權威，支援多資料庫且降低重複搜尋。

## v0.12 - 2026-09-14

### Added

- 新增 `docs/Installation.md`，集中保存第一次安裝、Project 導入、`AGENTS.md`、`.ai-rules/` Snapshot 與 PowerShell 定位。
- 新增 `docs/Usage.md`，集中保存 Preset、Stage / Skill、Diagram Profile、SQL、Review Lite 與多 Stage 串接的日常使用方式。

### Changed

- README 改為整體導覽與核心模型，避免後續架構重整時再次把安裝或使用步驟一起刪除。
- README 新增固定閱讀順序：`Installation → Usage → 詳細架構文件`。
- README 的 Repository 結構與文件導覽加入 `docs/Installation.md`、`docs/Usage.md`。

### Reason

將「如何安裝」與「如何使用」從 README 拆成獨立、穩定的文件責任。之後 README 可以調整架構說明，但安裝流程與日常操作不再依賴 README 內文，降低重整文件時遺失重要步驟的風險。

## v0.11 - 2026-09-14

### Added

- 新增 `docs/Stage_Execution.md`，定義可直接呼叫的 Stage / Skill Runtime 模型。
- 定義 `Stage: explore`、`Stage: apply`、`Stage: verify`、`Stage: review`、`Stage: diagram` 等平台中立呼叫語意。
- 定義 Flow Continuity：切換 Stage 時沿用 Findings、Spec、Diff、Test Result 與目前任務 Context。

### Changed

- Preset 改為「主任務與預設 Workflow」，不再視為 Runtime 規則切換開關。
- `docs/Architecture_Definitions.md` 新增 Stage / Skill 直接執行與 Runtime / PowerShell 邊界。
- `docs/Preset_Application.md` 改為 Stage-based Runtime；日常切換階段不再要求執行 PowerShell。
- README 改為 Preset 編排、Stage / Skill 執行、Rule Module 提供規則的模型。
- `tools/apply-preset.ps1` 保留為 Snapshot 相容、安裝、同步與測試工具，不作為 Runtime Orchestrator。

### Compatibility

- 既有 `agents/*.md` 先繼續作為 Rule Module，不複製另一套 Skill 規則。
- 既有 Preset 與 `apply-preset.ps1` 保留，可供舊 `.ai-rules/` Snapshot 專案使用。

### Reason

避免同一任務中切換 Explore、Apply、System Design、Diagram、Review 時反覆清除與重建 `.ai-rules/`，造成 Flow 中斷、規則互相覆蓋與重複分析。主任務啟動後應直接呼叫所需 Stage / Skill，保持同一工作上下文。

## v0.10 - 2026-09-14

### Added

- 新增 `agents/diagramming.md`，集中管理 Mermaid 共用切圖、可信度與 Token 節省規則。
- 提供五種精簡 Diagram Profile：`module-map`、`business-flow`、`call-chain`、`state-transition`、`data-flow`。

### Changed

- `system-design` Preset 新增載入 `agents/diagramming.md`。
- 同步更新 README、Preset 套用文件與同步結果清單。
- 修正 `bug-fix`、`sql-change` 條件說明被同步工具誤判為固定載入規則的既有問題。
- 明確區分：Preset 代表任務類型，Diagram Profile 代表圖的種類。

### Compatibility

- `tools/apply-preset.ps1` 不需修改；既有 `agents/*.md` 解析與同步機制可直接載入新模組。
- 未新增 Mermaid 類型的頂層 Preset，其他 Preset 的載入內容不變。

### Reason

讓 System Design 可依問題選擇適合的 Mermaid 圖，同時避免規則重複、過度切圖與為產圖重新掃描 Repository。

## v0.9 - 2026-09-14

### Fixed

- 修正 README 與 `docs/Preset_Application.md` 的 Preset Markdown 範例顯示。
- 外層範例改用四個反引號，讓內層三反引號 Code Fence 能正確呈現。
- 移除程式碼區塊中會被顯示成普通文字的多餘反斜線。

### Reason

避免 GitHub 將 \` 與 \`\`\` 直接顯示在範例中，確保讀者可以正確複製 Preset 語法。

## v0.8 - 2026-09-14

### Changed

- 將 README 的「引入使用方式」改為九個可執行步驟。
- 明確分開 Project 第一次導入、每次任務操作與 Preset 切換。
- 每一步補上 PowerShell 指令、預期結果與完成判斷。
- 同步重整 `docs/Preset_Application.md` 的詳細操作流程。

### Reason

讓使用者可以從準備 Playbook、建立 `AGENTS.md`、選擇與套用 Preset，一路操作到啟動 Agent，不需要自行推導中間步驟。

## v0.7 - 2026-09-14

### Added

- 新增 `presets/review-lite.md`，提供 Diff 優先的低 Token 複查流程。
- 補上 Preset Markdown 檔案語法與 `apply-preset.ps1` 實際套用指令。
- 提供 Bug Fix 與 Review Lite 的完整命令範例。

### Clarified

- Preset 不會自動成為 `/Bug-Fix` Slash Command。
- 正式用法為 `apply-preset.ps1 -Preset "<preset>" -ProjectPath "<project>"`。
- 舊式 Codex Custom Prompt 格式為 `/prompts:<name>`，但已棄用，不作為 Playbook 主要方案。

### Reason

讓「幫我再看一下」可只審查 Diff、指定 Commit 或指定檔案，並明確區分 Playbook Preset、PowerShell 套用指令與 Slash Command，避免誤用及不必要的 Token 消耗。

## v0.6 - 2026-09-14

### Added

- 新增 `tools/apply-preset.ps1`，可依 Preset 自動同步本次任務需要的規則到目標 Project 的 `.ai-rules/`。
- 新增 `docs/Preset_Sync.md`，說明同步流程、使用方式、Git 建議與注意事項。
- 新增 `tools/README.md`，集中說明 Playbook 輔助工具。

### Behavior

`apply-preset.ps1` 會：

1. 讀取 `presets/<preset>.md`。
2. 解析其中引用的 `agents/*.md`。
3. 清除目標 Project 既有 `.ai-rules/`。
4. 只複製本次 Preset 所需規則。
5. 保留 Project `AGENTS.md` 不變。

### Recommendation

- `.ai-rules/` 視為 Runtime Snapshot，建議加入實際 Project 的 `.gitignore`。
- 中央 `AI-Developer-Playbook` 是規則 Source of Truth。
- Project 長期保存 `AGENTS.md`，任務切換時只重新 materialize `.ai-rules/`。

### Reason

將 Preset 從手動複製流程進一步自動化，降低每次任務切換的操作成本，並避免舊規則殘留或載入不必要規則。

## v0.5 - 2026-09-14

### Added

- 新增「引入使用方式」，說明新 Project 第一次如何導入 Playbook。
- 定義 Agent / Codex 啟動時的固定引入 Prompt：先讀 Project `AGENTS.md`，再讀 `.ai-rules/`。
- 加入 Bug Fix、New Feature、SQL Change、System Design 的啟動範例。
- `templates/AGENTS.md` 新增 Runtime Rule Loading 與 Preset Materialization 說明。

### Changed

- `docs/Preset_Application.md` 補上從選 Preset、materialize 到 `.ai-rules/`、啟動 Agent、切換任務的完整流程。
- `README.md` 新增「引入使用方式」區塊，讓第一次導入與日常使用方式可直接查閱。
- 明確規定：不要因為使用 Preset 就讓 Agent 每次重新掃描中央 Playbook。

### Reason

讓模組化規則不只停留在結構設計，而是有明確的實際引入方式。Project 只保存固定 `AGENTS.md` 與本次任務需要的 `.ai-rules/`，Agent 啟動時只讀這兩個來源，以降低規則污染與不必要的 Token 使用。

## v0.4 - 2026-09-14

### Added

- 新增 `docs/Preset_Application.md`，定義 Preset 如何實際套用到 Project。
- 引入 Project `.ai-rules/` 作為本次任務的規則載入區。
- 定義 Runtime 規則模型：
  - Playbook = 規則母庫
  - Preset = 規則選單
  - `.ai-rules/` = 本次實際載入規則
  - `AGENTS.md` = Project 固定規則
- 定義規則優先順序：使用者本次指示 → Project `AGENTS.md` → `.ai-rules/` → Playbook 通用預設。
- 補上 Bug Fix、New Feature、SQL Change、System Design 的 `.ai-rules/` 套用範例。

### Changed

- `templates/AGENTS.md` 加入 Rule Loading Model 與 Rule Precedence。
- `README.md` 加入 Runtime Preset Loading、`.ai-rules/`、新 Project 套用步驟與切換 Preset 的概念。
- Token 原則補充：只 materialize 本次 Preset 所需規則，避免把整套 Playbook 載入 Project。

### Reason

讓 Preset 從邏輯上的規則組合，進一步變成可在實際 Project 中抽換的執行模型。切換任務時只替換 `.ai-rules/`，Project `AGENTS.md` 維持穩定，避免規則污染並降低不必要的 Token 使用。

## v0.3 - 2026-09-14

### Added

- 正式建立 `agents/` 模組化規則庫：
  - `core.md`
  - `explore.md`
  - `propose.md`
  - `apply.md`
  - `archive.md`
  - `sql.md`
  - `git.md`
  - `testing.md`
  - `system-design.md`
  - `code-review.md`
  - `token-saving.md`
- 建立 `presets/` 任務組合：
  - `bug-fix.md`
  - `new-feature.md`
  - `sql-change.md`
  - `system-design.md`
- 建立 `templates/AGENTS.md`，供新 Project 建立專案專屬規則。

### Changed

- `README.md` 從概念說明改為正式使用手冊。
- 明確定義：Playbook 管共用方法與流程、Preset 管本次載入組合、Project `AGENTS.md` 管專案差異。
- 加入新 Project 啟用步驟與各 Preset 的實際組合方式。
- Token 原則新增 `Load only required rules`，避免簡單任務載入整套規則。

### Reason

將 Playbook 從文件集合正式轉成可抽換的 Agent Rule Library。未來可依 Bug Fix、New Feature、SQL Change、System Design 等任務，只載入必要規則，再搭配各 Project 自己的 `AGENTS.md`，降低規則污染與不必要的 Token 使用。

## v0.2 - 2026-09-14

### Changed

- 擴充 `README.md`，補上 Playbook 的整體架構、用途與規則分層。
- 明確定義三層結構：通用規則、任務規則、專案規則。
- 補上 Playbook 與實際 Project 的關係：Playbook 管共用方法與流程，Project 管專案特殊規則。
- 加入模組化規則庫的建議結構：`agents/`、`presets/`、`templates/`。
- 加入 Bug Fix、New Feature、SQL Change、System Design 的規則組合示例。
- 補充 OPSX 流程選擇與 Token 節省原則。
- 強化控版規則：正式更新需保留 commit、更新 CHANGELOG，並避免單一 `AGENTS.md` 無限制膨脹。

### Reason

讓 Playbook 不只是文件集合，而是可依任務與專案抽換規則的中央母版，方便未來跨公司、跨專案沿用，同時降低不必要的上下文與 Token 使用。

## v0.1 - 2026-09-14

### Added

- 建立 AI Developer Playbook 基本說明與控版規則。
- 建立 OPSX 標準流程：Explore → Propose → Apply → Archive。
- 加入各階段的最小搜尋、最小修改與避免重複分析原則。
- 加入 Token 節省策略：Scan once, document once, reuse afterward。
- 加入依需求清楚程度選擇流程的原則，不強制每次執行完整四階段。

### Versioning Rule

- 討論內容不會自動寫入正式版本。
- 只有明確確認「更新 Playbook」或「這版確認，可以更新」後才修改 Repository。
- 每次正式變更保留 Git commit 紀錄。
