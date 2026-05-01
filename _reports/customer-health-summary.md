---
type: dataview-rollup
auto-generated: true
---

Auto-generated health summary across all customer profiles, sorted by risk and last touch. Do not hand-edit.

# Customer Health Summary

```dataview
TABLE
  last_contact AS "Last Touch",
  open_actions AS "Open Items",
  risk AS "Risk",
  next_meeting AS "Next Meeting"
FROM "customers"
WHERE file.name = "profile"
SORT risk DESC, last_contact ASC
```

@TODO populate as customer profiles are created.
