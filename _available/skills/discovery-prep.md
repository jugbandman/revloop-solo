# Discovery Call Preparation

Prepare for a discovery call by gathering context, preparing tailored questions, identifying objections, and creating a call outline.

## Prerequisites

- Read the entity's `context.md` before writing any output for that entity
- Read `context/icp.md` and `context/personas.md` for qualification criteria
- Read `context/brand-voice.md` for your voice rules

## Tool Stack

- **linkedincli**: Research the prospect's LinkedIn profile, activity, and connections
- **clay-gtm-cli**: Enrich company data (funding, tech stack, signals, news)

## Workflow

### 1. Gather Prospect Context

Ask the user:
- Company name
- Who you're meeting with (name, title, role)
- How you got connected (referral, outbound, inbound)
- Any background you already know

### 2. Research and Enrich

1. Check if entity folder exists: `pipeline/prospects/{company}/` or `pipeline/deals/{company}/`
2. If `context.md` exists, read it for prior interactions
3. Check `meetings/` for any previous call notes with this company
4. Use `linkedincli` to pull the contact's profile, recent posts, mutual connections
5. Use `clay-gtm-cli` to enrich company data if not already captured

### 3. Evaluate ICP Fit

Score the prospect against ICP criteria:
- **Fit**: Company size/stage, industry, role matches buyer persona
- **Urgency**: Signs of pressing need, "why now" triggers
- **Ability to Act**: Decision maker or influencer, budget signals, timeline

Present the fit assessment clearly.

### 4. Prepare Discovery Questions

Draft tailored questions organized by phase:

**Opening (5 min), Build Rapport:**
- Role/responsibilities
- Current priorities

**Pain Point Discovery (15 min):**
- Specific pain points from ICP alignment
- Impact of current challenges
- What they've tried before

**Qualification (5 min):**
- Fit confirmation
- Urgency and "why now"
- Decision process, budget, timeline

**Decision Process (5 min):**
- Who else is involved
- Timeline for decision
- Decision criteria

**Next Steps (5 min):**
- What success looks like
- Proposed next steps

### 5. Identify Objections

Based on the prospect's profile, competitive landscape, and `context/competitive.md` (if exists):
- List likely objections
- Prepare response frameworks for each
- Note any specific concerns from prior interactions

### 6. Create Call Outline

Write a one-page call outline the user can reference during the call:
- Opening line and rapport hook
- Key questions (organized by topic)
- Signals to listen for
- Talking points and differentiation
- Objection responses
- Proposed next steps (yes path and no path)

### 7. Save Output

Save the call prep to the entity's folder:
- `pipeline/prospects/{company}/call-prep-YYYY-MM-DD.md` or `pipeline/deals/{company}/call-prep-YYYY-MM-DD.md`

## Voice Rules

- All client-facing content follows your voice (warm, consultative, no em-dashes, see `context/brand-voice.md`)
- Call prep docs can be more direct/internal, but still professional

## Success Criteria

- Prospect context gathered and synthesized
- ICP fit assessed
- Tailored discovery questions prepared
- Objections identified with response frameworks
- Call outline saved to entity folder
- User feels confident and prepared
