---
type: skill
status: scaffold
persona: customer-success
---

Multi-level account research patterned on Andy's job-sniper. Light, medium, and deep tiers for ticket scans, Linear/Slack adds, and full account dossiers including org chart and churn signals.

# /account-research

## What it does
Builds an account dossier at one of three depths. Patterned on the `job-sniper` skill — same multi-level architecture applied to customer accounts instead of job postings.

## Inputs
- Customer name (required)
- Level: `--light` | `--medium` | `--deep` (default: `--light`)

## Levels

### `--light` (5 min)
- Pylon ticket scan
- Recent transcript pull from `customers/<name>/transcripts/`

### `--medium` (15 min)
- Everything in light, plus:
- Linear feature requests for this customer
- Slack channel scan (last 14 days)

### `--deep` (30+ min)
- Everything in medium, plus:
- Org chart and decision-makers
- Contract value, renewal date
- Expansion signals (usage, multi-team adoption)
- Churn signals (sentiment, ticket trends, exec turnover)
- Technical fit history (integrations, blockers)

## Sensitive data
All levels respect sensitive-data routing. If the customer file has `#sensitive` or content lives under `customers/<name>/sensitive/`, that content goes through the OpenAI adapter per the Sensitive Data Routing doctrine in CLAUDE.md.

## Outputs
- `customers/<name>/research/YYYY-MM-DD-<level>.md`

@TODO build with operator. Wire MCP integrations for Pylon / Linear / Slack and finalize per-level prompts.
