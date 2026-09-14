# OPSX 開發流程

## 核心原則

每個階段只完成自己的工作，不讓下一階段重新做上一階段的分析。

流程：

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

## 1. Explore

### 何時使用

當需求、問題原因或修改位置還不清楚時。

### 原則

- 先搜尋，再讀檔案。
- 不全面掃描 Repository。
- 只讀與需求直接相關的程式。
- 不修改程式。
- 不進行無關架構分析。
- 找到必要呼叫鏈即可。

### Prompt

```text
/opsx-explore

研究此需求。

限制：
- 採最小探索範圍
- 先搜尋，再讀檔案
- 不全面掃描 Repository
- 只追蹤與需求直接相關的呼叫鏈
- 不修改程式
- 不做無關架構分析

輸出：
1. Current Flow
2. Root Cause
3. Affected Files
4. Affected API / SP / Table
5. Proposed Direction
6. Unknowns
```

## 2. Propose

### 何時使用

需求已確認，需要建立正式變更規格時。

### 原則

- 使用 Explore Findings。
- 不重新掃描 Repository。
- 只有 Findings 不足時才補充搜尋。

### Prompt

```text
/opsx-propose

根據 Explore Findings 建立正式 Change。

不要重新掃描 Repository。
僅在資訊不足時補充搜尋。

建立：
- Scope
- Out of Scope
- Current Behavior
- Expected Behavior
- Technical Design
- Affected Files
- DB Impact
- Acceptance Criteria
- Tasks

內容保持精簡。
```

## 3. Apply

### 何時使用

規格與 Tasks 已確認，可以開始修改程式時。

### 原則

- 採最小修改。
- 不重新做需求分析。
- 不重新探索 Repository。
- 不進行無關 Refactor。
- 優先只修改 Affected Files。
- 必要時才擴大搜尋。

### Prompt

```text
/opsx-apply

依照 Change Spec 與 Tasks 實作。

要求：
- 採最小修改
- 不重新探索 Repository
- 不重新做需求分析
- 不做無關 Refactor
- 優先修改 Affected Files
- 必要時才擴大搜尋
- 完成後執行必要 Build / Test
- 回報修改檔案與驗證結果
```

## 4. Archive

### 原則

只根據以下結果歸檔：

- Spec
- Tasks
- Git Diff
- Build / Test Result

不要重新掃描 Repository。

### Prompt

```text
/opsx-archive

歸檔目前 Change。

只使用：
- Spec
- Tasks
- Git Diff
- Build / Test Result

不要重新分析 Repository。
不要重新解釋需求。
```

## 流程選擇

不一定每個需求都要完整執行四個階段。

| 狀況 | 建議流程 |
| --- | --- |
| 不知道問題在哪 | Explore → Propose → Apply → Archive |
| 已知道問題與修改位置 | Propose → Apply → Archive |
| 規格非常清楚 | Apply → Archive |
| 極小且明確的修改 | 直接 Apply |
