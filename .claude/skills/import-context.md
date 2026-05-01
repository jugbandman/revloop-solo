# /import-context

Import context into the vault. One-time bulk imports, continuous import setup, and gap detection.

Run anytime. Reads vault state and knows what's missing.

---

## Three Modes

### `/import-context` (default)
Scans the vault, identifies gaps, and recommends what to import next. Like `/get-started` but focused on context and data enrichment.

### `/import-context bulk`
Walks through a one-time import of materials you already have (CRM exports, pitch decks, playbooks, brand guides, transcripts).

### `/import-context setup`
Configures continuous import workflows (watched folders, cron jobs, MCP connections for ongoing data flow).

---

## Mode 1: Gap Detection (Default)

### Step 1: Scan Vault State

Check what exists and what's missing:

**Identity layer:**
- [ ] USER.md filled in (not just placeholders)
- [ ] 60-Context/positioning.md exists and has real content
- [ ] 60-Context/icp.md exists and has real content
- [ ] 60-Context/brand-voice.md exists and has real content
- [ ] 60-Context/offerings.md exists and has real content
- [ ] 60-Context/competitors.md exists (nice-to-have)
- [ ] 60-Context/tool-stack.md exists (nice-to-have)

**Pipeline health:**
- [ ] 80-Pipeline/prospects/ has at least 1 entity with context.md
- [ ] 80-Pipeline/deals/ has at least 1 entity (if applicable)
- [ ] 20-People/ has at least 5 contact files

**Operational health:**
- [ ] 70-Meetings/ has transcripts or notes
- [ ] 40-Playbooks/ has at least 1 playbook
- [ ] 00-Inbox/ has pending files to process

**Connections:**
- [ ] Calendar MCP configured (check .onboarding or try a test call)
- [ ] Email MCP configured
- [ ] Transcript source configured (Granola, Fireflies, etc.)
- [ ] CRM connected (HubSpot, Attio, Salesforce)

### Step 2: Prioritize Gaps

Rank missing items by impact on vault effectiveness:

**Critical (vault can't function well without these):**
- No positioning.md → outreach and proposals will be generic
- No icp.md → can't qualify prospects or prioritize pipeline
- No brand-voice.md → voice agents can't calibrate

**High (significantly limits value):**
- No people files → meeting prep has no context
- No transcripts → missing institutional memory
- No CRM connection → manual pipeline tracking

**Medium (nice to have):**
- No competitors.md → competitive positioning is guesswork
- No playbooks → no repeatable process documentation
- No tool-stack.md → can't help with tool integration

### Step 3: Present Recommendations

Use AskUserQuestion to offer the top 3 gaps:

"Your vault is missing some context that would make it more effective. Want to fill any of these now?"

For each gap, offer:
- **Quick fix:** "Paste your company URL and I'll draft positioning.md from what I find"
- **Import:** "Drop your pitch deck in 00-Inbox/ and I'll extract positioning"
- **Manual:** "I'll create the file with guided questions"
- **Skip:** "I'll do this later"

### Step 4: Process Any Pending 00-Inbox/

Check `00-Inbox/` for unprocessed files. If found:
- Identify file types (transcript, CSV, PDF, markdown, pitch deck)
- Suggest routing for each:
  - Transcripts → 70-Meetings/ (offer to run /process-transcript)
  - CSVs → 80-Pipeline/ (offer to import as leads/prospects)
  - PDFs/docs → 60-Context/ (offer to summarize and extract)
  - Pitch decks → 60-Context/positioning.md + 60-Context/offerings.md
  - Brand guides → 60-Context/brand-voice.md
  - Playbooks → 40-Playbooks/

---

## Mode 2: Bulk Import (`/import-context bulk`)

### Step 1: What Do You Have?

Use AskUserQuestion (multiSelect):

"What materials do you have to import? Select all that apply."
- **CRM export (CSV)** — contacts, deals, pipeline data
- **Pitch deck / company overview** — positioning, offerings, story
- **Brand guide or style guide** — voice, tone, visual identity
- **Sales playbook or process doc** — methodology, stages, scripts
- **Meeting transcripts** — past conversations, call recordings
- **ICP or persona document** — target customer definition
- **Competitor research** — market landscape, differentiation
- **Contact list** — people you work with or sell to
- **Other documents** — anything else that adds context

### Step 2: For Each Selected Type

Guide the import:

**CRM export:**
1. "Drop the CSV in 00-Inbox/"
2. Read the CSV, identify columns (name, company, email, stage, etc.)
3. Ask which column mapping to use
4. Create lead/prospect files in 80-Pipeline/
5. Report: "{N} contacts imported, {M} companies identified"

**Pitch deck / company overview:**
1. "Drop the file in 00-Inbox/ (PDF, PPTX, or paste the text)"
2. Extract: positioning statement, offerings, key differentiators, company story
3. Create/update: 60-Context/positioning.md, 60-Context/offerings.md
4. Show what was extracted, let user edit

**Brand guide:**
1. "Drop the file or paste key sections"
2. Extract: tone, voice characteristics, do/don't rules, sign-off
3. Create: 60-Context/brand-voice.md
4. Calibrate my-voice agent with the extracted voice

**Sales playbook:**
1. "Drop the file or paste sections"
2. Extract: stages, criteria, scripts, frameworks
3. Create files in 40-Playbooks/
4. Update 90-System/system-docs/FEATURES.md if new processes are documented

**Transcripts:**
1. "Drop transcript files in 00-Inbox/ (or point to a folder)"
2. For each: run /process-transcript to extract summary, action items, entities
3. Route processed transcripts to 70-Meetings/
4. Create/update people files from attendees

**Contact list:**
1. "Drop the CSV or paste names"
2. Create entity files in 20-People/ with available context
3. Link to relevant pipeline entities if company matches exist

### Step 3: Post-Import Summary

Show what was created:
- Files created/updated (with links)
- Gaps remaining
- Suggested next steps ("Run /meeting-prep before your next call" or "Run /icp-review to define your ICP from this data")

---

## Mode 3: Continuous Import Setup (`/import-context setup`)

### Step 1: What Flows Continuously?

Use AskUserQuestion:

"What data do you want flowing into the vault automatically?"
- **Meeting transcripts** (from Granola, Fireflies, Gong, Otter)
- **Calendar events** (daily schedule awareness)
- **Email highlights** (inbox scanning)
- **CRM updates** (deal stage changes, new contacts)
- **Lead lists** (regular CSV drops)

### Step 2: For Each Selected Flow

**Transcripts:**
- **MCP route:** Guide setting up Granola/Fireflies/Gong MCP connection
- **Watched folder route:** "Point your transcript tool's export folder at 00-Inbox/"
  - Create a launchd plist or cron job that runs `/process-transcript` on new files
  - Provide the exact command: `claude -p "Process any new transcripts in 00-Inbox/"`
  - Suggest cadence: every 30 minutes or on-demand
- **Manual route:** "Drop transcripts in 00-Inbox/ whenever. Run /import-context to process them."

**Calendar:**
- Guide Google Calendar MCP setup
- Once connected: `/morning-brief` and `/meeting-prep` become calendar-aware
- No cron needed (MCP is live)

**Email:**
- Guide Gmail MCP setup
- Once connected: `/morning-brief` scans inbox
- Optional: set up a daily cron for `/morning-brief` at 7am

**CRM:**
- Guide HubSpot/Attio/Salesforce MCP or API connection
- Or: set up a weekly CSV export → 00-Inbox/ pipeline
- Suggest: "Start with weekly CSV drops. Automate when the workflow is stable."

**Lead lists:**
- "Drop CSVs in 00-Inbox/ anytime"
- Optional: set up a Google Sheets sync via cron
- Provide command: `claude -p "Import leads from 00-Inbox/*.csv"`

### Step 3: Cron/Automation Setup

For any scheduled imports, provide:
- Exact cron entry or launchd plist
- The Claude Code command to run
- Recommended cadence
- How to verify it's working

Example:
```bash
# Process new transcripts every 30 minutes
*/30 * * * * cd /path/to/vault && claude -p "Check 00-Inbox/ for new transcripts and process them"

# Morning brief at 7am
0 7 * * * cd /path/to/vault && claude /morning-brief
```

### Step 4: Update Vault Config

- Update `.onboarding` with configured connections
- Update `90-System/system-docs/vault-health-report.md` automation status table
- Note: "Run `/import-context` anytime to check for new gaps or pending imports"
