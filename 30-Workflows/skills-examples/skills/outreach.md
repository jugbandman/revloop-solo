# Outreach Sequence Creation

Create personalized outbound email sequences and LinkedIn message flows for a target prospect or segment.

## Prerequisites

- Read the entity's `context.md` before writing any output for that entity
- Read `60-Context/brand-voice.md` for the founder's voice rules
- Read `60-Context/icp.md` and `60-Context/personas.md` for targeting alignment

## Tool Stack

- **clay-gtm-cli**: Enrich prospect data (company info, signals, tech stack)
- **heyreach-cli**: Queue LinkedIn connection requests and message sequences
- **linkedincli**: Research prospect LinkedIn profiles and activity

## Workflow

### 1. Identify Target

Ask the user:
- Who are you targeting? (Segment, company, or specific person)
- Cold outbound or warm/known contacts?
- Goal: discovery calls, demos, or something else?

### 2. Research the Prospect

If a specific prospect or company is named:
1. Check if `80-Pipeline/prospects/{company}/context.md` or `80-Pipeline/deals/{company}/context.md` exists. Read it.
2. Use `linkedincli` to pull recent activity, role history, and mutual connections
3. Use `clay-gtm-cli` to enrich company data (size, funding, tech stack, signals)
4. Save research to the entity folder as `research-brief.md`

### 3. Create Email Sequence

Draft a 3-5 touch email sequence following the founder's voice (see CLIENT.md):

**Touch 1 (Day 1), Initial Outreach:**
- Specific observation about something they did (shows homework)
- Connect to pattern the founder sees from their expertise
- One curious question (genuine, not rhetorical)
- Soft ask

**Touch 2 (Day 4), Add Value:**
- Reference first email briefly
- Share an insight, resource, or relevant case study
- Soft CTA

**Touch 3 (Day 8), Different Angle:**
- Social proof or a different entry point
- Clear value framing
- Direct but not pushy CTA

**Touch 4 (Day 12), Final Attempt:**
- Acknowledge they're busy
- One clear value statement
- Easy yes/no ask

**Touch 5 (Day 16), Breakup (optional):**
- Respectful close
- Leave door open
- Sign-off (from CLIENT.md)

### 4. Create LinkedIn Flows

For warm/known contacts, draft LinkedIn message flows:
- **Warm contact** (you've met): Reconnection + value
- **Mutual connection**: Reference the connection + value prop
- **Light-warm** (same industry/role): Common ground hook

Keep LinkedIn messages under 300 characters. Conversational, not salesy.

### 5. Save Output

Save the sequence to the entity's folder:
- `80-Pipeline/prospects/{company}/outreach-sequence-YYYY-MM-DD.md`
- Or `80-Pipeline/deals/{company}/outreach-sequence-YYYY-MM-DD.md`

Include personalization placeholders so the user can customize per-prospect.

## Voice Rules (Non-Negotiable)

- Sign off every email with the configured sign-off (see CLIENT.md)
- No em-dashes or double dashes, use commas
- No "Hope this finds you well," "I wanted to reach out," "Worth 15 minutes?"
- Short paragraphs (3 sentences max)
- Warm but professional, consultative not salesy
- Reference specific details, never generic

## Success Criteria

- Complete outbound email sequence (3-5 touches) saved to entity folder
- LinkedIn message flows if applicable
- Personalization placeholders included
- All content passes the founder's voice rules (see CLIENT.md)
