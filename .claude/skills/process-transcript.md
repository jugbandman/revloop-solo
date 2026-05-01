# Process Transcript

Take a meeting transcript, extract a structured summary with action items, and save to the meetings folder.

## Prerequisites

- Read the entity's `context.md` before writing any output for that entity (if the meeting is tied to a known prospect or deal)

## Workflow

### 1. Receive the Transcript

Accept the transcript from:
- A file path (check 70-Meetings/ or 00-Inbox/ or user-provided path)
- Pasted text from the user
- A file dropped into 00-Inbox/

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
- `70-Meetings/YYYY-MM-DD-{company}-{meeting-type}.md`

If tied to an entity, check whether the entity folder exists:

**Entity folder exists:**
- Update `context.md` with new insights from this meeting
- For any new contacts not yet in the folder, create `{firstname-lastname}.md` using `90-System/templates/prospect.md`, populated with what is known from the transcript
- Link the transcript note from the entity's `context.md`

**Entity folder does not exist:**
- Determine correct stage from context (leads vs. prospects vs. deals)
- Create the entity folder under the appropriate pipeline stage
- Create `context.md` using `90-System/templates/context.md`, populating company info, source (transcript), pain points, and initial signals from the transcript
- Create `{firstname-lastname}.md` for each contact on the call using `90-System/templates/prospect.md`
- Link the transcript from the new `context.md`

**People file rules:**
- Person files live inside the entity subfolder, not in a separate directory
- File naming: `{firstname-lastname}.md` in lowercase-kebab-case
- Leave enrichment fields as `{add value}` placeholders — do not fabricate

### 6. Suggest Next Actions

Based on the transcript:
- Recommend next skill to run (e.g., follow-up email, proposal draft)
- Flag any time-sensitive follow-ups
- Note if entity context needs updating
