# /get-started

Progressive onboarding advisor. Run anytime. Detects vault state and adapts.

**Token strategy:** Mode detection and routing are lightweight (inline). Heavy scanning delegates to Haiku. Maturity assessment uses Sonnet.

## Mode Detection (inline)

1. Check if `USER.md` exists at root → solo mode
2. Check if `_me/USER.md` exists → team mode
3. Check if `.onboarding` exists → returning user
4. None → fresh vault, first run

---

## First Run (No USER.md Found)

Run inline. This is conversational, not scan-heavy.

### Step 1: Identity

Collect via AskUserQuestion:
- Name (free text)
- Role: Founder, Head of Sales, Sales Manager, AE
- Company name (free text)
- Email (free text)

### Step 2: Mode

"How will you use this vault?"
- **Just me (solo)** — You are the company. Simple.
- **Team / managed** — Personal data private, shared data commits.

### Step 3: Create Identity Files

**Solo:** Create `USER.md` at root with collected data, mode: solo, persona mapped from role.

**Team:** Create `_me/USER.md` (gitignored), `CLIENT.md` from example, `_system/contributors.md`. Update `.gitignore`.

### Step 4: Context Import (skippable)

"Want to import context now?"
- Paste LinkedIn URL → scrape to USER.md
- Paste company URL → scrape to context/positioning.md
- Drop files in _imports/ later
- Skip

### Step 5: Connections (skippable)

"Want to connect tools?"
- Google Calendar, Gmail, Transcript tool, CRM, Skip all
- Guide MCP setup for each selected

### Step 6: First Today

Create today.md, run lightweight /today to populate.

### Step 7: Save State

Write `.onboarding` JSON with started date, persona, mode, level 1, completed/skipped arrays.

### Step 8: Welcome

"You're set. Tomorrow run `/today` or `/morning-brief`. Drop files in `_imports/` anytime. Run `/get-started` again to see what's next."

---

## Subsequent Runs (USER.md Exists)

### Step 1: Quick State Load (inline)

Read only `.onboarding` (small JSON). Do NOT scan the vault yet.

### Step 2: Router Menu

Present via AskUserQuestion:

"What do you want to do?"
1. **Get stuff done** — Daily priorities and task work
2. **Work on a deal or client** — Pick from pipeline
3. **Internal project** — Playbooks, context, knowledge
4. **Check vault health** — Full diagnostic
5. **Improve the vault** — Import context, detect gaps
6. **Automate a task** — Cron jobs, scheduled runs
7. **Learn to use the vault** — Maturity level and recommendations

### Step 3: Route

**Option 1: Get stuff done**
Run `/today` (which has its own efficiency pattern).

**Option 2: Work on a deal or client**
Spawn Haiku agent (model: "haiku"):
```
List all subfolders in pipeline/prospects/ and pipeline/deals/.
For each, read context.md frontmatter for: name, status, updated.
Return as table: name | type | status | last_updated | days_since_update
Sort by most recently updated first.
```
Present the table, let user pick. Then read ONLY that entity's context.md.

**Option 3: Internal project**
Spawn Haiku agent (model: "haiku"):
```
Check these folders for content (non-example, non-index files):
playbooks/, knowledge/, context/ (or c-context/), _templates/
Return: folder | file_count | empty_or_populated
Also list any .example files in context/ that don't have a corresponding non-example version.
```
Present gaps, suggest what to build.

**Option 4: Check vault health**
Invoke `/vault-review` (delegates to its own agent team).

**Option 5: Improve the vault**
Invoke `/import-context` in gap-detection mode.

**Option 6: Automate a task**
Read `_system/health.md` (small file, inline). Show automation status. Suggest cron setups.

**Option 7: Learn to use the vault**
Spawn Sonnet agent (model: "sonnet"):
```
Assess this vault's maturity. Read these files:
- USER.md (or _me/USER.md)
- .onboarding
- _system/health.md

Then count (using Glob, not reading contents):
- Files in context/ (or c-context/)
- Subfolders in people/
- Subfolders in pipeline/deals/
- Files in meetings/
- .onboarding.connections entries

Apply these progression rules:
Level 1→2: context/ has 1+ file AND people/ has 5+ entries
Level 2→3: context/icp.md exists AND pipeline/deals/ has 1+ entity
Level 3→4: connections has 2+ tools AND meetings/ has 5+ files
Level 4→5: custom skills exist OR autonomous runs configured

Return:
- Current level and name
- Counts for each metric
- 2-3 specific recommendations for what to try next based on level
- Any stale .onboarding items
```
Present the Sonnet agent's assessment. Update `.onboarding` level if changed.
