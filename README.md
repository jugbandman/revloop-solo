# RevLoop Solo

A daily operating system for solo sales operators. Clone, run `/get-started`, start working.

Built on [Obsidian](https://obsidian.md) + [Claude Code](https://claude.ai/code).

## Quick Start

```bash
# 1. Clone this repo
git clone https://github.com/jugbandman/revloop-solo.git my-vault
cd my-vault

# 2. Open in your editor (VSCode, VSCodium, etc.)
code .

# 3. Run Claude Code and start onboarding
claude /get-started
```

`/get-started` will:
- Ask your name, role, company, and working style
- Create your `USER.md` identity file
- Help you connect calendar, email, transcripts, and CRM (all optional, all skippable)
- Create your first `today.md`
- Show you what to do tomorrow morning

Run `/get-started` again anytime to see what features you haven't tried yet.

## What's Inside

| Folder | Purpose |
|--------|---------|
| `++HOME/` | Navigation hub and recent work tracker |
| `context/` | Your company info, ICP, brand voice |
| `pipeline/` | Prospects, deals, closed |
| `people/` | Contacts and stakeholders |
| `meetings/` | Meeting notes and transcripts |
| `playbooks/` | Your sales process and frameworks |
| `scratch/` | Brain dumps, quick captures |
| `_imports/` | Drop zone (put files here, Claude routes them) |

## Daily Workflow

**Morning (5 min):** Run `/today` or `/morning-brief` to see priorities.

**During the day:** Use skills as needed:
- `/process-transcript` after meetings
- `/icp-review` to refine targeting
- Drop files in `_imports/` for processing

**End of day (2 min):** Run `/wrap` to verify, commit, and push.

## Skills

| Skill | What It Does |
|-------|-------------|
| `/get-started` | Progressive onboarding (run anytime) |
| `/today` | Daily priorities from vault state |
| `/morning-brief` | Email + calendar + pipeline check |
| `/icp-review` | Build or refine ICP |
| `/process-transcript` | Extract summary + action items from transcripts |
| `/export-deliverable` | Clean markdown for delivery |
| `/sync-gh` | Git sync (commit, pull, push) |
| `/wrap` | End-of-task closure |
| `/wip` | Save/resume work-in-progress |

## Requirements

- [Obsidian](https://obsidian.md) (free, for viewing and navigating your vault)
- [Claude Code](https://claude.ai/code) (Claude Pro $20/mo or Max $100/mo)
- [Git](https://git-scm.com) + GitHub account (for backup)
- A code editor (VSCode, VSCodium, etc.)

## Personas

RevLoop Solo adapts to your working style. Pick your persona during `/get-started`:

- **Founder** — Strategy, fundraising, hiring, product
- **Sales Leader** — Team performance, process, forecasting
- **Sales Manager** — Deal coaching, rep development
- **AE** — Deal execution, prospecting, pipeline

## Support

Questions? Reach Andy at andy@remixrevenue.co or 312-203-1656.

Built by [Remix Revenue](https://remixrevenue.co).
