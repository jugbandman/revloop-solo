Scaffolding for a workflow-health dashboard that tracks last run, success rate, output quality, and drift across all skills. Promote into _reports/ when ready.

# Workflow Health Dashboard (scaffolding)

A dashboard for tracking which workflows are firing, their health, and drift.

## What it tracks
- Last run timestamp per workflow
- Success / error rate
- Output quality (manual rating, optional)
- Drift detection — workflow that hasn't fired in N days

## How to enable
1. Promote `_reports/workflow-health.md` into your `_reports/` directory.
2. Each skill that runs (e.g., /customer-call-prep, /cs-followup) should append to `_reports/workflow-runs.log` (one JSON line per run).
3. The dashboard reads that log via Dataview.

## Data model
See `spec.md`.

## What it looks like
See `sample-output.md`.
