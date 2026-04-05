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

## Knowledge and Playbooks

Two folders for methodology and reference material:

**`playbooks/`** — YOUR process. How you run discovery, your deal stages, your outreach cadence. See `playbooks/_index.md`.

**`knowledge/`** — Reference material you've collected. Frameworks, articles, posts, guidance. See `knowledge/_index.md`.

| Folder | What Goes There |
|--------|----------------|
| `knowledge/frameworks/` | Sales methodologies (MEDDIC, SCQA, etc.) |
| `knowledge/prospecting/` | Outbound tactics, research methods |
| `knowledge/deal-execution/` | Negotiation, proposals, closing |
| `knowledge/coaching/` | Development frameworks, performance |
| `knowledge/articles/` | Saved articles and blog posts |
| `knowledge/posts/` | LinkedIn posts and social content |

The sales-coach agent reads both when coaching. Run `/import-context` to detect gaps and import materials.

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
- `/meeting-prep` — Calendar-aware meeting preparation (quick/standard/deep research)
- `/sync-gh` — Git sync (commit, pull, push)
- `/wip` — Save/resume work-in-progress
- `/wrap` — End-of-task closure

Content and research:
- `/icp-review` — Build or refine ICP
- `/process-transcript` — Extract summary and action items from transcripts
- `/export-deliverable` — Clean markdown for delivery
- `/import-context` — Import materials, set up continuous data flows, detect vault gaps

## Agents

- `my-voice` — Writes and reviews content in YOUR authentic voice (reads USER.md)
- `researcher` — Deep company and contact research briefs
- `sales-coach` — Reviews business cases, deal strategy, and champion-selling content

### Auto-Loading

When working with revenue templates (business case, mutual action plan, deal review, executive summary) or any deal strategy work, **automatically load the sales-coach agent** to help with messaging quality and strategic framing.

## Vault Evolution

This vault is a living system. Help the operator build, maintain, and improve it over time.

**Ask before changing guidance.** Never modify agents, CLAUDE.md, skills, hooks, or _system/ files without explicit approval. Suggest improvements, don't silently make them.

**Proactive awareness:** Notice when something is missing or could be better. Flag it, don't fix it without asking.
- Empty folders that should have content → suggest `/import-context`
- Stale entities (not updated in 14+ days) → surface in `/today`
- Missing context files (no ICP, no positioning) → flag during outbound work
- Playbooks folder empty → suggest documenting after a successful process
- Knowledge folder empty → suggest saving frameworks after coaching
- Unprocessed files in `_imports/` → offer to route them

**After every session:** Suggest improvements, don't impose them:
- "You've run 5 discovery calls without a discovery playbook. Want to document your process?"
- "Your pipeline has deals but no ICP. Want to run /icp-review?"
- "That framework you just described would be useful saved in knowledge/frameworks/"

**Logging:** All changes to vault structure, agents, skills, and system files must be logged:
- Update `++HOME/Recent Work.md` with deliverables and system changes each session
- Update `_system/health.md` when setup or automation status changes
- Update `_system/FEATURES.md` when skills or agents are added/modified
- Log significant changes in commit messages with `[system]` prefix

**Maintenance:** Keep navigation current:
- `++HOME/++HOME.md` reflects actual vault structure
- `++HOME/Recent Work.md` tracks session outputs
- `_system/` is the vault's self-awareness (features, health, roadmap, contributors)
- Index files (`_index.md`) stay accurate as folders grow

**Growth pattern:** The vault should get more valuable every week. New entities, refined context, accumulated knowledge, documented processes.
