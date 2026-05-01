# Enrichment — Clay Pipeline Examples

Add Clay-style enrichment to your pipeline. These example scripts connect your vault's lead files to Clay tables and HeyReach campaigns, closing the loop between your markdown CRM and your outbound tooling.

All three files ship with an `.example` suffix so they can live safely in version control without leaking credentials. Rename to activate.

## What Each Script Does

**clay-enrich.py** (the core enricher)
Scans your `80-Pipeline/leads/` folder for markdown files with `enriched: false` in their frontmatter. For each un-enriched lead, it builds a payload from the frontmatter fields (name, company, title, email, linkedin) and fires it to a Clay table via `clay-gtm-cli`. When Clay responds, the script writes enrichment data back into the lead file: company overview, industry, size, tech stack, signals, and a suggested outreach angle. Updates `enriched: true` and stamps `last-touched` so the file won't be re-processed on the next run.

Supports `--dry-run` (preview without writing), `--limit N` (process only N leads), and `--table custom-name` (target a specific Clay table).

**clay-batch-enrich.sh** (the pipeline wrapper)
Orchestrates the full enrichment run in one command: checks that `clay-gtm-cli` and `cloudflared` are installed, starts the Clay webhook tunnel, runs `clay-enrich.py`, calls `promote-leads.py` to advance newly-enriched leads to the next stage, and runs `export-dashboard-data.py` if present to refresh the dashboard. Accepts the same `--dry-run` and `--limit` flags as the Python script.

**heyreach-sync.py** (the campaign sync)
Pulls HeyReach campaign data back into your vault. Fetches all active campaigns from `heyreach-cli`, then matches each lead to a prospect `context.md` file by LinkedIn URL (with a name+company fallback). Writes `heyreach-campaign`, `heyreach-status`, and `heyreach-last-activity` into the matched frontmatter so your vault always reflects current outreach state.

## Prerequisites

- A Clay account with at least one enrichment table configured
- `clay-gtm-cli` installed: `npm i -g clay-gtm-cli`, then `clay auth login`
- `cloudflared` installed (for webhook tunnel): `brew install cloudflared`
- A HeyReach account and `heyreach-cli` installed (for `heyreach-sync.py` only)
- Python 3.11+ for both `.py` scripts

## How to Enable

1. Rename the example files to remove the `.example` suffix:
   ```bash
   cp clay-enrich.py.example clay-enrich.py
   cp clay-batch-enrich.sh.example clay-batch-enrich.sh
   cp heyreach-sync.py.example heyreach-sync.py
   ```

2. Set environment variables or replace placeholders:
   - `${YOUR_CLAY_API_KEY}` in clay-enrich.py if using direct API auth
   - `${YOUR_HEYREACH_API_KEY}` in heyreach-sync.py
   - Update the `DEFAULT_TABLE` constant in clay-enrich.py to match your Clay table name

3. Run a dry-run first to verify everything resolves correctly:
   ```bash
   python3 clay-enrich.py --dry-run
   bash clay-batch-enrich.sh --dry-run
   python3 heyreach-sync.py --dry-run
   ```

4. If dry-run looks right, run live:
   ```bash
   bash clay-batch-enrich.sh
   ```

## Lead File Frontmatter

The enrichment scripts expect lead files in `80-Pipeline/leads/` with this frontmatter shape:

```yaml
---
name: Contact Name
company: Company Name
title: Job Title
email: contact@company.com
linkedin: https://linkedin.com/in/handle
stage: lead
enriched: false
---
```

Files with `enriched: true` or `stage: prospect` or higher are skipped automatically.
