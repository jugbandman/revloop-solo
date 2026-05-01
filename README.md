# RevLoop Solo

A daily operating system for solo sales operators. Built to interview you, capture your voice, wire your workflows, and persist state across every session — across whichever AI surface you use.

## Three ways in

Pick whichever matches your setup. All three get you to the same place.

### 1. Claude Code (full power)

Hooks + slash commands + agentic flows. Best fidelity.

```bash
git clone https://github.com/jugbandman/revloop-solo.git my-vault
cd my-vault
claude
# In Claude: /start
```

### 2. Claude Desktop cowork (recommended if you don't run a terminal)

Desktop reads your vault directly. No hooks or slash commands, but the guided milestone flow still works via conversation.

```bash
git clone https://github.com/jugbandman/revloop-solo.git my-vault
```

Then open `my-vault/` in Claude Desktop (use the cowork / agent feature) and paste the starter prompt from [`DESKTOP-GUIDE.md`](./DESKTOP-GUIDE.md). Desktop will read `README.md` + `CLAUDE.md` and walk you through the current milestone.

### 3. Plain editor (any editor, any AI)

Open the cloned folder in Obsidian, VS Code, Cursor, or any markdown editor. Read `CLAUDE.md` for the operating protocol. Your favorite AI (GPT, Gemini, local model) can be your copilot by starting every session with *"Read CLAUDE.md first, then help me with..."*

No Claude Code, no Claude Desktop, no Obsidian required. Just markdown that any capable AI (or human) can navigate.

## What `/start` does

The first time you run it:
- Asks your name, role, company (4 questions)
- Creates your `USER.md` identity file
- Walks you through voice calibration (`/capture-voice`) so AI can write in your voice
- Walks you through business context (`/capture-business`) — positioning, offerings, ICP, competitors
- Walks you through transcript setup (`/connect-transcripts`) — Granola, Fathom, Otter, Fireflies, or paste
- Advances to tracking a first deal and curating knowledge

State persists in `.revloop/onboarding.json` (local, gitignored). Every session picks up where you left off. Skip anything. Nothing blocks.

Run `/start` again anytime to see your next milestone.

## What's inside

| Folder | Purpose |
|--------|---------|
| `++HOME/` | Navigation hub and recent work tracker |
| `00-Inbox/` | Drop zone (put files here, Claude routes them) plus daily scratch |
| `10-Customers/` | Customer entities (CS persona overlay) |
| `20-People/` | Contacts and stakeholders |
| `30-Workflows/` | Workflow doctrine and opt-in skills examples |
| `40-Playbooks/` | Your sales process and frameworks |
| `50-Knowledge/` | Reference material (MEDDIC, SCQA, articles) |
| `60-Context/` | Your positioning, ICP, brand voice, offerings, competitors |
| `70-Meetings/` | Meeting notes and transcripts |
| `80-Pipeline/` | Prospects, deals, closed |
| `80-Projects/` | Big-work scaffolding (AI Advisor pattern) |
| `90-System/` | Vault self-awareness, personas, scripts, system-docs, templates |
| `900-Bin/` | Archive for inactive content |
| `999-Reports/` | Auto-generated Dataview rollups |

## Daily workflow

- **Morning (5 min):** `/today` or `/morning-brief` for priorities, calendar, pipeline check
- **During the day:** `/meeting-prep` before calls, `/process-transcript` after, `/wip` when switching context
- **End of day (2 min):** `/wrap` to verify links, update Recent Work, commit if you use git

## Skills (the core catalog)

| Skill | What it does |
|-------|-------------|
| `/start` | Continuous onboarding router. Picks the next milestone. |
| `/capture-voice` | Calibrates your authentic voice from writing samples |
| `/capture-business` | Populates positioning, offerings, ICP, competitors |
| `/connect-transcripts` | Wires Granola or paste-to-inbox for meetings |
| `/today` | Daily priorities from vault state |
| `/morning-brief` | Email + calendar + pipeline check |
| `/meeting-prep` | Calendar-aware meeting prep (quick/standard/deep) |
| `/process-transcript` | Summary + action items from a transcript |
| `/icp-review` | Build or refine ICP |
| `/import-context` | Detect gaps, bulk-import, wire ongoing data flows |
| `/vault-review` | Health diagnostic |
| `/sync-gh` | Git sync (optional) |
| `/wrap` | End-of-task closure |
| `/wip` | Save/resume work-in-progress |

More live in `30-Workflows/skills-examples/skills/`. Move one into `.claude/skills/` to enable it.

## Agents

- **`my-voice`** — Writes and reviews in your authentic voice
- **`researcher`** — Deep company and contact research
- **`sales-coach`** — Reviews business cases, deal strategy, champion-selling
- **`deal-researcher`** — Deal-specific research with pipeline context

## What's *not* required

- **GitHub** — clone or download the ZIP. No remote required for the vault to work.
- **Claude Code** — Claude Desktop cowork or any other AI + a markdown editor is a valid path. See [DESKTOP-GUIDE.md](./DESKTOP-GUIDE.md).
- **Obsidian** — VS Code, Cursor, or plain vim all work. Obsidian CLI and plugins are optional enhancers documented in `90-System/system-docs/OBSIDIAN-DEPS.md`.
- **API keys** — MCP servers (Gmail, Granola, Calendar) are all optional. See `90-System/system-docs/CREDENTIAL-SETUP.md` to wire the ones you want.

## Personas

RevLoop Solo adapts to your role. Pick yours during `/start`:

- **Founder** — strategy, fundraise, hiring, product
- **Sales Leader** — team performance, process, forecasting
- **Sales Manager** — deal coaching, rep development
- **AE** — deal execution, prospecting, pipeline

CLAUDE.md routes tone and priorities based on your persona.

## What's possible (grow into)

Solo ships lean. As you need more, enable features from `30-Workflows/skills-examples/`:

- **Clay-style enrichment** (`30-Workflows/skills-examples/enrichment/`) batch-enrich prospects via Clay, LinkedIn, HeyReach
- **n8n automations** (`30-Workflows/skills-examples/automation/`) wire vault events to workflows
- **React dashboard** (`30-Workflows/skills-examples/dashboard/`) visualize pipeline over your markdown
- **Opt-in skills** (`30-Workflows/skills-examples/skills/`) `account-plan`, `outreach`, `prospect-research`, `proposal-draft`, `discovery-prep`, `review-actions`

## Support

Questions? Reach Andy at andy@remixrevenue.co.

Built by [Remix Revenue](https://remixrevenue.co).

---

**Under the hood:** See [`90-System/system-docs/self-onboarding-architecture.md`](./90-System/system-docs/self-onboarding-architecture.md) for why this template works the way it does.
