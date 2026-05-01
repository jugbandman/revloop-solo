Workflow-health data model. Defines the per-run JSON log line format and the aggregations the dashboard computes from the log.

# Workflow Health Data Model

## Run log line (one JSON per skill execution)

```json
{
  "workflow": "customer-call-prep",
  "level": "standard",
  "timestamp": "2026-05-01T14:23:11Z",
  "duration_seconds": 47,
  "status": "success",
  "input_ref": "customers/acme/profile.md",
  "output_ref": "customers/acme/transcripts/2026-05-01-prep.md",
  "quality_rating": null
}
```

## Aggregations
- Per-workflow last run, run count (7d / 30d), avg duration, success rate
- Drift flag: workflows expected to run weekly but unseen in 14d
