# Preset: System Design

適用於既有系統分析、交接文件與架構整理。

## 載入規則

- `agents/core.md`
- `agents/data-access.md`（涉及資料存取時套用；Snapshot 一併複製）
- `agents/explore.md`
- `agents/system-design.md`
- `agents/diagramming.md`
- `agents/token-saving.md`

## 建議流程

```text
Scope → Explore → Structure Findings → System Design
```

不以修改程式為目的時，不載入 Apply / Testing 規則。

## 輸入與完成條件

先沿用 Findings 與 Engine 設計，再按需 Explore → System Design → Diagram → Review。未使用 Engine 的既有系統交接可直接依程式與設定分析。

交付須區分現況與目標、列出來源及未確認事項；純圖表或文件需求核對產物一致性，不強制 Build / Test。
