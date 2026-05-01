# /vault-review

Comprehensive vault health diagnostic. Report only, never auto-fixes.

**Token strategy:** Spawn parallel Haiku agents for mechanical scanning, Sonnet agent for synthesis. Main context stays clean.

## Execution

### 1. Detect Mode (inline, no agent needed)

Check for `USER.md` at root (solo) or `_me/USER.md` (team). Set path prefixes:
- Solo: `60-Context/`, `80-Pipeline/`, `20-People/`
- Team: `c-context/`, `80-Pipeline/`, `20-People/`

### 2. Spawn Scan Agents (parallel Haiku)

Launch ALL THREE agents in a single message using `model: "haiku"`:

**Agent A: "vault-link-health"**
```
Check if Obsidian CLI is available (run: pgrep -x Obsidian).
If available, run these 3 commands and return the output:
  Obsidian unresolved
  Obsidian orphans
  Obsidian deadends
For each, return the top 20 results and total count.
Flag: orphans in 80-Pipeline/ or 20-People/ as "PROBLEM".
Skip: orphans in 00-Inbox/, 00-Inbox/scratch/, .session/.
If Obsidian not running, return: "Obsidian CLI not available, skipped."
```

**Agent B: "vault-entity-scan"**
```
Scan these directories and report what you find. Be concise.

1. STALE ENTITIES: List all subfolders in 80-Pipeline/prospects/ and 80-Pipeline/deals/.
   For each, read context.md frontmatter "updated" field.
   Flag any not updated in 14+ days. Return as: name | type | updated | days_stale

2. STALE WIP: List files in 00-Inbox/scratch/wip/. Read frontmatter "paused" date.
   7+ days = "stale", 30+ days = "abandoned". Return as: name | paused | days | status

3. EMPTY FOLDERS: Check for non-example, non-index content in:
   {context_path}/, 40-Playbooks/, 50-Knowledge/, 80-Pipeline/, 20-People/, 70-Meetings/
   Return: folder | status (empty/has_content) | file_count

4. UNPROCESSED IMPORTS: Count and list files in 00-Inbox/ with types.
```

**Agent C: "vault-system-scan"**
```
Run these checks and return results concisely:

1. GIT STATUS: Run git status (short format). Run git log origin/main..HEAD --oneline (if remote exists).
   Return: uncommitted count, unpushed count, or "clean".

2. NAVIGATION: Read ++HOME/++HOME.md frontmatter "updated" field.
   Read ++HOME/Recent Work.md, check if "This Week" table has entries within 7 days.
   Return: fresh/stale for each.

3. HEALTH.MD CROSS-REF: Read 90-System/system-docs/vault-health-report.md.
   Check: Does USER.md exist? Does git remote exist? (git remote -v)
   Flag any rows that say "Not configured" but the component actually exists.
   Return: list of discrepancies or "accurate".
```

### 3. Synthesize with Sonnet

After all 3 Haiku agents return, spawn ONE Sonnet agent:

**Agent: "vault-review-report" (model: "sonnet")**
```
You are writing a vault health report. Here are the scan results from three parallel checks:

LINK HEALTH:
{Agent A results}

ENTITY + FOLDER SCAN:
{Agent B results}

SYSTEM HEALTH:
{Agent C results}

Write a concise terminal report in this format:

## Vault Review - {date}

### Obsidian Link Health
{results or "Skipped"}

### Stale Entities
{table or "All current"}

### Stale WIP
{table or "None"}

### Folder Coverage
{status per folder}

### Unprocessed Imports
{count or "Clean"}

### Navigation
{fresh/stale}

### Git + System
{status + discrepancies}

### Recommended Actions
1-5 prioritized actions with which skill to run for each.

Keep it scannable. No prose paragraphs. Tables and bullets only.
```

### 4. Output Report

Print the Sonnet agent's report directly. Do not add commentary.

## Never

- Do not read entity files or folder contents in the main context
- Do not auto-fix issues
- Do not create report files in the vault
- Do not edit 90-System/system-docs/, 90-System/templates/, or CLAUDE.md
