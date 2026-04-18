# DESKTOP-GUIDE.md

You're using RevLoop Solo via **Claude Desktop cowork** (not Claude Code). This guide shows you how to drive the full onboarding flow without slash commands or hooks.

## What works in Claude Desktop cowork

- Reading files across the whole vault folder
- Writing files Claude drafts (you approve)
- Running multi-step agentic work
- All the markdown-based workflows (templates, milestone skills, agents read as prose)

## What doesn't work (and the fallback)

| Claude Code feature | Desktop fallback |
|---|---|
| Slash commands (`/start`, `/capture-voice`, etc.) | Paste the starter prompt below; Claude reads the skill files as prose and follows them |
| Hooks (automatic write-gate enforcement) | CLAUDE.md's Sacred Sources checklist — Claude reads the 4 files before writes |
| `/sync-gh` automation | Run `git` commands yourself, or skip Git entirely |
| Env-aware model routing (Opus/Sonnet per skill) | Claude Desktop uses one model per session; pick Opus for deeper reasoning milestones |

## Starter prompt — paste this into Claude Desktop after opening the vault folder

```
You're helping me onboard into RevLoop Solo. Before anything else:

1. Read README.md and CLAUDE.md in this folder.
2. Check .revloop/onboarding.json — if it doesn't exist, create it with level 0 and all milestones done:false (schema is in .revloop/onboarding.json.example).
3. Confirm which milestone I'm on, then walk me through it.

For every milestone skill you run (capture-voice, capture-business, connect-transcripts, etc.):
- Read the skill file at .claude/skills/{name}.md first — it's the playbook.
- Before writing to context/*.md, meetings/, or pipeline/, confirm you've read USER.md, context/positioning.md, context/icp.md, context/brand-voice.md. This is the Sacred Sources gate described in CLAUDE.md.
- After the milestone completes, update .revloop/onboarding.json (flip the done flag, update last_updated_at).

Always show me the next action before taking it. Never block on setup I haven't done yet — offer me "skip" for any milestone.

What milestone am I on, and what's the first thing you need from me?
```

## How the milestone flow plays in Desktop

1. **First run:** Claude creates `.revloop/onboarding.json` at level 0 and asks the 4 identity questions (name, role, company, email). Writes `USER.md`. Advances to level 1.
2. **Voice calibration:** Claude asks you to paste writing samples. Analyzes. Writes `context/brand-voice.md`. Level 2.
3. **Business context:** Interview or paste-a-deck. Writes `context/positioning.md`, `offerings.md`, `icp.md`, `competitors.md`. Level 3.
4. **Transcripts:** Claude asks how you record calls. Documents the paste-to-inbox flow (or helps you set up a local filesystem MCP for Granola if you run one in Desktop). Level 4.
5. **First prospect:** Claude asks for one company to research. Runs `deal-researcher`-style flow manually. Writes to `pipeline/prospects/{company}/`. Level 5.
6. **Knowledge:** Claude offers gap-detection against `knowledge/frameworks/`, suggests what to import. Level 6.

## Daily work in Desktop

Once onboarded, your daily flow:

- **Morning:** paste *"Give me today's priorities. Read USER.md, CLAUDE.md, ++HOME/Recent Work.md, and my pipeline. List what moved, what's stale, what I should focus on."*
- **Meeting prep:** paste *"I have a call with {name} at {company}. Read pipeline/{deals|prospects}/{slug}/context.md and any meetings/ with them. Give me a 5-minute prep."*
- **After a meeting:** paste *"Here's a transcript [paste]. Extract summary, action items, update the entity context.md, log in Recent Work."*
- **End of day:** paste *"Wrap this session. Verify I updated every entity I touched, log Recent Work, suggest what to commit if I use git."*

## Sacred Sources — the gate

Before Claude Desktop writes anything to `pipeline/`, `meetings/`, `playbooks/`, or outbound copy, it should have read this session:

- [ ] `USER.md` (operator identity)
- [ ] `context/positioning.md`
- [ ] `context/icp.md`
- [ ] `context/brand-voice.md`

Claude Code enforces this with `.claude/hooks/write-gate.sh`. Desktop doesn't run hooks, so you (or the starter prompt above) enforce it by having Claude confirm these reads before acting. The starter prompt covers this.

## When Desktop feels too manual

If you find yourself pasting the starter prompt every session, consider moving to Claude Code (adds slash commands + automatic hook enforcement). The vault itself is identical either way.

## When things go sideways

- **Claude Desktop didn't read CLAUDE.md** → start over with *"Before doing anything else, read CLAUDE.md and confirm you've done so."*
- **Claude wrote to the wrong entity folder** → ask it to read `.claude/agents/deal-researcher.md` for the entity-isolation rule before continuing
- **Onboarding state feels out of sync** → ask Claude to `cat .revloop/onboarding.json`, verify level matches what's actually in the vault, and correct if needed

## Next read

`CLAUDE.md` for the canonical protocol, `_system/self-onboarding-architecture.md` for why the system is designed this way, `_system/fork-this-vault.md` if you want to use this as a starting point for your own template.
