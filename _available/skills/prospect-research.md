# Prospect Research

Identify, qualify, and prioritize prospects based on ICP criteria. Build targeted prospect lists with enriched data.

## Prerequisites

- Read the entity's `context.md` before writing any output for that entity
- Read `context/icp.md` and `context/personas.md` for targeting criteria

## Tool Stack

- **clay-gtm-cli**: Enrich companies and contacts (firmographics, signals, tech stack)
- **linkedincli**: Research LinkedIn profiles, activity, mutual connections
- **heyreach-cli**: Queue connection requests for prioritized prospects

## Workflow

### 1. Review Current Pipeline

Check existing pipeline state:
- Read `pipeline/deals/` for active deals
- Read `pipeline/prospects/` for prospects already being tracked
- Read `pipeline/leads/` for inbound leads not yet qualified

Ask the user:
- Do you have existing contacts/relationships to review?
- Any current pipeline or deals in progress?
- What market hypotheses do you have?

### 2. Identify Target Segment

Based on `context/icp.md`, confirm the target segment:
- Company size, stage, industry
- Buyer personas (titles, roles)
- Geographic focus
- "Why now" triggers to look for

Refine with the user if needed.

### 3. Build Prospect List

For each prospect company:
1. Use `clay-gtm-cli` to enrich company data (size, funding, tech stack, signals)
2. Use `linkedincli` to find contacts matching buyer personas
3. Check for buying signals (hiring patterns, recent announcements, tech adoption)

Create or update the prospect folder:
- `pipeline/prospects/{company}/context.md` with company profile, contacts, signals, and ICP fit score

### 4. Qualify Each Prospect

Score against three dimensions:

**Fit (Does the company match ICP?):**
- Company size/stage
- Industry alignment
- Role matches buyer persona

**Urgency (Do they have a pressing need?):**
- Recent initiatives or announcements
- Hiring in relevant areas
- Competitive pressure signals

**Ability to Act (Can they decide and purchase?):**
- Decision maker identified
- Budget signals
- Reasonable timeline

### 5. Prioritize

Rank prospects:
- **High Priority**: Strong fit + urgency + ability to act. Reach out immediately.
- **Medium Priority**: Good fit, some urgency or ability. Add to nurture sequence.
- **Low Priority**: Fit but no clear urgency. Revisit in 3-6 months.

### 6. Save Output

Save the prioritized list to `scratch/prospect-list-YYYY-MM-DD.md` with:
- Company name and key contacts
- ICP fit score
- Key signals
- Priority tier
- Recommended next action

Update each entity's `pipeline/prospects/{company}/context.md` with enrichment data.

### 7. Next Steps

- High priority: Run `/outreach` to create sequences
- Medium priority: Queue LinkedIn connections via `heyreach-cli`
- Low priority: Note in prospect folder for future revisit

## Voice Rules

- Research docs are internal, direct language is fine
- Any prospect-facing output follows your voice (no em-dashes, warm, professional, see `context/brand-voice.md`)

## Success Criteria

- Target segment confirmed
- Prospect list built with enrichment data
- Each prospect qualified against ICP
- Prioritized list saved to scratch
- Entity folders created/updated for each prospect
