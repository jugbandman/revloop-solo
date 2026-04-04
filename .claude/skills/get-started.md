# /get-started

Progressive onboarding advisor. Run anytime. Detects vault state and adapts.

Not a one-time wizard. A living guide that knows your maturity level and surfaces what to try next.

## Mode Detection

Before anything else, detect the vault mode:

1. Check if `USER.md` exists at root → solo mode candidate
2. Check if `_me/USER.md` exists → team mode candidate
3. Check if `CLIENT.md` exists at root → team mode confirmed
4. Check if `.onboarding` exists → returning user, read it for state
5. None of the above → **fresh vault, first run**

---

## First Run (No USER.md Found)

### Step 1: Identity

Use AskUserQuestion to collect:

**Question 1:** "What's your name?"
(Free text)

**Question 2:** "What's your role?"
Options: Founder, Head of Sales / Sales Leader, Sales Manager, Account Executive (AE)
(Maps to persona: founder, sales-leader, sales-manager, ae)

**Question 3:** "What's your company name?"
(Free text)

**Question 4:** "What's your email?"
(Free text)

### Step 2: Mode

Use AskUserQuestion:

**Question:** "How will you use this vault?"
- **Just me (solo)** — Everything commits to git. You are the company. Simple.
- **Team / managed deployment** — Personal data is private, shared data commits. Multiple operators.

### Step 3: Create Identity Files

**Solo mode:**
- Create `USER.md` at root with collected data
- Set `mode: solo` and `persona: {selected}`
- Fill in autonomy defaults based on persona
- Fill in preferences with sensible defaults (planning-style: daily, capture-method: keyboard)

**Team mode:**
- Create `_me/` directory
- Create `_me/USER.md` with collected data (gitignored)
- Create `CLIENT.md` at root from CLIENT.md.example (with placeholders, prompt to fill in)
- Create `_system/contributors.md` with first contributor entry
- Update `.gitignore` to ignore `_me/`, `today.md`, context files

### Step 4: Context Import (All Skippable)

Use AskUserQuestion:

**Question:** "Want to import some context now? (All optional, you can always run /get-started again later)"
- **Paste my LinkedIn URL** — Scrape and add to USER.md
- **Paste my company URL** — Scrape and create context/positioning.md
- **I'll drop files in _imports/ later** — Point to the drop zone
- **Skip for now** — Move on

If they paste a URL, use WebFetch to scrape and populate the relevant file.

For team mode, also ask:
- "Got a pitch deck or brand guide?" — Drop in _imports/, Claude routes to context/
- "Have existing playbooks?" — Drop in _imports/, Claude routes to playbooks/

### Step 5: Connections (All Skippable)

Use AskUserQuestion:

**Question:** "Want to connect any tools? (All optional, skip anything)"
- **Google Calendar** — Guide MCP setup for calendar integration
- **Gmail / Email** — Guide MCP setup for email integration
- **Transcript tool (Granola, Fireflies, Gong)** — Guide MCP or import setup
- **CRM (HubSpot, Attio, Salesforce)** — Guide connection or CSV import
- **Skip all** — Move on

For each selected connection, provide step-by-step setup instructions. Update USER.md preferences with what was connected.

### Step 6: First Today

- Create `today.md` (at root for solo, in `_me/` for team)
- Run a lightweight version of the /today skill to populate it
- Show the user their first daily priorities

### Step 7: Save State

Write `.onboarding` JSON:
```json
{
  "started": "YYYY-MM-DD",
  "persona": "{selected}",
  "mode": "{solo|team}",
  "level": 1,
  "completed": ["identity", "first-today"],
  "skipped": [],
  "connections": {},
  "last_run": "YYYY-MM-DD"
}
```

Update completed/skipped based on what they did.

### Step 8: Welcome

Tell them:
- "You're set. Here's what to do tomorrow morning: run `/today` or `/morning-brief`."
- "Drop files in `_imports/` anytime and I'll route them."
- "Run `/get-started` again whenever you want to see what's next."

---

## Subsequent Runs (USER.md Exists)

### Step 1: Load State

- Read USER.md (or _me/USER.md)
- Read .onboarding for level and history
- Scan vault state: count files in each folder, check what's connected

### Step 2: Assess Level

Check progression milestones:

| Level | Check | Milestone |
|-------|-------|-----------|
| 1 → 2 | context/ has at least 1 file AND people/ has 5+ files | Context established |
| 2 → 3 | context/icp.md exists AND pipeline/deals/ has 1+ entity | Pipeline active |
| 3 → 4 | .onboarding.connections has 2+ tools AND meetings/ has 5+ files | Flow established |
| 4 → 5 | Custom skills exist OR autonomous runs configured | System maturity |

Update level if milestones are met.

### Step 3: Surface Recommendations

Based on current level and what's NOT yet done, suggest 2-3 next steps:

**Level 1 (Foundation):**
- "You haven't set up any context files. Paste your company URL or drop a pitch deck in _imports/."
- "Try `/today` to see your daily priorities."

**Level 2 (Context):**
- "You have {N} people files. Try tracking a prospect in pipeline/prospects/."
- "Run `/icp-review` to define your ideal customer."
- "Connect your calendar for meeting-aware planning."

**Level 3 (Pipeline):**
- "You have {N} deals. Want to try weekly forecast summaries?"
- "Connect a transcript tool to auto-process meeting notes."
- "Your pipeline has deals that haven't been updated in 7+ days."

**Level 4 (Flow):**
- "You could automate your morning brief with a cron job."
- "Try creating a custom skill for a workflow you repeat."
- "Set up autonomous overnight research runs."

### Step 4: Check _imports/

- Scan `_imports/` for unprocessed files
- If files found, offer to route them:
  - Transcripts (audio, .md with meeting content) → meetings/
  - CSVs → pipeline/ (offer to import as leads or prospects)
  - PDFs/docs → context/ or playbooks/

### Step 5: Check for Stale Items

- Any entities not updated in 14+ days?
- Any context .example files not yet customized?
- Any health.md items still "Not configured" that are now available?

### Step 6: Update State

Write updated `.onboarding` with new level, completed items, and last_run date.

### Step 7: Report

Present a clean summary:
```
## Your RevLoop Status

**Level:** {N} ({name})
**Mode:** {solo|team}
**Vault:** {X} people, {Y} prospects, {Z} deals, {W} meetings

### What to Try Next
1. {recommendation with skill or action}
2. {recommendation}
3. {recommendation}

### _imports/ ({N} files waiting)
- {file} → suggested destination

Run /get-started anytime to check in again.
```
