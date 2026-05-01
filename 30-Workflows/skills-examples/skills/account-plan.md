---
model: claude-opus-4-7
---

# /account-plan

Draft or refine an enterprise account plan using the canonical template at `90-System/templates/account-plan.md`. Deal-slug-driven. Idempotent — safe to re-run as new context lands.

**Model pin:** Opus. Account plans are strategic, durable, and client-adjacent. Quality over cost.

## Invocation

```
/account-plan {deal-slug}
/account-plan {deal-slug} --refresh    # force re-ingest of new transcripts
/account-plan {deal-slug} --audit      # compare existing plan against template, report drift only
```

Deal slug matches the folder name in `80-Pipeline/deals/`. Examples: `acme-corp-discovery`, `contoso-qualifying`, `the-operator-buy-in`.

## Prerequisites

- `90-System/templates/account-plan.md` exists and is current (canonical template).
- `80-Pipeline/deals/{slug}/` exists with at least `context.md`.
- `60-Context/positioning.md` and `60-Context/icp.md` are up to date.

If any prerequisite fails, stop and report what's missing. Do not improvise.

## Input Contract

Read these files, in order, before writing anything. If a file is missing, flag it in the output but continue.

1. `90-System/templates/account-plan.md` — canonical structure. Do not deviate from section order or heading text.
2. `80-Pipeline/deals/{slug}/context.md` — entity context (company, stage, owner, key contacts, deal history, open questions).
3. `80-Pipeline/deals/{slug}/60sec-review.md` — the 60-second deal review (if it exists).
4. `80-Pipeline/deals/{slug}/business-case.md` — the business case (if it exists).
5. `80-Pipeline/deals/{slug}/account-plan.md` — prior version, if present. Informs the idempotent update path below.
6. Relevant bowtie: check `80-Pipeline/deals/` for any bowtie docs matching the deal owner.
7. `70-Meetings/external/` — filter by filename containing the company name or slug root. Read all matching transcripts. These are the source for Deal History, buying committee details, and buyer-voiced success metrics.
8. `60-Context/positioning.md` — your positioning. Use for the Why We Fit section.
9. `60-Context/icp.md` — ICP and buyer personas. Cross-check account profile.
10. `60-Context/brand-voice.md` — tone rules. Final pass checks compliance.

## Workflow

### 1. Resolve inputs

- Verify the deal folder exists. If not, stop and list available slugs in `80-Pipeline/deals/`.
- Check for a prior `account-plan.md` in the deal folder. If present, note `updated:` frontmatter date — that's the last-update watermark.
- Collect all matching transcripts in `70-Meetings/external/` by company name substring.

### 2. Decide path

- **No prior plan exists** — full draft mode. Generate from the template, fill every section from inputs.
- **Prior plan exists, no `--refresh` flag** — audit mode. Read the existing plan, diff against the template (section order, heading text, frontmatter schema). Report drift. Do not rewrite unless the operator asks.
- **Prior plan exists, with `--refresh` flag** — update mode. Keep existing filled-in content. Ingest only transcripts and context dated after the prior `updated:` watermark. Bump the watermark when done.
- **`--audit` flag** — audit mode regardless of prior state. Report drift only, no writes.

### 3. Draft or update

Fill sections in this order. Each section pulls from specific inputs per `90-System/templates/account-plan.md` comments.

1. **Frontmatter** — set `type: account-plan`, `company:`, `stage:`, `deal-amount:`, `owner:`, `date:` (today, YYYY-MM-DD), `updated:` (today, YYYY-MM-DD), `tags:`. Preserve prior `date:` if updating.
2. **Header block** — company, stage, deal amount, owner, CRM link, target go-live.
3. **Objective** — one sentence. Derive from 60sec-review or infer from stage + deal-amount + context.
4. **Account Overview** — industry, size, HQ, key contacts. Pull from context.md and transcripts.
5. **Why We Fit** — specific use case. Pull from positioning.md + buyer language in transcripts. Not generic.
6. **Buying Committee Map** — economic buyer, champion, blocker, end users, missing. Flag unknowns.
7. **Decision Criteria** — what must be true for them to move. Buyer-voiced when possible.
8. **Milestones** — buyer actions, not seller activities. Include dates when known, TBD otherwise.
9. **Deal History** — newest first. Source from transcripts, internal debriefs, email threads mentioned in context.md.
10. **Current Blockers** — what's in the way. Be specific about type (Budget / Timing / Champion / Procurement / Fit / InfoSec / Intelligence gap).
11. **Strategy + Next 30 Days** — priority (Close / Advance / Re-engage / Park), 30-day goal, 3 actions with owners.
12. **Pilot / Proposal Status** — 4-line status block.
13. **Risk Register** — risk, likelihood, impact, mitigation. Pull from transcripts and context.
14. **Success Metrics** — buyer-sourced. If no buyer voice, mark `{add value — must be sourced from {owner}}`.

### 4. Enforce formatting

Before writing, check the draft for:
- **No em-dashes in prose.** OK in filenames (export convention) but not in plan body.
- **No colons in prose.** OK in headers, labels, table cells.
- **YYYY-MM-DD dates** everywhere.
- **`{add value — reason}` placeholders**, never fabrications.
- **Sections in canonical order.** Re-check against template.
- **Headings match template exactly.** No rewording.

If any check fails, fix and re-verify.

### 5. Write

- Path: `80-Pipeline/deals/{slug}/account-plan.md`
- Bump `updated:` frontmatter to today.
- Preserve `date:` (original creation) on updates.

### 6. Report

Output to chat, not the file:
- What was drafted or updated (list of sections touched).
- Which inputs were missing or thin (e.g., "no transcripts found", "no CRM deal_id in context.md").
- Unknowns flagged in the plan that need operator follow-up.
- Path to the written file as an Obsidian link: `[Account Plan](obsidian://open?vault=<your-vault-name>&file=pipeline%2Fdeals%2F{slug}%2Faccount-plan.md)`.

## Idempotency

- Re-running without `--refresh` on an up-to-date plan is a no-op (audit mode returns "no drift").
- Re-running with `--refresh` only pulls context newer than `updated:` — it does not rewrite what's already filled.
- Section order and heading text are locked. The skill never invents new sections or reorders existing ones.

## Not in scope

- This skill does not export to Google Drive. That's a separate export skill.
- This skill does not update `context.md`, `60sec-review.md`, or `business-case.md`. Those are authored separately.
- This skill does not fabricate data. If the transcripts don't say it, the plan doesn't claim it.
