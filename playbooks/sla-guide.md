---
type: playbook
purpose: doctrine for action item priority, due dates, and follow-up cadences
---

Doctrine for how action items get prioritized, given due dates, and escalated. /start-my-day reads this to rank today's action items; CS skills read it to set due dates on items they emit.

# SLA Guide

This file is the doctrine layer for action items. `/start-my-day` reads it to rank action items in today.md. `/cs-customer-profile`, `/customer-call-prep`, and `/cs-followup` read it to set due dates on items they emit.

## Priority Tiers

| Tier | Meaning | Default Response Window |
|------|---------|------------------------|
| **P0** | Active churn risk or contractual deadline | 24 hours |
| **P1** | Active expansion signal or customer-blocking | 3 business days |
| **P2** | Routine touch or proactive nudge | 7 business days |
| **P3** | Backlog / nice-to-have | 30 days |

## Default Due Dates by Action-Item Type

| Source | Default Due | Logic |
|--------|------------|-------|
| Customer-requested | Today + 1 day | They're waiting; treat as P1 unless flagged P0 |
| Transcript-derived | Today + 3 days | They mentioned it; treat as P2 unless explicit ask |
| Internal followup | Today + 5 days | Self-assigned, more flexible |
| Renewal-related | Contract end - 30 days | Auto-calculated from profile.md `contract_end` |

## Follow-up Cadence Rules

- No reply in 5 business days → escalate priority by one tier
- Quiet customer (no touch in 14 days) → create P2 check-in action item
- P0 unresolved past due → next /start-my-day surfaces it as a Top-3 candidate

## Today.md Flow

`/start-my-day` performs this sequence:
1. Read all `customers/*/action-items.md` via Dataview-equivalent query
2. Filter: `status: open AND due <= today + 1 day`
3. Rank: P0 breached > P0 due > P1 breached > P1 due > P2 breached > P2 due > P3 breached
4. Surface top 3 in today.md `## Top 3` section
5. Surface next 5–7 in today.md `## MoSCoW > Must Do`
6. Add `## Customer touches due today` from `customers/*/profile.md` where `next_meeting == today`
