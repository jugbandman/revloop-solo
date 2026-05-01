# RevLoop Features

Catalog of skills, agents, templates, and hooks shipped with this vault.

## Getting Started

This vault ships with skills (manual commands) and agents. Start with `/start` to initialize identity and context.

## Skills (Claude Code)

| Skill | What It Does | How to Invoke |
|-------|-------------|---------------|
| /start | Continuous onboarding router. Picks the next milestone. | `claude /start` |
| /capture-voice | Voice calibration milestone, writes 60-Context/brand-voice.md | `claude /capture-voice` |
| /capture-business | Business context milestone, writes 60-Context/{positioning,offerings,icp,competitors}.md | `claude /capture-business` |
| /connect-transcripts | Wires Granola or paste-to-inbox flow for meetings | `claude /connect-transcripts` |
| /get-started | Progressive onboarding (run anytime for what's next) | `claude /get-started` |
| /today | Daily priorities from vault state | `claude /today` |
| /morning-brief | Email + calendar + pipeline check | `claude /morning-brief` |
| /meeting-prep | Calendar-aware meeting prep (quick/standard/deep research) | `claude /meeting-prep` |
| /icp-review | Build or refine ICP and buyer personas | `claude /icp-review` |
| /process-transcript | Extract summary and action items from transcript | `claude /process-transcript` |
| /transcript-sync | Pull new transcripts and hand off to /process-transcript | `claude /transcript-sync` |
| /export-deliverable | Clean markdown for delivery (strip wiki-links, frontmatter) | `claude /export-deliverable` |
| /import-context | Import materials, set up continuous data flows, detect vault gaps | `claude /import-context` |
| /sync-gh | Git sync with tidy check (commit, pull, push, handle divergence) | `claude /sync-gh` |
| /wrap | End-of-task closure (verify indexes, commit) | `claude /wrap` |
| /wip | Save/resume work-in-progress with resume prompts | `claude /wip` |
| /vault-review | Comprehensive vault health diagnostic (stale entities, broken links, drift) | `claude /vault-review` |

## Agents (Claude Code)

| Agent | What It Does | When to Use |
|-------|-------------|-------------|
| my-voice | Writes and reviews content in YOUR authentic voice | Your emails, LinkedIn, proposals, any content that should sound like you |
| researcher | Deep company and contact research briefs | Pre-outreach, discovery prep, deal qualification |
| sales-coach | Reviews business cases, deal strategy, champion-selling content | Deal reviews, pipeline strategy, messaging quality |
| deal-researcher | Deal-specific research with pipeline context | Deal prep with transcript history and pipeline grounding |

## Templates (90-System/templates/)

| Template | What It's For |
|----------|--------------|
| action-item | Single action item with sla-aware frontmatter |
| customer | Customer entity scaffold (folder-shaped: profile + transcripts + emails + slack-saves + action-items) |
| daily-brief | Daily priorities and pipeline snapshot |
| daily-planning | today.md template (Top 3, MoSCoW, customer touches, SLA-fed) |
| meeting-followup | Post-meeting notes with action items and follow-up draft |
| meeting-note | Frontmatter-tagged meeting notes feeding Dataview |
| mutual-action-plan | Shared timeline with buyer/customer |
| transcript | Meeting transcript with summary and action items |
| weekly-review | Friday EOD template (customers touched, decisions, blockers, draft Slack post) |

## Hooks

| Hook | Trigger | What It Does |
|------|---------|-------------|
| pre-tool.sh | Every tool call | Locks session to vault, initializes .session/ |
| write-gate.sh | Write/Edit calls | Enforces required sources from ROOT-INDEX.md before writes |
| post-read.sh | Read calls | Tracks loaded files for write gate validation |
