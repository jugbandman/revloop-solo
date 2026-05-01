# ADR-002: Skills and Agents in the RevLoop Solo Template

**Status:** Accepted
**Date:** 2026-03-31

## Context

The original `revloop` repo contained GTM workflow scripts designed as coaching conversations (SCRIPT.md files in `gtm-workflows/`). These were conversational coaching scripts meant for a generic AI pane interaction model, with `@company-context/` file references and a coaching-first, teaching-second approach.

Both the scripts and any operator voice agents needed to be adapted for the revloop-solo vault, which is a standalone repo with its own folder structure (`80-Pipeline/`, `60-Context/`, `70-Meetings/`, `00-Inbox/`).

## Decision

### What Was Ported

**Agents (2):**

| Agent | Purpose |
|-------|---------|
| `my-voice` | Operator voice calibration, reads `60-Context/brand-voice.md` and enforces voice rules on all client-facing output |
| `deal-researcher` | Deep prospect research — produces comprehensive briefs written to entity folders |

**Skills (9, from 6 GTM workflows + 3 new):**

| Skill | Source | Destination |
|-------|--------|-------------|
| `outreach` | GTM workflow | `.claude/skills/outreach.md` |
| `discovery-prep` | GTM workflow | `.claude/skills/discovery-prep.md` |
| `call-debrief` | GTM workflow | `.claude/skills/call-debrief.md` |
| `prospect-research` | GTM workflow | `.claude/skills/prospect-research.md` |
| `proposal-draft` | GTM workflow | `.claude/skills/proposal-draft.md` |
| `icp-review` | GTM workflow | `.claude/skills/icp-review.md` |
| `morning-brief` | New | `.claude/skills/morning-brief.md` |
| `process-transcript` | New | `.claude/skills/process-transcript.md` |
| `export-deliverable` | New | `.claude/skills/export-deliverable.md` |

### How They Were Adapted

**Path references updated.** The original SCRIPT.md files referenced `@company-context/`, `@gtm-context/`, and `data/clients/`. These were mapped to the revloop-solo folder structure:
- `@company-context/` to `60-Context/` (ICP, personas, offerings, brand voice)
- `@gtm-context/` to `60-Context/strategy/` and `90-System/templates/`
- `data/clients/` to `80-Pipeline/prospects/`, `80-Pipeline/deals/` (entity-level folders)
- `data/transcripts/` to `70-Meetings/`

**Coaching scripts converted to execution skills.** The originals were coaching dialogues with STOP/WAIT patterns for a teaching environment. The adapted skills are execution-oriented: they describe what to do, what to read, what to produce, and where to save it. They still ask clarifying questions, but they don't teach the process.

**Entity-level isolation enforced.** Every skill includes the rule: "Read the entity's context.md before writing any output for that entity." This prevents cross-contamination between prospects and ensures all output lands in the correct entity folder.

**Operator voice rules embedded.** All client-facing skills reference `60-Context/brand-voice.md` and enforce the operator's voice rules. The `my-voice` agent can be invoked directly for voice review.

**Agents specific to individual operators removed.** The template ships with generic agent roles (`researcher`, `sales-coach`, `my-voice`, `deal-researcher`). Operator-specific persona agents are created during onboarding via `/capture-voice`.

### New Additions

**deal-researcher agent:** Uses available research tools (web search, optional LinkedIn/Clay CLIs) to produce comprehensive research briefs written to entity folders.

**morning-brief skill:** Checks email (Gmail MCP), calendar, and pipeline state to produce a daily brief. Surfaces meetings needing prep, overdue actions, and quick wins.

**process-transcript skill:** Takes raw meeting transcripts and extracts structured summaries, action items, buyer signals, and key quotes. Saves to `70-Meetings/` and updates entity context.

**export-deliverable skill:** Cleans markdown for client delivery by stripping frontmatter, converting wiki-links, removing internal references, and verifying voice compliance. Saves to `Deliverables/`.

## Consequences

- All GTM workflows are invocable as Claude Code skills within this repo
- Entity-level isolation means every skill reads context before writing, reducing errors
- Skills produce output in predictable locations, making the vault a single source of truth for sales activity
- The operator voice agent can be invoked by any skill or directly for voice review
- The tool stack is modular — operators add only the CLI tools they use (none required by default)
