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
| founder-voice | Writes and reviews content in the founder's authentic voice | Emails, LinkedIn posts, proposals, any external-facing copy |

## Hooks

| Hook | Trigger | What It Does |
|------|---------|-------------|
| pre-tool.sh | Every tool call | Locks session to vault, initializes .session/ |
| write-gate.sh | Write/Edit calls | Enforces required sources and entity context loading |
| post-read.sh | Read calls | Tracks loaded files for write gate validation |
