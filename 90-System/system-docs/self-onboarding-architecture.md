# Self-Onboarding Vault Architecture

This doc describes the architecture so other vaults can implement the same pattern. The reference deployment is `revloop-solo`.

## Problem

A vault full of skills, agents, and templates is a toolbox without a front door. First-time users face 16+ folders, 18 skills, a README that opens with `git clone`, and no guidance on what to do first. Value is hidden behind setup.

## Pattern

Flip the posture: the vault boots, reads its own state, and tells the user the single next thing that unlocks value. Onboarding is continuous — every session picks up at the next undone milestone.

Three moves:

1. **Boot protocol.** `CLAUDE.md` stays thin. Every session, Claude Code reads `USER.md` + `.revloop/onboarding.json`, branches on maturity level, prints one-line direction.
2. **Maturity state machine.** `.revloop/onboarding.json` tracks milestones: identity → voice → business → transcripts → first deal → knowledge. Each milestone has a dedicated skill. `/start` is the router.
3. **Scaffolding hides.** System, scripts, templates, features, reports, docs all live under dot-prefixed `.revloop/`. Obsidian hides dot-folders by default; Claude Code and scripts still see them.

## Top-level layout

```
USER.md              # operator identity + voice + business
CLAUDE.md            # thin boot protocol
README.md            # onboarding-first, not prerequisites-first

80-Pipeline/         # prospects, deals, closed (differentiated by frontmatter)
20-People/           # individuals across all orgs
70-Meetings/         # meeting recordings (internal/ + external/)
60-Context/          # positioning, ICP, brand voice, playbooks, source materials
Deliverables/        # clean client-facing output
Workspace/           # scratch + WIP
++HOME/              # navigation MOCs

.revloop/
  system/            # vault self-awareness (FEATURES.md, vault-health-report.md, vault-roadmap.md)
  scripts/           # active automation (sync, export, ingest)
  templates/         # entity templates (never modify in session)
  features/          # optional tooling (dashboard, enrichment, pipeline-gen, automation)
  reports/           # auto-generated Dataview rollups
  docs/              # architecture + porting docs
  onboarding.json    # maturity state

.claude/             # skills, agents, hooks, commands
```

## Boot sequence

1. Read `USER.md`.
2. Read `.revloop/onboarding.json`. Create at `level: 0` if missing.
3. Find first `milestones.{x}.done === false && !skipped.includes(x)`.
4. Print one line: *"Next up: [x]. Run `/start` or `/[skill]`."*
5. Proceed with the user's actual request. Never block.

## Milestone skill contract

See `.revloop/docs/milestone-skill-contract.md`.

## Data durability

Data folders (`80-Pipeline/`, `20-People/`, `70-Meetings/`, `60-Context/`, `00-Inbox/`, `10-Customers/`) stay user-owned. The architecture never rewrites or moves data, only the scaffolding around it.

## Obsidian and GitHub optional

Dot-prefix hides `.revloop/` in Obsidian's file tree. Dataview queries in `.revloop/reports/` should have plain-markdown fallbacks so the vault works without the plugin. Git is a backup option, not a prerequisite — users can clone, download a zip, or sync via Dropbox/Drive.

## Why this works

- **One line, not a menu.** Users don't choose; they're told one next thing.
- **Continuous, not one-shot.** Every session is an onboarding session until maturity hits level 6+.
- **Scaffolding disappears.** Non-technical users see eight working folders, not sixteen.
- **Data is sacred.** Restructure touches structure; entities and content stay intact.
