Reference of what the workflow-health dashboard looks like once populated. Useful for visualizing the end state before wiring real data.

# Workflow Health Sample Output

| Workflow | Last Run | Runs (7d) | Success | Avg Duration | Drift |
|----------|----------|-----------|---------|--------------|-------|
| /customer-call-prep | 2026-05-01 14:23 | 4 | 100% | 47s | OK |
| /cs-followup | 2026-04-30 09:11 | 2 | 100% | 31s | OK |
| /cs-calendar-block | 2026-04-26 20:00 | 0 | — | — | DRIFT (5d) |
| /account-research | 2026-04-29 11:02 | 1 | 100% | 312s | OK |
