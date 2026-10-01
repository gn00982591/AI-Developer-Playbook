# Preset: New Feature

適用於新增功能或需求範圍較完整的變更。

## 載入規則

- `agents/core.md`
- `agents/data-access.md`（涉及資料存取時套用；Snapshot 一併複製）
- `agents/explore.md`
- `agents/propose.md`
- `agents/apply.md`
- `agents/testing.md`
- `agents/archive.md`
- `agents/token-saving.md`

## 建議流程

```text
Route → 所選路徑的規格／方案 → Apply → Verify → Review（依風險）→ Archive（需要時）
```

## 分流與完成條件

- 沿用已確認路徑；尚未分流時依 [Spec Engine Strategy](../docs/Spec_Strategy.md) 判斷，必要時使用 requirement-intake。
- 大型、新系統或不確定需求優先 Spec Kit；既有系統正式變更優先 OpenSpec；小型明確功能保留 Lightweight。
- 正式產物由所選 Engine 管理，不另外建立同義 Playbook 文件；Engine 原生實作與 Playbook Stage 共用同一份 Tasks，不重複實作。
- 規則按當前階段載入，Archive 需要才執行；不要求兩套 Engine 同時運作。
- 核對驗收、完成必要驗證並列明限制；未執行或失敗不得宣告通過。
