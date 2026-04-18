# CLAUDE.md — boot protocol

Read on every session. This file is the entry point for any AI surface (Claude Code, Claude Desktop cowork, plain-editor pair work).

## Boot sequence

1. **Read `USER.md`.** If missing or still matching `USER.md.example`, tell the user *"This vault isn't set up yet. Run `/start` (Claude Code) or paste the starter prompt from `DESKTOP-GUIDE.md` (Claude Desktop cowork) to begin."* Then stop.
2. **Read `.revloop/onboarding.json`.** If missing, create it with `level: 0` and all milestones `done: false`. Tell the user: *"Next up: identity. Run `/start`."*
3. **Branch on `onboarding.level`.**
   - `0` identity missing → *"Next up: identity. Run `/start`."*
   - `1` voice missing → *"Next up: voice calibration. Run `/start` or `/capture-voice`."*
   - `2` business context missing → *"Next up: business context. Run `/start` or `/capture-business`."*
   - `3` transcripts not connected → *"Next up: transcripts. Run `/start` or `/connect-transcripts`."*
   - `4` first deal not tracked → *"Next up: track a real prospect. Run `/start` or `/prospect-research`."*
   - `5` knowledge not curated → *"Next up: knowledge review. Run `/start` or `/import-context`."*
   - `6+` fully onboarded → run `/today` and suggest one improvement.

   Print one line only, then proceed with the user's actual request. Never block.

## Three execution surfaces

This vault runs on three surfaces. Work correctly in each.

| Surface | What works | What doesn't | Fallback |
|---|---|---|---|
| **Claude Code** | Hooks, slash commands, full fidelity | — | — |
| **Claude Desktop cowork** | File access, agentic flows | Hooks, slash commands | Follow sacred-sources checklist manually; use `DESKTOP-GUIDE.md` starter prompt |
| **Plain editor (Obsidian, VS Code)** | Markdown rendering, manual workflow | Automation | Use this file + `_system/` docs as the playbook |

Detect the surface by checking env: if `$CLAUDE_PROJECT_DIR` or `$CLAUDE_CODE_SESSION` is set → Claude Code. Otherwise assume cowork or plain editor.

## Sacred sources — the write gate

Before generating any outbound copy, deliverable, or entity write, confirm these files are loaded this session:

- [ ] `USER.md` (operator identity)
- [ ] `context/positioning.md`
- [ ] `context/icp.md`
- [ ] `context/brand-voice.md`

**In Claude Code** `.claude/hooks/write-gate.sh` enforces this mechanically.
**In Claude Desktop cowork / plain editor** you (the AI) enforce this by reading the four files first. Don't skip.

If any sacred source doesn't exist yet, run the appropriate milestone skill first: `/start` → `/capture-business` → `/capture-voice`.

## Identity and persona awareness

Read `USER.md` for who you're working with. It has identity, persona, autonomy settings, and preferences. Persona (from USER.md) changes how you prioritize and communicate:

| Persona | Primary focus | Tone |
|---------|--------------|------|
| **Founder** | Strategy, fundraise, hiring, product | Challenge assumptions, force prioritization |
| **Sales Leader** | Team performance, process, forecasting | Push proactive over reactive, flag scattered time |
| **Sales Manager** | Deal coaching, rep development | Tactical coaching, pattern recognition across deals |
| **AE** | Deal execution, prospecting, pipeline | Prep + follow-through, never let a thread drop |

## Path map

| Concern | Path |
|---|---|
| Operator identity / voice | `USER.md` |
| Positioning, ICP, offerings, voice, competitors | `context/` |
| Prospects, deals, closed, customers | `pipeline/` |
| People / stakeholders | `people/` |
| Meeting transcripts + notes | `meetings/` |
| Your process and playbooks | `playbooks/` |
| Reference material (frameworks, articles) | `knowledge/` |
| WIP scratch | `scratch/` |
| Drop zone for bulk imports | `_imports/` |
| Vault self-awareness | `_system/` |
| Note templates (sacred) | `_templates/` |
| Opt-in features (move to `.claude/skills/` to enable) | `_available/` |
| Onboarding state machine | `.revloop/onboarding.json` (gitignored, per-operator) |

## Sacred — never auto-edit

`CLAUDE.md`, `USER.md`, `_system/`, `_templates/`, `.claude/`, `.revloop/onboarding.json`. Suggest changes, never make them silently.

## Tool priority (optional Obsidian CLI)

If Obsidian is open and the Obsidian CLI is installed (v1.12.7+), use it for vault-aware operations. If not, fall back to filesystem tools cleanly.

| Operation | Prefer |
|-----------|--------|
| Check backlinks before moving/renaming | `Obsidian backlinks path=<path>` (or filesystem grep) |
| Vault-wide search | `Obsidian search query=<text>` (or Grep) |
| Find orphan / broken wikilinks | `Obsidian orphans` / `Obsidian unresolved` (optional) |
| Graph queries | `Obsidian eval code="..."` (optional) |
| Create / read / edit a file | Filesystem Write / Read / Edit |
| Search file content | Filesystem Grep |

**Obsidian is not required.** The vault works in VS Code, Cursor, vim, or any plain-markdown editor. Obsidian and its CLI are optional enhancers.

## Rules

**Formatting:** No em-dashes, no double dashes, no colons in prose (OK in headers/labels/lists). YYYY-MM-DD dates always.

**Data integrity:** Never fabricate data, use `{add value}` placeholders. Frontmatter on every entity (`type`, `status`, `updated` minimum).

**Outbound copy:** Manual approval gate for ALL outbound. Use configured sign-off (see USER.md). No SDR speak. Reference problems, not products. Write like a human.

**File naming:** Deliverables follow `YYYY-MM-DD-[type]-[description].md`. Entities use lowercase-kebab-case. Context files are always `context.md` in entity subfolders.

**Git:** Optional. If the operator uses Git, commit WIP before large sessions and on wrap. Not required for onboarding or daily work.

## Skills

Run with `/skill-name` in Claude Code. See `_system/FEATURES.md` for the full catalog.

**Milestone skills (the self-onboarding spine):**
- `/start` — Continuous router. Picks up wherever the vault left off.
- `/capture-voice` — Calibrate authentic voice → `context/brand-voice.md`
- `/capture-business` — Positioning, offerings, ICP, competitors → `context/*.md`
- `/connect-transcripts` — Wire Granola or paste-to-inbox for meeting transcripts

**Daily operations:**
- `/get-started` — Legacy onboarding advisor (delegates to `/start` when state exists)
- `/today` — Daily priorities from vault state
- `/morning-brief` — Email + calendar + pipeline check
- `/meeting-prep` — Calendar-aware meeting preparation
- `/sync-gh` — Git sync (optional; only if operator uses Git)
- `/wip` — Save/resume work-in-progress
- `/wrap` — End-of-task closure
- `/vault-review` — Health diagnostic

**Content and research:**
- `/icp-review`, `/process-transcript`, `/transcript-sync`, `/export-deliverable`, `/import-context`

## Agents

- `my-voice` — Writes/reviews in your authentic voice (reads USER.md + `context/brand-voice.md`)
- `researcher` — Deep company / contact research
- `sales-coach` — Reviews business cases, deal strategy, champion-selling
- `deal-researcher` — Deal-specific research; pulls transcript history + pipeline context

## Opt-in features (`_available/`)

Additional skills, enrichment scripts, automations, and dashboards live in `_available/`. Each subfolder has a README explaining what it does and how to enable it. Ship lean; grow as the operator needs more.

## Vault evolution

This vault is a living system. Help the operator build, maintain, and improve it over time. Never modify agents, CLAUDE.md, skills, hooks, or `_system/` files without explicit approval. Suggest improvements, don't silently make them.

Proactive awareness:
- Empty folders that should have content → suggest `/import-context`
- Stale entities (not updated in 14+ days) → surface in `/today`
- Missing sacred sources → flag before outbound work (hook or AI-enforced)
- Unprocessed files in `_imports/` → offer to route them

Logging:
- Update `++HOME/Recent Work.md` with deliverables and system changes each session
- Update `_system/health.md` when setup or automation status changes
- Update `_system/FEATURES.md` when skills or agents are added/modified
- Log significant changes in commit messages with `[system]` prefix

## Full deep dives

- `_system/self-onboarding-architecture.md` — the DNA of this template
- `_system/milestone-skill-contract.md` — how milestone skills interoperate with `.revloop/onboarding.json`
- `_system/FEATURES.md` — full feature catalog
- `_system/health.md` — setup checklist + automation status
- `_system/fork-this-vault.md` — how to fork this as YOUR template
- `_system/architecture-decisions/` — ADRs explaining why things are the way they are
- `DESKTOP-GUIDE.md` — for operators using Claude Desktop cowork
