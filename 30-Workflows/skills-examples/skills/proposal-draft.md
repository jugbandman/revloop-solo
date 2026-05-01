---
model: claude-opus-4-7
---

# Proposal Drafting

Create a customized proposal based on discovery insights. Structure the offer, draft the document, and plan the follow-up.

**Model pin:** Opus. Proposals are client-facing, high-stakes artifacts. Quality over cost.

## Prerequisites

- Read the entity's `context.md` before writing any output for that entity
- Read `60-Context/brand-voice.md` for the founder's voice rules (see CLIENT.md)
- Read `60-Context/offerings.md` for available products/services
- Read `90-System/templates/proposal-template.md` if it exists

## Workflow

### 1. Gather Discovery Insights

Ask the user:
- Who is this proposal for? (Company, contact, decision makers)
- What did you learn from discovery? (Pain points, goals, needs)
- What solution are you proposing? (Scope, deliverables)
- Any specific requirements or constraints?
- What's their decision timeline?

Check the entity folder for prior context:
- `80-Pipeline/deals/{company}/context.md` for relationship history
- `80-Pipeline/deals/{company}/debrief-*.md` for call notes
- `70-Meetings/` for relevant meeting transcripts

### 2. Structure the Proposal

Build the proposal following this structure:

**Executive Summary:**
- Their situation (mirror their language)
- Proposed solution (framed as extending what they already have)
- Expected outcomes (specific, measurable)

**Understanding Their Needs:**
- Challenges (from discovery, using their words)
- Goals
- Success criteria

**Proposed Solution:**
- What's included (deliverables, not features)
- Timeline
- Approach

**Why Us:**
- Pattern recognition (what we're seeing across the market)
- Relevant experience
- Differentiation (not a feature list, a perspective difference)

**Investment:**
- Use "investment" language, never "cost" or "pricing"
- "Sample investment profile"
- "Scaled up or down" not "cheaper/more expensive"
- Include value/ROI framing

**Next Steps:**
- Clear, easy path forward
- Soft timeline

### 3. Apply the Founder's Voice

The proposal should read like the founder wrote it:
- Mirror-then-extend pattern (restate their situation, connect to broader pattern, bridge to solution)
- Short paragraphs
- Warm but professional
- No em-dashes, no generic filler
- Configured sign-off on the cover email (see CLIENT.md)

### 4. Save Output

Save the proposal to:
- `80-Pipeline/deals/{company}/proposal-YYYY-MM-DD.md`
- Update `80-Pipeline/deals/{company}/context.md` with proposal status

### 5. Draft Cover Email

Write a follow-up email to accompany the proposal:
- Reference the conversation
- Frame the proposal as "the shape of our thinking"
- Soft next step
- Configured sign-off

### 6. Follow-Up Plan

Outline the follow-up cadence:
- Send proposal within 24 hours of the call
- Check in after 3-5 days if no response
- Schedule discussion call if they want to review together
- Yes path and no path clearly defined

## Voice Rules (Non-Negotiable)

- All proposal content follows the founder's voice
- Investment language only (never cost/pricing)
- Mirror-then-extend pattern for positioning
- No em-dashes, no SDR phrases, no assumptive closes
- Configured sign-off on all correspondence

## Success Criteria

- Proposal addresses specific discovery insights (not generic)
- Investment framing used throughout
- Founder's voice is authentic
- Proposal saved to entity folder
- Cover email drafted
- Follow-up plan defined
