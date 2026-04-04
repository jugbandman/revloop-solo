# Process Transcript

Take a meeting transcript, extract a structured summary with action items, and save to the meetings folder.

## Prerequisites

- Read the entity's `context.md` before writing any output for that entity (if the meeting is tied to a known prospect or deal)

## Workflow

### 1. Receive the Transcript

Accept the transcript from:
- A file path (check meetings/ or _imports/ or user-provided path)
- Pasted text from the user
- A file dropped into _imports/

Ask the user (if not obvious):
- Who was on the call? (Names, titles, companies)
- What type of meeting? (Discovery, follow-up, internal, demo)
- Which entity does this relate to? (Prospect, deal, customer)

### 2. Extract Summary

Produce a structured summary:

**Meeting Metadata:**
- Date
- Attendees (names, roles, companies)
- Meeting type
- Duration (if known)

**Executive Summary:**
2-3 sentences covering what was discussed and the outcome.

**Key Topics Discussed:**
Bullet list of the main subjects covered.

**Key Quotes:**
Pull 3-5 verbatim quotes that capture critical moments, decisions, or signals. Include who said each quote.

**Pain Points / Needs Identified:**
What problems or needs did the prospect/client articulate?

**Decisions Made:**
Any commitments or decisions reached during the call.

### 3. Extract Action Items

Organize action items by owner:

**Our Action Items:**
- [ ] [Action] (owner, deadline if mentioned)

**Their Action Items:**
- [ ] [Action] (owner, deadline if mentioned)

**Shared / TBD:**
- [ ] [Action] (needs assignment)

### 4. Analyze Buyer Signals (If Sales Call)

If this is a sales-related call, analyze:
- Pain intensity (how urgent is their need?)
- Decision process signals (who else is involved, timeline)
- Budget signals (any mentions of investment, budget cycles)
- Champion signals (who is most engaged, advocating internally)
- Competitive signals (other vendors mentioned, existing solutions)

### 5. Save Output

Save the processed transcript to:
- `meetings/YYYY-MM-DD-{company}-{meeting-type}.md`

If tied to an entity, also:
- Update the entity's context.md with new insights
- Link the transcript note from the entity's context

### 6. Suggest Next Actions

Based on the transcript:
- Recommend next skill to run (e.g., follow-up email, proposal draft)
- Flag any time-sensitive follow-ups
- Note if entity context needs updating
