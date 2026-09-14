# AI Developer Playbook

個人的 AI 開發工作方法與規則母版。

本 Repository 用來保存可跨公司、跨專案重複使用的 AI 開發流程、Prompt、Token 節省原則、Preset 與工作 SOP；不保存任何公司專有程式碼、帳號、連線資訊、正式資料或其他機密內容。

## 目的

- 保存可長期沿用的 AI 開發方法。
- 管理 ChatGPT / Codex 的工作流程。
- 降低大型 Repository 重複掃描與重複分析造成的 Token 浪費。
- 將共用規則、任務規則與專案規則分離，讓規則可依需求抽換。
- 保存常用 Prompt、工作流程、檢查表與 Preset。

## 整體概念

實際使用時採三層組合：

```text
通用規則
+
任務規則
+
專案規則
```

其中：

- **通用規則**：跨專案都適用，例如最小修改、避免無關 Refactor、資訊不足不得自行推測。
- **任務規則**：依目前工作內容抽換，例如 Explore、Propose、Apply、Archive、SQL、Testing、System Design。
- **專案規則**：只描述某個實際專案自己的技術棧、Build/Test、DB 規範、目錄結構與業務限制。

## 建議結構

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
│  └─ Token_Saving.md
│
└─ CHANGELOG.md
```

目前 Repository 仍以 `docs/` 為主；`agents/`、`presets/`、`templates/` 為後續模組化規則庫的目標結構。

## 各層用途

### 1. 通用規則

適用所有專案，例如：

- 採最小修改。
- 不做無關 Refactor。
- 資訊不足時列出缺漏。
- 不自行推測未知需求。
- 先搜尋定位，再讀必要檔案。
- 避免全面掃描 Repository。
- 延續前一階段的分析結果。
- 優先降低 Token 使用量。

### 2. 任務規則

依工作內容載入需要的規則，不必每次使用全部規則。

#### Bug Fix

```text
core
+ explore
+ apply
+ testing
+ token-saving
```

#### New Feature

```text
core
+ explore
+ propose
+ apply
+ testing
+ token-saving
```

#### SQL Change

```text
core
+ sql
+ apply
+ testing
+ token-saving
```

#### System Design

```text
core
+ explore
+ system-design
+ token-saving
```

### 3. 專案規則

每個實際專案只保存自己的差異，例如：

```text
Project/
└─ AGENTS.md / project-rules.md
   ├─ Tech Stack
   ├─ Build / Test
   ├─ Database Rules
   ├─ Folder Structure
   ├─ Business Constraints
   └─ Project-specific Rules
```

中央 Playbook 不保存特定公司或專案的機密內容。

## Playbook 與各專案的關係

```text
AI-Developer-Playbook
        ↓
   共用規則母版
        ↓
┌───────┼────────┐
↓       ↓        ↓
Project A
Project B
Project C
↓       ↓        ↓
各自加入 Project Rules
```

中央 Playbook 負責：

- 方法
- Prompt
- 流程
- Preset
- 共用規則
- Token 控制策略

實際 Project 負責：

- 技術棧
- Build / Test
- Database 規則
- 專案目錄與依賴
- 特殊業務規則

原則：**Agent / Playbook 管流程，Project 管規則。**

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

### 核心原則

- 每個階段只完成自己的工作。
- 下一階段不得無條件重新做上一階段的分析。
- 不一定每次都要執行完整四階段。
- 依需求清楚程度縮短流程。

### 流程選擇

需求或問題位置不清楚：

```text
Explore → Propose → Apply → Archive
```

已知道問題與修改位置：

```text
Propose → Apply → Archive
```

規格非常清楚：

```text
Apply → Archive
```

極小且明確的修改可直接 Apply。

詳細規則請見 `docs/OPSX_Workflow.md`。

## Token 節省原則

核心原則：

```text
Scan once.
Document once.
Reuse afterward.
```

避免：

- 全 Repository 重複掃描。
- 重複理解同一需求。
- 重複讀取相同檔案。
- 無關 Dependency 分析。
- 無關 Refactor。
- 下一階段重新做上一階段已完成的工作。

優先：

- Search first。
- Read only relevant files。
- Minimal change。
- Reuse previous findings。
- Limit test scope。

詳細規則請見 `docs/Token_Saving.md`。

## 控版規則

聊天或討論內容不等於正式版本。

只有在明確確認例如：

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
- 優先維持規則模組化，避免單一 `AGENTS.md` 無限制膨脹。

## 目前內容

- `docs/OPSX_Workflow.md`：OPSX 開發流程與各階段責任。
- `docs/Token_Saving.md`：降低 AI / Codex Token 使用量的原則。
- `CHANGELOG.md`：正式版本更新紀錄。
