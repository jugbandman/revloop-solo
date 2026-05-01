---
type: skill
status: scaffold
persona: customer-success
---

Creates or refreshes a customer's profile.md by synthesizing recent transcripts, emails, and slack-saves into a single source of truth document with last contact, themes, open feature requests, risks, and next meeting.

# /cs-customer-profile

## What it does
Generates or updates `10-Customers/<name>/profile.md` from the customer's existing folder contents (transcripts, emails, slack-saves, action-items).

## Inputs
- Customer name (required)
- Optional: specific transcript paths to incorporate
- Optional: `--full-rebuild` to regenerate from scratch instead of merging

## Outputs
- Updated `10-Customers/<name>/profile.md` with: last_contact, themes, open feature requests, risks, next_meeting, adoption signals
- Frontmatter normalized per `90-System/templates/customer.md`

## Extension hooks
- Reads `40-Playbooks/sla-guide.md` to set risk levels appropriately
- Respects sensitive-data routing (USER.md `sensitive-data: route-to-openai: true`)
- Auto-loads any `40-Playbooks/cs-*.md` for synthesis context

@TODO build with operator. Wire to actual transcript paths and finalize the synthesis prompt.
