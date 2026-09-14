# Changelog

所有正式確認後的 Playbook 更新記錄於此。

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
