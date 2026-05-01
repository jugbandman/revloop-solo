---
type: dataview-rollup
auto-generated: true
---

Auto-generated rollup of all open customer action items, surfaced by priority and due date. Do not hand-edit.

# Customer Action Items Rollup

```dataview
TABLE
  customer AS "Customer",
  priority AS "Priority",
  due AS "Due",
  assignee AS "Owner",
  status AS "Status"
FROM "customers"
WHERE contains(file.path, "action-items") AND status != "done"
SORT priority ASC, due ASC
```

@TODO populate as customer files are created.
