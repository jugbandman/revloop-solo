---
type: dataview-rollup
auto-generated: true
---

Auto-generated rollup of customer transcripts from the past seven days. Do not hand-edit.

# Weekly Customer Touches

```dataview
TABLE
  customer AS "Customer",
  type AS "Type",
  date AS "Date"
FROM "10-Customers"
WHERE contains(file.path, "transcripts") AND date >= dateformat(date(today) - dur(7 days), "yyyy-MM-dd")
SORT date DESC
```

@TODO populate as transcripts land.
