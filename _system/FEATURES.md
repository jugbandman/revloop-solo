# RevLoop Features

## Getting Started

This vault ships with skills (manual commands) and agents. Start with `/get-started` to initialize your identity and context.

## Skills (Claude Code)

| Skill | What It Does | How to Invoke |
|-------|-------------|---------------|
| /get-started | Progressive onboarding (run anytime for what's next) | `claude /get-started` |
| /today | Daily priorities from vault state | `claude /today` |
| /morning-brief | Email + calendar + pipeline check | `claude /morning-brief` |
| /icp-review | Build or refine ICP and buyer personas | `claude /icp-review` |
| /process-transcript | Extract summary and action items from transcript | `claude /process-transcript` |
| /export-deliverable | Clean markdown for delivery (strip wiki-links, frontmatter) | `claude /export-deliverable` |
| /sync-gh | Git sync (commit, pull, push, handle divergence) | `claude /sync-gh` |
| /wrap | End-of-task closure (verify indexes, commit) | `claude /wrap` |
| /wip | Save/resume work-in-progress sessions | `claude /wip` |

## Agents (Claude Code)

| Agent | What It Does | When to Use |
|-------|-------------|-------------|
| my-voice | Writes and reviews content in YOUR authentic voice | Your emails, LinkedIn, proposals, any content that should sound like you |
| client-voice | Writes content in the CLIENT's voice (team mode only) | Outbound on behalf of the client in managed deployments |
| researcher | Deep company and contact research briefs | Pre-outreach, discovery prep, deal qualification |
| sales-coach | Reviews business cases, deal strategy, champion-selling content | Deal reviews, pipeline strategy, messaging quality |

## Templates (_templates/)

| Template | What It's For |
|----------|--------------|
| 60-second-deal-review | Structured deal review: 3 headlines, buyer actions, health scores |
| 1-page-business-case | Champion-ready business case: problem, approach, payoff, investment |
| half-page-business-case | Compressed executive briefing version of the business case |
| mutual-action-plan | Shared timeline with buyer: milestones, decision criteria, stakeholders |
| executive-summary | One-page forwardable summary for executive decision-making |
| meeting-followup | Post-meeting notes: takeaways, action items, follow-up email draft |
| lead | Raw lead entity |
| prospect | Enriched prospect entity with ICP fit and outreach history |
| deal | Active deal with stakeholders, timeline, deliverables |
| daily-brief | Daily priorities and pipeline snapshot |
| transcript | Meeting transcript with summary and action items |
| outreach-batch | Campaign sequence with messaging and results tracking |

## Hooks

| Hook | Trigger | What It Does |
|------|---------|-------------|
| pre-tool.sh | Every tool call | Locks session to vault, initializes .session/ |
| write-gate.sh | Write/Edit calls | Enforces required sources and entity context loading |
| post-read.sh | Read calls | Tracks loaded files for write gate validation |
