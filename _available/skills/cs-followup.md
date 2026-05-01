---
type: skill
status: scaffold
persona: customer-success
---

Generates a meeting-note, merges action items into the customer's action-items.md with SLA-derived due dates, and drafts a follow-up Slack post from a meeting transcript.

# /cs-followup

## What it does
Processes a meeting transcript into three artifacts: a saved meeting-note, action items merged into the customer's action-items.md (with priority and due date set per SLA guide), and a draft Slack follow-up post.

## Inputs
- Transcript path (required)
- Customer name (required)

## Outputs
- `customers/<name>/transcripts/YYYY-MM-DD-<title>.md` (per `_templates/meeting-note.md`)
- Action items merged into `customers/<name>/action-items.md` with priorities, due dates, status
- Slack post draft (held for manual approval per autonomy gate)

## Extension hooks
- Reads `playbooks/sla-guide.md` for priority tier and default due dates
- Respects sensitive-data routing for Semgrep-style regulated customer content
- Reads `customers/<name>/profile.md` to update last_contact and risks

@TODO build with operator. Connect to Gong / Granola transcript fetcher and pin the Slack draft template.
