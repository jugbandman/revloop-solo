---
type: skill
status: scaffold
persona: customer-success
---

Multi-level call preparation for customer-facing meetings. Pulls the customer profile, recent transcripts, action items, and any matching CS or QBR playbooks into a tier-appropriate prep doc.

# /customer-call-prep

## What it does
Builds a meeting agenda, talking points, and open-items doc for an upcoming customer call. Tier-appropriate: 5-minute, 15-minute, or 30-minute preparation depth.

## Inputs
- Customer name (required)
- Level: `--quick` | `--standard` | `--deep` (default: `--standard`)

## Reads
- `customers/<name>/profile.md`
- Recent transcripts from `customers/<name>/transcripts/`
- `customers/<name>/action-items.md`
- Optional: Linear feature requests
- Optional: customer Slack channel saves
- `playbooks/sla-guide.md`
- Optional: `playbooks/cs-discovery.md`, `playbooks/qbr.md` (any matching `cs-*.md` or `qbr*.md`)

## Outputs
- `--quick` (5 min): agenda only, 1 page max
- `--standard` (15 min): agenda + open items + feature signals
- `--deep` (30 min): full prep doc with talking points, risk callouts, expansion hooks

## Extension hooks
- Any playbook in `playbooks/` matching `cs-*.md` or `qbr*.md` is auto-loaded as additional context
- Respects sensitive-data routing

@TODO build with operator. Pin the per-tier output structure and wire to actual data sources.
