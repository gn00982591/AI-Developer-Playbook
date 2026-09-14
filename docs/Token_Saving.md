# Token 節省原則

## 1. 不要重複掃描 Repository

核心原則：

```text
Scan once.
Document once.
Reuse afterward.
```

避免讓 Explore、Propose、Apply、Archive 每個階段都重新理解整個專案。

## 2. 每個階段沿用上一階段結果

```text
Explore
→ Findings

Propose
→ 使用 Findings

Apply
→ 使用 Spec / Tasks

Archive
→ 使用 Diff / Test Result
```

下一階段只在資訊明確不足時，才補充必要搜尋。

## 3. 不一定每次都跑完整流程

### 不知道問題在哪

```text
Explore
→ Propose
→ Apply
→ Archive
```

### 已知道問題與修改位置

```text
Propose
→ Apply
→ Archive
```

### 規格非常清楚

```text
Apply
→ Archive
```

### 極小且明確的修改

直接 Apply。

## 4. 控制搜尋範圍

避免：

- 全 Repository 掃描。
- 無關 Dependency 分析。
- 重複解釋整個系統。
- 無關 Refactor。
- 不必要的長篇輸出。
- Archive 階段重新讀大量 Source Code。

優先：

- Search first。
- Read only relevant files。
- Minimal change。
- Minimal test scope。
- Reuse previous findings/spec/tasks。

## 5. 各階段的 Token 控制重點

### Explore

只探索必要範圍，找到與需求直接相關的呼叫鏈即可。

### Propose

直接使用 Explore Findings，不重新掃描 Repository。

### Apply

以 Change Spec、Tasks 與 Affected Files 為主要上下文；只有遇到缺漏、編譯錯誤或必要依賴時才擴大搜尋。

### Archive

只依據 Spec、Tasks、Git Diff、Build/Test Result 歸檔，不重新做需求分析或全面讀程式。

## 6. 最小修改原則

最小修改不只是降低風險，也能同時降低：

- 搜尋範圍
- 讀檔數量
- 修改檔案數量
- Diff 大小
- Test 範圍
- Agent reasoning
- Token 使用量
