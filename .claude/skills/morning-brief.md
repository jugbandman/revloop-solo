# Morning Brief

Check email, calendar, and pipeline state to produce a daily brief.

## Prerequisites

- Gmail MCP must be available for email access
- Google Calendar MCP must be available for calendar access
- Read context files (ICP, positioning) to contextualize pipeline items

## Workflow

### 1. Check Email

Use the Gmail MCP to pull recent emails (last 24 hours):
- Flag emails from prospects, clients, or partners
- Identify action-required items
- Note any inbound leads or meeting requests
- Summarize important threads

### 2. Check Calendar

Use the Google Calendar MCP to pull today's schedule:
- List all meetings with attendees and context
- For each meeting, check if there's a related entity folder in the pipeline
- Flag any meetings that need prep
- Note gaps for deep work or outreach

### 3. Check Pipeline State

Scan the active pipeline:
- Check deal folders for status and next actions
- Check prospect folders for those needing follow-up
- Identify any entities with overdue action items

### 4. Check Deliverables

Scan workspace/scratch for pending deliverables:
- Draft proposals awaiting review
- Content awaiting approval
- Anything with a deadline approaching

### 5. Produce the Brief

Write the daily brief (overwrite previous):

```
# Daily Brief, YYYY-MM-DD

## Today's Schedule
- [Time] Meeting with [who] re: [topic] → [prep needed?]

## Email Highlights
- [From]: [Subject] → [Action needed]

## Pipeline Updates
- **Active Deals**: [count] deals, [summary of movement]
- **Needs Attention**: [deals with overdue actions]
- **New Leads**: [any inbound leads]

## Action Items for Today
1. [Highest priority action]
2. [Next priority]

## Upcoming This Week
- [Key meetings, deadlines, follow-ups]
```

### 6. Surface Recommendations

Based on the brief, suggest:
- Which meetings need prep
- Which prospects need follow-up
- Any deals at risk of stalling
- Quick wins available today

## Voice Rules

- Daily brief is internal, direct and concise
- No filler, no em-dashes
- Action items should be specific and time-bound
