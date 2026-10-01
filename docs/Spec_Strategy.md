# Spec Engine Strategy

本文件定義 AI Developer Playbook 與 Spec Kit、OpenSpec、Lightweight Flow 的責任邊界。

## 1. 核心定位

AI Developer Playbook 不再自行重做完整 Spec Framework。

```text
Input / Existing System
        │
        ▼
Requirement Intake
        │
        ▼
Playbook Router
        │
        ├─ Large / New / Ambiguous ──► Spec Kit
        ├─ Existing System Change ───► OpenSpec
        └─ Small / Clear Change ─────► Lightweight Flow
                                      │
                                      ▼
                           Implementation / Verify / Review
```

Playbook 的責任是：

- 需求進入與前置整理。
- 任務分流。
- 企業需求分析補強。
- Diagram 規則。
- System Design 補強。
- Token 節省與既有 Findings 重用。
- 統一 Output / Source / Reference 管理原則。

Spec Kit / OpenSpec 則視任務需要作為可替換的 Spec Engine，不要求兩套同時執行。

## 2. Spec Engine Router

### Spec Kit

優先使用情境：

- 新系統或大型新功能。
- 需求仍有明顯不確定性。
- 需要從 Requirement / User Story 推進到 Plan / Tasks / Implementation。
- 跨模組、跨服務或需要完整技術規劃。
- 需要較完整的 Clarify、Checklist、Analyze、Converge 等品質流程。

原則：Spec Kit 已有的 spec、plan、tasks、research、data-model、contracts 等產物，不在 Playbook 重新建立另一套同義文件。

### OpenSpec

優先使用情境：

- 既有系統的中小型需求變更。
- Change Request。
- 需要保留 Current Truth 與 Delta Spec。
- 需要 proposal / specs / design / tasks 的變更紀錄。
- 需求範圍已相對清楚，但仍需要正式變更管理。

### Lightweight Flow

優先使用情境：

- 小型 Bug Fix。
- 修改位置與需求都清楚。
- 小型 SQL / UI / Validation 調整。
- 不值得建立完整 Spec Artifact。

典型流程：

```text
explore（需要才做）
→ propose（需要才做）
→ apply
→ verify
→ review（依風險）
```

## 3. Requirement Workspace

Requirement Workspace 是 Spec Engine 前的可選工作區，不是另一套正式 Spec。

適合需求訪談、文件匯入、現況盤點仍在進行，尚不足以直接形成正式 Spec 時使用。

建議結構：

```text
requirements/
├─ sources/
│  ├─ meeting-notes/
│  ├─ documents/
│  └─ screenshots/
├─ analysis/
│  ├─ requirements.md
│  ├─ business-rules.md
│  ├─ ui-analysis.md
│  ├─ data-impact.md
│  └─ open-questions.md
└─ diagrams/
   ├─ business-flow.md
   ├─ ui-flow.md
   ├─ data-flow.md
   └─ state-transition.md
```

這是建議模型，不要求所有 Project 或所有需求建立全部資料夾；只建立實際需要的內容。

### Requirement Workspace 保存什麼

- 原始來源與訪談紀錄。
- 已確認需求。
- 尚未確認的假設。
- Business Rules。
- UI / Screen Notes。
- Business Flow。
- Data / Table Impact。
- Status / State。
- Open Questions。
- 用於需求理解的 Mermaid Diagram。

Requirement Workspace 保存「需求如何被理解與確認」；正式 Spec Engine 保存「確認後要做什麼」。

## 4. Diagram 與資料異動

需求階段即可產生 Diagram，但此時屬於分析產物，不代表最終 System Design。

可依需要使用既有 Diagram Profile：

```text
business-flow
state-transition
data-flow
module-map
call-chain
```

若訪談涉及資料庫，至少記錄：

- Requirement / Change ID（若有）。
- 影響資料表。
- 欄位或關聯。
- 預期異動。
- 對應 Business Flow / State。
- 尚未確認事項。

未確認內容必須標示 Pending / Assumption，不得當成既定事實。

## 5. Gap Analysis 標準

評估 Spec Kit、OpenSpec 或其他成熟能力時，固定檢查：

| 項目 | 檢查內容 |
| --- | --- |
| Workflow | 是否已有完整流程與可中斷/續跑能力 |
| Artifacts | 已有哪些正式產物 |
| Folder Structure | 是否已有標準資料夾與生命週期 |
| Requirement | 是否涵蓋需求探索、澄清、訪談來源 |
| UI Analysis | 是否保存畫面、互動與 UI 影響 |
| Business Flow | 是否能描述現況與目標流程 |
| Data / Table Impact | 是否能追蹤資料表、欄位與資料流異動 |
| State | 是否能描述狀態與轉移 |
| Diagram | 是否已有圖表規則與輸出方式 |
| System Design | 是否涵蓋架構與技術決策 |
| Change Tracking | 是否適合既有系統持續變更 |
| Review / Verify | 是否有一致性、驗證與收斂機制 |
| Agent / Skill / Preset | 如何組合、覆寫、載入與執行 |
| Token Cost | 是否造成重掃、重複規格或規則重載 |

每個 Gap 必須標記：

```text
Adopt  = 成熟方案已有，直接沿用
Extend = 成熟方案已有，但 Playbook 需要補強
Keep   = Playbook 特有且仍有價值，保留
Remove = 與成熟方案重複，移除或停止擴充
```

## 6. 第一版 Gap 結論

| 能力 | 決策 | 說明 |
| --- | --- | --- |
| Feature spec / plan / tasks | Adopt | 新功能優先沿用 Spec Kit，不重建同義產物 |
| Clarification / consistency / convergence | Adopt | 優先使用 Spec Kit 成熟流程 |
| Current Truth + Delta Change | Adopt | 既有系統正式變更優先使用 OpenSpec |
| Requirement source collection | Keep | Playbook 保留訪談、文件、截圖等前置來源管理 |
| Enterprise requirement analysis | Keep | UI、Business Rule、Data/Table Impact、State 等需求分析保留 |
| Diagram rules | Keep | 沿用 `agents/diagramming.md` 與 Diagram Profile |
| System Design | Extend | 優先消費 Spec Engine 產物，再補企業既有系統分析 |
| Bug / small change | Keep | 保留低成本 Lightweight Stage Flow |
| Output Management | Keep | `.ai-output/` 仍管理一次性 AI 產物 |
| Runtime PowerShell switching | Remove | 不作為日常 Runtime Orchestrator |

## 7. Folder Ownership

不要把所有工具的資料夾重新包成 Playbook 自有格式。

```text
Project/
├─ AGENTS.md                 # Project 固定規則
├─ .specify/                 # Spec Kit 自己管理（使用 Spec Kit 時）
├─ specs/...                 # Spec Kit feature artifacts（依其版本/設定）
├─ openspec/                 # OpenSpec 自己管理（使用 OpenSpec 時）
├─ requirements/             # Playbook 可選 Requirement Workspace
├─ .ai-output/               # 一次性 AI 產物
└─ docs/                     # 已確認正式文件
```

原則：

1. 成熟工具已定義的資料夾，由該工具管理。
2. Playbook 不複製同一份 spec / plan / tasks。
3. `requirements/` 只補 Spec 前的來源與分析缺口。
4. `.ai-output/` 不當正式 Spec Source of Truth。
5. 正式文件確認後才進 `docs/`。

## 8. 與既有 Preset / Stage 的關係

PB-001 第二階段已完成分類與最小遷移，決策與驗證見 [CHANGELOG v0.22](../CHANGELOG.md#v022---2026-10-01)。保留現有 Preset / Stage，正式產物沿用所選 Engine；propose 不再要求同義規格。

逐項遷移採以下原則：

```text
Adopt  → 改為呼叫 / 引導成熟工具
Extend → 保留最小補強 Rule Module
Keep   → 維持 Playbook 能力
Remove → 確認無相依後再移除
```

持續避免新增與 Spec Kit / OpenSpec 同義的大型 Agent、Preset 或文件模板。命令、產物位置與完成機制依專案已安裝版本及設定核對，不假定工具已安裝。

## 9. 設計原則

```text
Do not rebuild mature spec engines.
Route first.
Adopt before extend.
Keep enterprise gaps small and explicit.
One source of truth per artifact.
Load only what the current task needs.
```
