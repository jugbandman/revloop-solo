# CLAUDE.md

Strategic brain for this RevLoop Solo vault. Read on every session boot.

## Identity

Read `USER.md` for who you're working with. It has identity, persona, autonomy settings, and preferences.

**If USER.md is missing or the Identity section is empty, run `/get-started` before doing anything else.**

### Persona Awareness

The user's persona (from USER.md) changes how you prioritize and communicate:

| Persona | Primary focus | Tone |
|---------|--------------|------|
| **Founder** | Strategy, fundraise, hiring, product | Challenge assumptions, force prioritization |
| **Sales Leader** | Team performance, process, forecasting | Push proactive over reactive, flag scattered time |
| **Sales Manager** | Deal coaching, rep development | Tactical coaching, pattern recognition across deals |
| **AE** | Deal execution, prospecting, pipeline | Prep + follow-through, never let a thread drop |

## System Awareness

**Sacred (never auto-edit):** `CLAUDE.md`, `USER.md`, `_system/`, `_templates/`

**Self-documentation:** `_system/FEATURES.md` (skills/agents), `_system/health.md` (status), `_system/ROADMAP.md` (plan)

**Navigation:** `++HOME/++HOME.md` is the master navigation hub. `++HOME/Recent Work.md` tracks session outputs.

## Context

Context files live in `context/`. These expand on your identity:

- `positioning.md` — company positioning and differentiators
- `icp.md` — ideal customer profile and buyer personas
- `brand-voice.md` — writing style, tone, do/don't rules
- `offerings.md` — products/services and when to reference them
- `competitors.md` — competitive landscape and objection handling
- `tool-stack.md` — tools in use and how they connect

Copy from `.example` files to initialize. Not all are needed on day 1. Run `/get-started` anytime to see what to set up next.

## Write Gate

Before generating any outbound copy or deliverable, load these required sources:

1. `USER.md`
2. `context/positioning.md`
3. `context/icp.md`
4. `context/brand-voice.md`
5. Relevant entity `context.md` (if writing for a specific person/company)

The write gate hook enforces this mechanically.

## Folder Map

```
revloop-solo/
├── ++HOME/               # Navigation hub + Recent Work tracker
├── CLAUDE.md             # This file (strategic brain)
├── USER.md               # Your identity and preferences
├── today.md              # Daily operating file (created by /today or /get-started)
├── context/              # Company context (positioning, ICP, voice)
├── pipeline/             # Deals, prospects, closed
│   ├── prospects/        # Enriched, in conversation
│   ├── deals/            # Proposal sent or meeting booked
│   └── closed/           # Won or lost (with re-engagement criteria)
├── people/               # Contacts, stakeholders
├── meetings/             # Meeting notes and transcripts
├── playbooks/            # Sales process, frameworks
├── scratch/              # Brain dumps, quick captures
├── _imports/             # Drop zone for docs, transcripts, CSVs
├── _system/              # Vault self-awareness
└── _templates/           # Note templates (never modify)
```

### Folder Rules

**Pipeline:** `pipeline/prospects/` = enriched, in conversation. `pipeline/deals/` = proposal sent or meeting booked. `pipeline/closed/` = won or lost.

**People:** Contacts and stakeholders live in `people/`. People attached to prospects/deals can also live in their entity subfolder.

**Content:** `meetings/` for all meeting notes and transcripts. `scratch/` for brain dumps and WIP. Move to deliverables when finalized.

**Imports:** `_imports/` is a drop zone. Put files there and they'll be routed:
- Transcripts → `meetings/`
- CSVs → `pipeline/` (leads or prospects)
- Documents → `context/`
- Pitch decks, brand guides → `context/`

## Entity Lifecycle

```
pipeline/prospects/ → pipeline/deals/ → pipeline/closed/
```

Each entity gets a subfolder with a `context.md`. Read it before writing for that entity.

**Promotion rules:**
- **Prospect → Deal:** Meeting booked or proposal sent
- **Deal → Closed:** Contract signed (won) or documented loss with re-engagement criteria
- **Closed-Lost → Prospect:** When re-engagement criteria met, move back with updated context

## Rules

**Formatting:** No em-dashes, no double dashes, no colons in prose (OK in headers/labels/lists). YYYY-MM-DD dates always.

**Data integrity:** Never fabricate data, use `{add value}` placeholders. Frontmatter on every entity (`type`, `status`, `updated` minimum).

**Outbound copy:** Manual approval gate for ALL outbound. Use configured sign-off (see USER.md). No SDR speak. Reference problems, not products. Write like a human.

**File naming:** Deliverables follow `YYYY-MM-DD-[type]-[description].md`. Entities use lowercase-kebab-case. Context files are always `context.md` in entity subfolders.

**Git:** Everything commits. No gitignored content layers. Commit WIP before large sessions. Commit + push when done. Format: `[Type]: [Description]`.

## Skills

Run these with `/skill-name` in Claude Code. See `_system/FEATURES.md` for the full catalog.

Core daily operations:
- `/get-started` — Progressive onboarding (run anytime to see what's next)
- `/today` — Daily priorities from vault state
- `/morning-brief` — Email + calendar + pipeline check
- `/sync-gh` — Git sync (commit, pull, push)
- `/wip` — Save/resume work-in-progress
- `/wrap` — End-of-task closure

Content and research:
- `/icp-review` — Build or refine ICP
- `/process-transcript` — Extract summary and action items from transcripts
- `/export-deliverable` — Clean markdown for delivery

## Agents

- `my-voice` — Writes and reviews content in YOUR authentic voice (reads USER.md)
- `researcher` — Deep company and contact research briefs
- `sales-coach` — Reviews business cases, deal strategy, and champion-selling content
