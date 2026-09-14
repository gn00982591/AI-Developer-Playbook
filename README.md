# AI Developer Playbook

個人的 AI 開發工作方法與規則母版。

本 Repository 用來保存可跨公司、跨專案重複使用的 AI 開發流程、Prompt、Token 節省原則、Preset 與工作 SOP；不保存任何公司專有程式碼、帳號、連線資訊、正式資料或其他機密內容。

## 目的

- 保存可長期沿用的 AI 開發方法。
- 管理 ChatGPT / Codex 的工作流程。
- 降低大型 Repository 重複掃描與重複分析造成的 Token 浪費。
- 將共用規則、任務規則與專案規則分離，讓規則可依需求抽換。
- 讓不同 Project 只保留自己的差異，不重複複製整套規則。

## 整體模型

實際使用時採三層組合：

```text
通用規則
+
任務規則
+
專案規則
```

- **通用規則**：所有專案都適用，例如最小修改、避免無關 Refactor、資訊不足不得自行推測。
- **任務規則**：依目前工作內容抽換，例如 Explore、Propose、Apply、Archive、SQL、Testing、System Design、Code Review。
- **專案規則**：只描述某個實際 Project 自己的技術棧、Build/Test、DB 規範、目錄結構與業務限制。

原則：**Playbook / Agent 管方法與流程，Project 管專案差異。**

## Runtime 規則載入模型

Preset 不直接寫進 `AGENTS.md`。實際 Project 採以下模型：

```text
Playbook = 規則母庫
Preset = 本次任務的規則選單
.ai-rules/ = 本次實際載入規則
AGENTS.md = Project 固定規則
```

執行時：

```text
Project/AGENTS.md
+
Project/.ai-rules/
=
本次有效規則
```

切換 Bug Fix、New Feature、SQL Change、System Design 時，只替換 `.ai-rules/`，不改寫 `AGENTS.md`。

詳細操作：`docs/Preset_Application.md`

## Repository 結構

```text
AI-Developer-Playbook/
├─ agents/
│  ├─ core.md
│  ├─ explore.md
│  ├─ propose.md
│  ├─ apply.md
│  ├─ archive.md
│  ├─ sql.md
│  ├─ git.md
│  ├─ testing.md
│  ├─ system-design.md
│  ├─ code-review.md
│  └─ token-saving.md
│
├─ presets/
│  ├─ bug-fix.md
│  ├─ new-feature.md
│  ├─ sql-change.md
│  └─ system-design.md
│
├─ templates/
│  └─ AGENTS.md
│
├─ docs/
│  ├─ OPSX_Workflow.md
│  ├─ Token_Saving.md
│  └─ Preset_Application.md
│
└─ CHANGELOG.md
```

## 各資料夾用途

### `agents/`

最小化、可抽換的規則模組。每個檔案只負責一類工作。

| 模組 | 用途 |
| --- | --- |
| `core.md` | 所有任務共用的基本原則 |
| `explore.md` | 找現況、根因與影響範圍 |
| `propose.md` | 建立正式變更規格 |
| `apply.md` | 依規格最小修改程式 |
| `archive.md` | 依 Spec / Diff / Test Result 歸檔 |
| `sql.md` | SQL / Stored Procedure / DB 變更規則 |
| `git.md` | Branch / Commit / Diff / Git 操作規則 |
| `testing.md` | Build / Test / 驗證規則 |
| `system-design.md` | 系統架構、交接文件、呼叫鏈分析 |
| `code-review.md` | Diff 導向的 Code Review |
| `token-saving.md` | 控制搜尋範圍與 Token 使用 |

### `presets/`

常見工作類型的規則組合。Preset 不複製規則內容，只列出要載入哪些 `agents/` 模組。

### `templates/`

新 Project 可直接使用的專案規則模板。`templates/AGENTS.md` 只保存 Project-specific 欄位，不重複中央 Playbook 的共用規則。

### `docs/`

保存較完整的流程與使用說明。它是人閱讀的說明層，不代表每次任務都要全部載入。

## Preset 使用方式

### Bug Fix

```text
core
+ explore
+ apply
+ testing
+ token-saving
```

Project `.ai-rules/`：

```text
.ai-rules/
├─ core.md
├─ explore.md
├─ apply.md
├─ testing.md
└─ token-saving.md
```

若問題與修改位置已完全清楚，可省略 Explore。

### New Feature

```text
core
+ explore
+ propose
+ apply
+ testing
+ archive
+ token-saving
```

### SQL Change

```text
core
+ sql
+ apply
+ testing
+ token-saving
```

若影響範圍不清楚，再加入 Explore；若變更較大，再加入 Propose。

### System Design

```text
core
+ explore
+ system-design
+ token-saving
```

純分析任務不載入 Apply / Testing。

## 與實際 Project 的關係

```text
AI-Developer-Playbook
        │
        ├─ agents/   共用規則模組
        ├─ presets/  任務組合
        └─ templates/
             │
             ▼
       實際 Project
             │
             ├─ AGENTS.md
             │   ├─ Tech Stack
             │   ├─ Build / Test
             │   ├─ Database Rules
             │   └─ Business Constraints
             │
             └─ .ai-rules/
                 └─ 本次 Preset 實際載入的規則
```

例如：

```text
TMS 修 Bug
= TMS/AGENTS.md + bug-fix 對應 .ai-rules/

CMS 做 System Design
= CMS/AGENTS.md + system-design 對應 .ai-rules/
```

不要把特定公司或 Project 的特殊規則寫入中央 Playbook。

## 新 Project 怎麼開始

1. 從 `templates/AGENTS.md` 建立 Project 自己的 `AGENTS.md`。
2. 只填該 Project 的 Tech Stack、Build/Test、DB、架構與業務限制。
3. 建立 `.ai-rules/` 作為任務規則載入區。
4. 執行任務時選一個 Preset。
5. 將 Preset 所需 `agents/` 規則同步或複製到 `.ai-rules/`。
6. 使用 `AGENTS.md + .ai-rules/` 作為本次有效規則。
7. 切換任務時替換 `.ai-rules/`，避免舊規則殘留。

## Rule Precedence

若規則衝突，建議優先順序：

```text
1. 使用者本次明確指示
2. Project AGENTS.md
3. Project .ai-rules/
4. Playbook 通用預設
```

## OPSX 標準流程

```text
Explore
↓
Findings
↓
Propose
↓
Spec / Tasks
↓
Apply
↓
Diff / Test
↓
Archive
```

核心原則：

- 每個階段只完成自己的工作。
- 下一階段不得無條件重新做上一階段的分析。
- 不一定每次都執行完整流程。
- 依需求清楚程度縮短流程。

| 狀況 | 建議流程 |
| --- | --- |
| 不知道問題在哪 | Explore → Propose → Apply → Archive |
| 已知道問題與修改位置 | Propose → Apply → Archive |
| 規格非常清楚 | Apply → Archive |
| 極小且明確修改 | Apply |

詳細說明：`docs/OPSX_Workflow.md`

## Token 節省原則

```text
Scan once.
Document once.
Reuse afterward.
Load only required rules.
```

避免：

- 全 Repository 重複掃描。
- 重複理解同一需求。
- 重複讀取相同檔案。
- 無關 Dependency 分析。
- 無關 Refactor。
- 下一階段重新做上一階段已完成的工作。
- 為簡單任務載入全部規則。

優先：

- Search first。
- Read only relevant files。
- Minimal change。
- Reuse previous findings。
- Limit test scope。
- 只 materialize 本次 Preset 所需規則。

詳細說明：`docs/Token_Saving.md`、`agents/token-saving.md`、`docs/Preset_Application.md`。

## 控版規則

聊天或討論內容不等於正式版本。

只有在明確確認，例如：

```text
更新 Playbook
```

或：

```text
這版確認，可以更新
```

才修改 Repository。

每次正式修改都應：

- 建立 Git commit。
- 更新 `CHANGELOG.md`。
- 保留修改目的與原因。
- 優先維持規則模組化。
- 避免單一 `AGENTS.md` 無限制膨脹。

## 設計原則摘要

```text
Playbook = 規則母庫
Preset = 規則選單
.ai-rules/ = 本次任務規則
AGENTS.md = Project 固定規則
```

目標不是建立一個越來越大的 Prompt，而是建立一套可依工作內容組裝、替換、重複使用的規則庫。
