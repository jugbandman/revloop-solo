# /wip

Save or resume work-in-progress sessions across conversation boundaries.

**Token strategy:** Pause mode uses Sonnet to distill context into a resume prompt (compression step). Resume mode reads one small file. List mode uses Haiku.

Commands:
- `/wip` or `/wip pause` — save current state
- `/wip list` — show active WIP items
- `/wip resume` — pick up where you left off

## Pause Mode

### 1. Orient (inline, lightweight)
- Run `git diff --stat` for changed files list (not contents)
- Run `git status --short` for current state
- Note what was being worked on from the diff summary

### 2. Commit Current State (inline)
- `git add -A`
- `git commit -m "WIP: pause {summary}"`
- Push if remote configured

### 3. Generate Re-entry File with Sonnet

Spawn ONE Sonnet agent (model: "sonnet"):
```
You are creating a WIP re-entry file for someone who will resume this work in a fresh session with zero prior context.

Here is what changed this session:
{paste git diff --stat output}

Here is the current git status:
{paste git status output}

Check .claude/plans/ for any plan files modified today. If found, note the path.

Write a file in this exact format:

---
project: RevLoop
phase: {infer from changed files}
paused: {current datetime YYYY-MM-DD HH:MM}
plan: {path to plan file if found, else omit}
---

## What Was Done
- {bullet list inferred from diff stat}

## In Progress
- {anything partially complete based on file patterns}

## Files Touched
- {list from diff stat, just paths}

## Next Actions
1. {specific next step}
2. {following step}

## Resume Prompt

You are resuming work on {task}. This is a RevLoop vault.

**Current state:** {1-2 sentences on what's done vs remaining}

**Read these files first:**
1. {most important file to re-read}
2. {second file}
3. {plan file if exists}

**Decisions already made:**
- {key decision and why, inferred from changes}

**Do not re-investigate:** {things already resolved}

**Next step:** {the exact thing to do first}

---

The Resume Prompt section is the most important part. Write it as if briefing a colleague who just sat down. Be specific about file paths and next actions.
```

Write the agent's output to `00-Inbox/scratch/wip/YYYY-MM-DD-{slug}.md`.

### 4. Report (inline)
Show: WIP saved, file location, next actions preview (3 lines max).

## List Mode

Spawn Haiku agent (model: "haiku"):
```
Scan 00-Inbox/scratch/wip/ for .md files. For each, read only the frontmatter and the "Next Actions" section (first 3 lines).
Return as table: date | phase | next_action | days_since_paused
Flag: 7+ days = "stale", 30+ days = "abandoned?"
```
Print the table.

## Resume Mode

### 1. List WIP items
If no argument, run List Mode first and let user pick.

### 2. Read re-entry file (inline, one small file)
Read the selected WIP file. It's designed to be small.

### 3. Present Resume Prompt
If the file has a "Resume Prompt" section, show it as the orientation brief.
If a plan file is referenced, read that too (one more file).
If no Resume Prompt (old format), show "Next Actions" and "Re-entry instructions".

### 4. Confirm and begin
Ask user to confirm, then execute the first next action.
