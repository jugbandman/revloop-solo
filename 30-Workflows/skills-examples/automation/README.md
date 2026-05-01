# Automation — Wire Vault Events to n8n

Connect your vault to n8n for event-driven workflows. The core pattern is simple: an external system posts a payload to an n8n webhook, n8n validates and transforms the data, then shells out to a Python script that writes a markdown file into your vault. Your vault stays as the source of truth; n8n is the plumbing that gets data there automatically.

## The Webhook to LLM to File Pattern

The included sample workflow demonstrates lead ingestion, but the pattern generalizes to anything that produces structured data:

**Step 1 — Webhook Trigger**
n8n listens on a configurable path (e.g., `POST /webhook/lead-sync`). Any system that can make HTTP requests can send data here: a Clay table, a Zapier zap, a form submission, a cron job, your own script.

**Step 2 — Parse and Validate**
A Code node normalizes the incoming payload into a known schema. This is where you handle missing fields, clean strings, and throw errors for invalid data. Keeping this logic in JavaScript makes it easy to iterate without touching your vault scripts.

**Step 3 — Shell to Vault Script**
An Execute Command node calls a Python script (e.g., `90-System/scripts/ingest-leads.py`) with the validated data. The script creates or updates a markdown file in the correct vault folder, writes frontmatter, and returns an exit code. n8n captures stdout and stderr.

**Step 4 — Format Response**
A final Code node reads the script output and builds a JSON response. If the webhook caller is waiting synchronously, they get a success or error payload. If it's fire-and-forget, this node just logs the result.

## Sample Workflow

`sample-workflow.json.example` implements the lead ingestion pattern. Import it into n8n via Settings > Import Workflow. After importing:

1. Update the Execute Command node's path from `/path/to/your/vault` to your actual vault root
2. Activate the workflow and copy the generated webhook URL
3. Test with a curl command before wiring it to a live source

## Prerequisites

- n8n running (self-hosted or cloud). n8n.io for cloud, `npm i -g n8n` for local.
- Your vault ingest scripts present in `90-System/scripts/` (the sample calls `90-System/scripts/ingest-leads.py`)
- n8n and your vault on the same machine, or the Execute Command node replaced with an SSH or API call if they're separate

## Extending the Pattern

The webhook trigger and shell-out pattern works for any vault write operation. Common extensions:

- **Meeting notes ingestion**: a Granola webhook posts transcript JSON, n8n formats it as markdown, the script saves to `70-Meetings/`
- **CRM sync**: HubSpot deal updates fire a webhook, n8n writes status changes to `80-Pipeline/deals/{slug}/context.md`
- **Enrichment callbacks**: Clay fires a webhook when enrichment completes, n8n routes the payload to `30-Workflows/skills-examples/enrichment/clay-enrich.py`

Keep n8n workflows thin. Parse and validate in the Code node, then delegate to a vault script for all file operations. This keeps your business logic in Python (version-controlled, testable) rather than locked inside n8n's JSON workflow format.
