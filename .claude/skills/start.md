---
name: start
description: Continuous onboarding router. Reads .revloop/onboarding.json, picks the first undone milestone, and invokes the matching skill. Skip is always offered.
---

# /start

The self-onboarding state machine. Run any time. Picks up wherever the vault left off.

## Flow

1. **Read state.** Open `.revloop/onboarding.json`. If missing, create at `level: 0` with all milestones `done: false`.
2. **Pick next milestone.** First entry in this order that is `done: false` AND not in `skipped[]`:
   - `identity` → inline interview (Step A below)
   - `voice` → invoke `/capture-voice`
   - `business_context` → invoke `/capture-business`
   - `transcripts_connected` → invoke `/connect-transcripts`
   - `first_deal` → invoke `/prospect-research` with prompt for one company
   - `knowledge_curated` → invoke `/import-context` in default gap-detection mode
3. **All done?** Run `/today` then suggest one improvement (pick from: add a prospect, review a stale deal, draft one outbound note, capture a transcript).
4. **Skip handling.** If the user says "skip," push the milestone name into `skipped[]`, increment `level` past it, and move to the next. Never block.
5. **On milestone success.** The invoked skill flips its `milestones.{name}.done = true` and sets `at` to today's date. `/start` re-reads and advances.

## Step A: identity interview (inline)

Ask via AskUserQuestion, one field per question, free-text where useful:

1. Name?
2. Role? (Founder, Head of Sales, Sales Manager, AE, Consultant, Other)
3. Company name?
4. Email?

**Write USER.md** at root. Use the schema in `USER.md.example` with `{add value}` placeholders for fields not yet collected. Voice, Business, Tools sections can stay as placeholders; later milestones fill them.

Flip `milestones.identity.done = true` and save.

## Addressing the user

One line per invocation. Start with *"Next up: [milestone name]."* Then let the invoked skill take over. Never list the full menu unless the user asks "what are the milestones?"

## Aliases

`/get-started` is an alias for `/start`. Both resolve here.

## Contract for milestone skills

Every milestone skill:

1. Reads `.revloop/onboarding.json`.
2. Does its work (interview, paste, MCP setup, or direct invocation of an existing skill).
3. Accepts "skip" at any point — writes the milestone name into `skipped[]`.
4. On success, flips `milestones.{name}.done = true`, sets `at` to today, persists.
5. Returns control — the user runs `/start` again (or the parent invocation does).

Full contract: `90-System/system-docs/milestone-skill-contract.md`.
