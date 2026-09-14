# Token Saving Rules

## 核心原則

```text
Scan once.
Document once.
Reuse afterward.
```

## 規則

- 不讓 Explore、Propose、Apply、Archive 每個階段重新理解整個專案。
- 下一階段優先沿用上一階段成果。
- 只有資訊明確不足時才補充必要搜尋。
- Search first，Read only relevant files。
- 避免全 Repository 掃描、無關 Dependency 分析與重複解釋整個系統。
- 採 Minimal Change 與 Minimal Test Scope。
- Archive 不重新讀大量 Source Code。

## 階段接續

```text
Explore  → Findings
Propose  → Findings
Apply    → Spec / Tasks / Affected Files
Archive  → Diff / Test Result
```
