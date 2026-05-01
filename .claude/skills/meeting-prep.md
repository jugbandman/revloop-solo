# /meeting-prep

Prepare for an upcoming meeting. Calendar-aware, vault-aware, with configurable research depth.

Reads the calendar invite, checks if you've met with attendees before, lets you pick who to research, and produces a prep brief with positioning context.

## Depth Modes

| Mode | Time | What You Get | When to Use |
|------|------|-------------|-------------|
| **Quick** | 2-5 min | Vault context only, no web research | Recurring meetings, internal calls, people you know well |
| **Standard** | 10-15 min | Vault + targeted web research on key attendees | First meetings, discovery calls, important follow-ups |
| **Deep** | 20-30 min | Full company + contact research, competitive context, positioning | Enterprise prospects, exec-level meetings, high-stakes deals |

Default: **Standard**. User can specify: `/meeting-prep quick` or `/meeting-prep deep`

---

## Phase 0: Identify the Meeting

### If calendar MCP is available:
- Pull today's meetings (or specify a date/time)
- Show the list, let the user pick which meeting to prep for
- Extract: meeting title, attendees (names + emails), description/agenda, any attached links

### If no calendar MCP:
- Ask the user: "Who are you meeting with? What's the meeting about?"
- Accept: company name, attendee names, meeting type, any context

---

## Phase 1: Vault Scan (All Modes)

Check the vault for existing context on every attendee and their company.

**For each attendee:**
1. Search `20-People/` (or `o-20-People/`) for existing entity files by name
2. Search `70-Meetings/` (or `o-transcripts/`) for past meetings mentioning their name
3. Search `80-Pipeline/` (or `c-gtm/80-Pipeline/`) for their company in prospects/deals
4. Search for any entity `context.md` related to their company

**Produce a context map:**

| Attendee | In Vault? | Past Meetings | Entity | Notes |
|----------|-----------|---------------|--------|-------|
| {name} | Yes/No | {count, most recent date} | {link or "none"} | {role if known} |

**Ask the user (AskUserQuestion):**
"Here's who I found in the vault. Which attendees should I research further?"
- Show the context map
- Let them select specific people (multiSelect)
- Option: "Research all new contacts" / "Skip research, just pull vault context"

---

## Phase 2: Company Research (Standard + Deep)

For the company being met with (skip if Quick mode):

**Standard depth:**
- WebSearch: company name + "about" / "news" / "leadership"
- WebFetch: company website about page
- Summarize: what they do, size, stage, recent news

**Deep depth (adds):**
- WebSearch: company + "funding" / "investors" / "competitors"
- WebSearch: company + "hiring" (job postings signal priorities)
- WebFetch: 2-3 recent news articles or press releases
- WebSearch: company + industry trends
- Synthesize: competitive landscape, strategic priorities, trigger events

---

## Phase 3: Attendee Research (Standard + Deep, Selected Contacts Only)

For each selected attendee:

**Standard depth:**
- WebSearch: "{name}" + "{company}" + "LinkedIn"
- WebSearch: "{name}" + recent activity (talks, posts, articles)
- Summarize: role, background, conversation hooks

**Deep depth (adds):**
- WebFetch: LinkedIn profile page (if public)
- WebSearch: "{name}" + conference talks, podcast appearances
- WebSearch: "{name}" + published articles or thought leadership
- Synthesize: career trajectory, priorities, communication style, what they care about publicly

**Model guidance for deep mode:**
- Use faster/cheaper calls for web fetches (data gathering)
- Use full reasoning for synthesis and positioning (the thinking work)
- Rate-limit web requests (2 second delay between fetches)

---

## Phase 4: Positioning Context (All Modes)

Read vault context to frame the meeting:

1. Read `60-Context/icp.md` (or `c-60-Context/icp.md`) — does this company fit?
2. Read `60-Context/offerings.md` (or `c-60-Context/offerings.md`) — what's relevant to discuss?
3. Read `60-Context/positioning.md` (or `c-60-Context/positioning.md`) — how do we differentiate?
4. If entity exists: read their `context.md` for deal history, past conversations, pain points

**Produce:**
- ICP fit assessment (if enough data)
- Which offerings/problems are most relevant to this meeting
- What we know about their pain points (from past meetings or research)
- Suggested talking points based on the intersection of their needs and our positioning

---

## Phase 5: Prep Brief Output

Write the prep brief as a structured document:

```markdown
# Meeting Prep: {Company} — {Meeting Type}
## {Date}, {Time}

### Attendees
| Name | Title | History | Key Context |
|------|-------|---------|-------------|
| {name} | {title} | {# past meetings, last date} | {conversation hook or key detail} |

### Meeting Context
{What this meeting is about, based on invite + vault context}

### What We Know
{Summary of past interactions, deal stage, pain points identified}

### Company Intel
{Overview, recent news, strategic priorities} (Standard/Deep only)

### Positioning for This Meeting
- **Most relevant offering:** {which problem we solve for them}
- **Key differentiator to emphasize:** {why us}
- **Pain point to explore:** {based on research or past conversations}

### Suggested Questions
1. {Discovery question based on what we don't know yet}
2. {Question that tests a pain point hypothesis}
3. {Question about decision process or timeline}

### Watch For
- {Signal to listen for}
- {Risk to be aware of}

### Preparation Checklist
- [ ] Review past meeting notes: {links}
- [ ] Have {offering/demo/material} ready
- [ ] Follow up on: {open action items from last meeting}
```

### Save Location
- Save to `70-Meetings/` (or `c-workspace/`) as `YYYY-MM-DD-{company}-prep.md`
- If new contacts were researched, create/update people files
- If company research was done, update entity `context.md`

---

## After the Meeting

Suggest: "Meeting done? Run `/process-transcript` to capture notes and action items, or use the `meeting-followup` template."
