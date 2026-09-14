# Installation

本文件只負責 **AI Developer Playbook 的安裝與導入**。

完成本文件後，再閱讀：[`docs/Usage.md`](./Usage.md)。

> 建議閱讀順序：**Installation → Usage**。

## 1. 前置條件

建議先準備：

- Git。
- 可讀取目標 Project 程式碼的 AI 工具，例如 ChatGPT / Codex / Cursor / Claude。
- 一個實際開發 Project。
- 若要使用 Snapshot 相容模式，需可執行 PowerShell。

## 2. 安裝 Playbook

第一次使用時 Clone：

```powershell
# Clone 中央 Playbook。
git clone https://github.com/gn00982591/AI-Developer-Playbook.git
```

例如安裝到：

```text
D:\AI-Developer-Playbook
```

已經安裝時，後續只需要更新：

```powershell
# 進入 Playbook。
Set-Location "D:\AI-Developer-Playbook"

# 取得最新版本。
git pull
```

## 3. 實際 Project 的基本結構

Playbook 與實際 Project 分開保存。

```text
AI-Developer-Playbook/
├─ agents/
├─ presets/
├─ docs/
├─ templates/
└─ tools/

實際 Project/
├─ AGENTS.md
├─ .ai-rules/     # 可選：Snapshot / Registry / 本地規則
├─ .ai-output/    # 建議：AI 暫存產物
└─ 原有程式碼
```

原則：

```text
Playbook = 共用規則母庫
AGENTS.md = Project 固定規則
.ai-rules = 可選的本地規則 / Snapshot
.ai-output = 一次性 AI 產物
```

## 4. 建立 Project `AGENTS.md`

若 Project 已經有 `AGENTS.md`，不要覆蓋，直接沿用並補充必要規則。

若尚未建立，可參考：

```text
templates/AGENTS.md
```

Project `AGENTS.md` 建議保存長期有效資訊：

- Tech Stack。
- Build / Test 指令。
- Folder / Architecture Notes。
- Database Rules。
- Business Constraints。
- Project-specific Rules。

不要把每一次任務的臨時需求一直塞進 `AGENTS.md`。

## 5. 建立 `.ai-output/`（建議）

可在實際 Project 建立：

```text
.ai-output/
├─ reports/
├─ diagrams/
├─ images/
├─ data/
└─ temp/
```

一次性分析結果先放 `.ai-output/`，確認成為正式文件後再移到 Project 的 `docs/`。

## 6. `.ai-rules/` 是否需要安裝

### 一般日常使用

新的 Stage / Skill Runtime 模型 **不要求每次任務都重建 `.ai-rules/`**。

開始主任務後，可直接在同一 Context 中呼叫：

```text
Stage: explore
Stage: propose
Stage: apply
Stage: verify
Stage: review
```

因此日常切換 Stage 不需要重新執行 PowerShell。

### Snapshot 相容模式

以下情況才建議使用 `.ai-rules/` Snapshot：

- 舊 Project 已經採用 `.ai-rules/`。
- 要固定某一組 Preset 規則。
- 要測試 Preset 實際包含哪些 Rule Module。
- 特殊離線或固定規則快照需求。

可執行：

```powershell
# 將指定 Preset 規則同步到目標 Project 的 .ai-rules/。
.\tools\apply-preset.ps1 -Preset "bug-fix" -ProjectPath "D:\Projects\OrderSystem"
```

注意：`apply-preset.ps1` 會重建目標 Project 的 `.ai-rules/`，所以它是 **安裝 / 同步 / 相容性工具**，不是日常 Runtime Stage 切換工具。

## 7. 驗證安裝

完成後至少確認：

```text
[ ] Playbook Repository 可以正常讀取
[ ] 實際 Project 有 AGENTS.md
[ ] AI 可以讀取 Project 程式碼
[ ] 已理解 .ai-rules/ 為可選 Snapshot
[ ] 不會用 PowerShell 來切換每一個 Stage
```

若需要測試 Snapshot 模式，可再確認：

```text
[ ] tools/apply-preset.ps1 可執行
[ ] 指定 Preset 能產生 .ai-rules/
```

## 8. 下一步

安裝完成後，不要繼續在本文件找 Runtime 操作方式。

請接著閱讀：

**[`docs/Usage.md`](./Usage.md)**

其中會說明：

- Preset 怎麼啟動。
- Stage / Skill 怎麼直接呼叫。
- 多個 Stage 怎麼串接。
- System Design 與 Diagram Profile 怎麼使用。
- Bug Fix / New Feature / SQL / Review 的實際範例。
