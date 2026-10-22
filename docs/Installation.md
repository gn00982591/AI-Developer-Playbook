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

將 Playbook 安裝至目標專案的 `.agents/AI-Developer-Playbook/`，例如：

```text
D:\WorkGit\YFYTMSWeb\.agents\AI-Developer-Playbook
```

以下 PowerShell 與 CMD **擇一執行**。第一次安裝使用 Clone；已有安裝則執行更新。

### PowerShell

```powershell
# 建立專案的 AI 專用資料夾；已存在時保留原有內容。
New-Item -ItemType Directory -Path "D:\WorkGit\YFYTMSWeb\.agents" -Force | Out-Null

# 將 Playbook 安裝至獨立子資料夾。
git clone https://github.com/gn00982591/AI-Developer-Playbook.git "D:\WorkGit\YFYTMSWeb\.agents\AI-Developer-Playbook"
```

後續更新：

```powershell
# 更新此專案使用的 Playbook；有本地修改或分支分歧時停止。
git -C "D:\WorkGit\YFYTMSWeb\.agents\AI-Developer-Playbook" pull --ff-only
```

### CMD

```bat
REM 建立專案的 AI 專用資料夾；已存在時保留原有內容。
if not exist "D:\WorkGit\YFYTMSWeb\.agents" mkdir "D:\WorkGit\YFYTMSWeb\.agents"

REM 將 Playbook 安裝至獨立子資料夾。
git clone https://github.com/gn00982591/AI-Developer-Playbook.git "D:\WorkGit\YFYTMSWeb\.agents\AI-Developer-Playbook"
```

後續更新：

```bat
REM 更新此專案使用的 Playbook；有本地修改或分支分歧時停止。
git -C "D:\WorkGit\YFYTMSWeb\.agents\AI-Developer-Playbook" pull --ff-only
```

Playbook 保持獨立 Git Repository。若不將它納入業務專案控版，在目標專案既有的 `.gitignore` 補上（不要覆蓋既有內容）：

```gitignore
# Playbook 由自身 Repository 管理。
.agents/AI-Developer-Playbook/
```

## 3. 按需引導安裝 OpenSpec（正式變更才需要）

Playbook 採規則引用（Adopt），**不附帶 OpenSpec CLI，也不因 Clone 或載入 Playbook 而自動安裝**。只有 Requirement Router 選到 OpenSpec 的正式變更任務，才啟動以下引導；Spec Kit、Lightweight 或純分析任務不強制安裝。

1. **確認環境：**在目標 Project 確認 `openspec --version` 可執行，並檢查專案是否已完成 OpenSpec 初始化、所需的 Agent Skills / Commands 是否存在；CLI 已安裝不代表該 Project 已初始化。
2. **已可用：**直接引用 OpenSpec 原生工作流程，沿用既有 `openspec/` 產物；不要重裝、重跑初始化或覆蓋原有設定。
3. **CLI 未安裝：**先提供官方文件、環境前置條件及安裝指令；由使用者確認並授權後才執行安裝。若無安裝權限，回報阻礙與待辦，不將 Playbook Stage 假裝成原生指令。
4. **CLI 已安裝但 Project 未初始化：**先檢查既有檔案與版本／設定，再取得確認，才於目標 Project 執行 `openspec init`。已有正式規格或設定時，避免覆寫。
5. **完成後驗證：**核對 CLI 版本、Project 內的 `openspec/`、平台實際生成的 Skills / Commands 與必要設定，成功後才進入原生工作流程；失敗明列未完成項目。
6. **版本升級：**不是初次安裝的一部分；升級及 `openspec update` 須另外評估相容性並獲得確認。

官方 Quick Start（執行時仍應以最新官方文件為準）：

```powershell
# 需先有 Node.js 20.19.0 或更高版本及 npm。
node --version
npm --version

# CLI 尚未安裝且取得授權後執行。
npm install -g @fission-ai/openspec@latest

# 核對版本。
openspec --version

# 切換至實際業務專案根目錄後，經確認才初始化。
cd D:\WorkGit\YFYTMSWeb
openspec init
```

- 官方安裝來源：[OpenSpec Installation](https://openspec.dev/docs/installation)、[OpenSpec GitHub](https://github.com/Fission-AI/OpenSpec)。
- Windows PowerShell / CMD 可按官方 npm 安裝方式操作；macOS / Linux 亦可依官方說明使用 Homebrew。
- Playbook 與 OpenSpec 分開控版，`git pull` 更新 Playbook **不會**安裝或升級 OpenSpec。
- Runtime 決策細節見 [OPSX Workflow](OPSX_Workflow.md)。

## 4. 實際 Project 的基本結構

Playbook 放在實際 Project 的 `.agents/` 下，仍獨立管理共用規則與版本。

```text
YFYTMSWeb/
├─ AGENTS.md
├─ .agents/
│  └─ AI-Developer-Playbook/  # 獨立的規則母庫 Repository
│     ├─ agents/
│     ├─ presets/
│     ├─ docs/
│     ├─ templates/
│     └─ tools/
├─ .ai-rules/               # 可選：Snapshot / Registry / 本地規則
├─ .ai-output/              # 建議：AI 暫存產物
└─ 原有程式碼
```

原則：

```text
Playbook = 共用規則母庫
AGENTS.md = Project 固定規則
.ai-rules = 可選的本地規則 / Snapshot
.ai-output = 一次性 AI 產物
```

## 5. 建立 Project `AGENTS.md`

若 Project 已經有 `AGENTS.md`，不要覆蓋，直接沿用並補充必要規則。

若尚未建立，可參考：

```text
.agents/AI-Developer-Playbook/templates/AGENTS.md
```

Project `AGENTS.md` 建議保存長期有效資訊：

- Tech Stack。
- Build / Test 指令。
- Folder / Architecture Notes。
- Database Rules。
- Business Constraints。
- Project-specific Rules。

不要把每一次任務的臨時需求一直塞進 `AGENTS.md`。

在根目錄 `AGENTS.md` 記錄 Playbook 入口，例如：

```markdown
## Playbook 規則入口

- Playbook 位於 `.agents/AI-Developer-Playbook/`。
- 先讀本專案根目錄 `AGENTS.md`，再依本次 Preset / Stage 讀取 Playbook 的對應規則。
- `presets/` 與 `agents/` 均相對於 Playbook 根目錄。
- 使用 Snapshot 模式時，優先讀取 `.ai-rules/` 中本次所需規則。
- 按需讀取，不掃描或載入整份 Playbook。
```

放進 `.agents/` 不代表 AI 會自動載入全部內容；由 Project `AGENTS.md` 指向規則入口。

## 6. 建立 `.ai-output/`（建議）

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

## 7. `.ai-rules/` 是否需要安裝

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

#### PowerShell 執行

```powershell
# 將指定 Preset 規則同步到專案根目錄的 .ai-rules/。
& "D:\WorkGit\YFYTMSWeb\.agents\AI-Developer-Playbook\tools\apply-preset.ps1" -Preset "bug-fix" -ProjectPath "D:\WorkGit\YFYTMSWeb"
```

#### CMD 呼叫 PowerShell

```bat
REM 從 CMD 呼叫 PowerShell 腳本，將規則同步到專案根目錄。
powershell.exe -NoProfile -File "D:\WorkGit\YFYTMSWeb\.agents\AI-Developer-Playbook\tools\apply-preset.ps1" -Preset "bug-fix" -ProjectPath "D:\WorkGit\YFYTMSWeb"
```

CMD 的 Clone 與更新只需 Git；Snapshot 腳本仍需要 PowerShell，並遵循電腦既有的執行原則。`ProjectPath` 必須指向業務專案根目錄，不能指向 `.agents` 或 Playbook。

注意：`apply-preset.ps1` 會重建目標 Project 的 `.ai-rules/`，所以它是 **安裝 / 同步 / 相容性工具**，不是日常 Runtime Stage 切換工具。

## 8. 驗證安裝

完成後至少確認：

```text
[ ] .agents/AI-Developer-Playbook/ 可以正常讀取
[ ] 實際 Project 有 AGENTS.md，且已記錄 Playbook 入口
[ ] AI 可以讀取 Project 程式碼
[ ] 已理解 .ai-rules/ 為可選 Snapshot
[ ] 不會用 PowerShell 來切換每一個 Stage
```

若需要測試 Snapshot 模式，可再確認：

```text
[ ] tools/apply-preset.ps1 可執行
[ ] 指定 Preset 能產生 .ai-rules/
```

## 9. 下一步

安裝完成後，不要繼續在本文件找 Runtime 操作方式。

請接著閱讀：

**[`docs/Usage.md`](./Usage.md)**

其中會說明：

- Preset 怎麼啟動。
- Stage / Skill 怎麼直接呼叫。
- 多個 Stage 怎麼串接。
- System Design 與 Diagram Profile 怎麼使用。
- Bug Fix / New Feature / SQL / Review 的實際範例。
