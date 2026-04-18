---
type: template
name: account-plan
updated: 2026-04-17
version: 2
---

<!--
CANONICAL ACCOUNT PLAN TEMPLATE (ADR-006)

This template is rigid. The /account-plan skill reads it as the source of truth.
Do not delete sections when a deal is early-stage — use placeholders like
`{add value — pre-qualification}` so you and the operator see the same structure
every time they open an account plan.

Formatting rules (also enforced by the skill):
- No em-dashes in prose. Use commas, periods, or colons in headers/labels only.
- No colons in prose. OK in headers and table labels.
- YYYY-MM-DD dates everywhere.
- Placeholders are `{add value — reason}`. Never fabricate data.
- Follow context/brand-voice.md for tone.

Token routing: skill is pinned to Opus via frontmatter model: claude-opus-4-7.
-->

# Account Plan — {{company}}

**Last updated:** {{YYYY-MM-DD}}
**Deal:** {{company}} | {{$amount or "$0 (TBD)"}} | {{stage}}
**Owner:** {{AE name}}
**Prepared by:** {{AE name}} + {{operator}}
**HubSpot:** [Deal record](https://app.hubspot.com/contacts/21992502/record/0-3/{{deal_id}})
**Target Go-Live:** {{YYYY-MM-DD or "{add value — no date established}"}}

---

## Objective

*One sentence. What does winning this deal look like?*

{add value}

---

## Account Overview

**Industry:** {add value}
**Size / headcount:** {add value}
**HQ location:** {add value}
**Key contacts:** {add value — names, titles, roles in the deal}

| Name | Title | Role | Last Contact |
|------|-------|------|-------------|
| {name} | {title} | Economic buyer / Champion / Blocker / Influencer / End user | {YYYY-MM-DD} |

---

## Why We Fit

*Specific to this account. Pull from transcripts and positioning.md. Not generic.*

{add value}

---

## Buying Committee Map

- **Economic buyer:** {name, title} or {add value — unknown, must identify}
- **Champion:** {name, title}
- **Blocker / procurement contact:** {name} or {add value}
- **End users:** {team / function}
- **Missing:** {who do we not have access to yet?}

---

## Decision Criteria

*What must be true for the buying team to move forward?*

| Criteria | Owner | Status |
|----------|-------|--------|
| {criterion} | {owner} | Not started / In progress / Done / Blocked |

---

## Milestones

*Buyer-action-focused. Not seller activities.*

| Date | Milestone | Owner | Status |
|------|-----------|-------|--------|
| {YYYY-MM-DD or TBD} | {milestone} | {owner} | Not started / In progress / Done / Blocked |

---

## Deal History (newest first)

### {{YYYY-MM-DD}} — {{call type / email / event}}

*What happened, what was said, what we learned. Source from transcripts.*

{add value}

---

## Current Blockers

| Blocker | Type | Our Response |
|---------|------|-------------|
| {blocker} | Budget / Timing / Champion / Procurement / Fit / InfoSec / Intelligence gap | {response} |

---

## Strategy + Next 30 Days

**Priority:** Close / Advance / Re-engage / Park

**30-day goal:** {add value}

**Action plan:**
1. {action with owner and timing}
2. {action with owner and timing}
3. {action with owner and timing}

---

## Pilot / Proposal Status

- Proposal sent: yes / no / in progress
- Pilot discussed: yes / no
- Procurement started: yes / no
- InfoSec review: yes / no / not applicable

---

## Risk Register

| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|------------|
| {risk} | Low / Medium / High | Low / Medium / High | {mitigation} |

---

## Success Metrics

*What does "working" look like for them? What will they measure? Source from the buyer, not our guesses.*

{add value}
