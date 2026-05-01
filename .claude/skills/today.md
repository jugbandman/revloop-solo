# /today

Generate daily priorities from vault state. Scoped strictly to this vault.

## Steps

### 1. Load Context
- Read USER.md (or _me/USER.md in team mode) for identity and persona
- Read 90-System/system-docs/vault-health-report.md for any overdue automations
- If team mode: read 90-System/system-docs/contributors.md, identify current user via git user.name

### 2. Scan Pipeline
- Check 80-Pipeline/ (or c-gtm/80-Pipeline/) for active deals and prospects
- Check each entity's frontmatter for: stage, next-step, next-step-date, last-updated
- Flag entities with overdue next steps
- Flag entities not updated in 7+ days (stale)

### 3. Check Meetings
- Scan 70-Meetings/ (or o-transcripts/) for recent meetings that may need follow-up
- Check for unprocessed transcripts in 00-Inbox/

### 4. Check Deliverables
- Scan 00-Inbox/scratch/ (or c-workspace/) for draft deliverables that need finishing
- Check for recently created items that may need follow-up

### 5. Check Automation Health
- Read 90-System/system-docs/vault-health-report.md automation status table
- Flag any automations that should have run but show old dates

### 6. Generate Priority List
Output a prioritized task list using WSJF-style thinking (urgency x impact):

**Priority 1: Revenue-critical** (deals at risk, overdue follow-ups)
**Priority 2: Pipeline momentum** (outreach due, prospects to advance)
**Priority 3: Operations** (stale data, automation gaps, vault health)

Format as actionable items with the skill or action needed:
- "Follow up with [prospect] (overdue 3 days) > /outreach or write follow-up"
- "Process transcript in 00-Inbox/ > /process-transcript"
- "Update [deal] stage (last touched 10 days ago) > read context.md"

### 7. Optional Calendar Check
If Google Calendar MCP is configured, also check:
- Meetings today that need prep
- Follow-ups due from recent meetings

### Output
Present as a clean priority list the user can work through. No fluff, just actionable items with context.
