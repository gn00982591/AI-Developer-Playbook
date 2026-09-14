# Changelog

所有正式確認後的 Playbook 更新記錄於此。

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
