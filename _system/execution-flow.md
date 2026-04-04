---
type: system
domain: execution-flow
updated: {{date}}
---
# Execution Flow

The end-to-end pipeline from lead sourcing to active deal tracking.

```
Lead Sources → Import → leads/ → Enrich → prospects/ → Outreach → MANUAL APPROVAL → Send
```

## Step by Step

1. **Source leads** — From CRM exports, LinkedIn, manual research, or integrations
2. **Import** — Drop CSVs in `_imports/` or use import scripts. Leads land in pipeline as markdown files
3. **Enrich** — Research and qualify leads. Add firmographic data, pain points, connection hooks
4. **Promote to prospects/** — Enriched leads get a subfolder with context.md containing research
5. **Generate outreach** — Use vault context to write personalized copy. `/outreach` skill or manual
6. **Manual approval gate** — ALL outbound copy goes through human review before sending
7. **Execute** — Send via email, LinkedIn, or other channels
8. **Track** — Responses update prospect context files. Meetings go to meetings/

## Two Copy Modes

- **Volume:** External tools (Clay, HeyReach) for batch outbound
- **Depth:** Claude Code for vault-aware, deeply personalized copy

The volume path handles scale. The depth path handles important prospects.
