# Skills — Install Guide

Each file here is a Claude skill. Install any skill by moving it into your active skills directory:

```bash
mv 30-Workflows/skills-examples/skills/{skill-name}.md .claude/skills/{skill-name}.md
```

Claude loads `.claude/skills/` automatically. Once moved, invoke a skill by name (e.g., `/account-plan acme-corp-discovery`).

## Available Skills

| Skill | File | What it does |
|-------|------|--------------|
| `/account-plan` | `account-plan.md` | Draft or refresh a full enterprise account plan from deal folder context, transcripts, and positioning docs. Idempotent — safe to re-run as new context lands. Pinned to Opus. |
| `/review-actions` | `review-actions.md` | Weekly cleanup of `++Home/action-items.md`. Archives completed items, flags stale ones, surfaces patterns, and runs vault health diagnostics as a bonus. |
| `/discovery-prep` | `discovery-prep.md` | Prepare for a discovery call: research the prospect, score ICP fit, draft tailored questions and objection responses, output a one-page call outline. |
| `/outreach` | `outreach.md` | Create a 3-5 touch email sequence and LinkedIn message flows for a target prospect or segment. Uses the founder's voice rules from CLIENT.md. |
| `/proposal-draft` | `proposal-draft.md` | Draft a customized proposal from discovery insights. Structures the offer, applies investment language and founder voice, drafts the cover email, and defines the follow-up plan. Pinned to Opus. |
| `/prospect-research` | `prospect-research.md` | Identify, qualify, and prioritize prospects against ICP criteria. Builds enriched prospect folders and a prioritized list with recommended next actions. |

## Notes

Skills that are pinned to Opus (account-plan, proposal-draft) use the `model: claude-opus-4-7` frontmatter. This increases quality for high-stakes artifacts at a higher token cost. Remove the pin if you prefer Sonnet for cost reasons.

Skills reference paths like `80-Pipeline/deals/{slug}/` and `60-Context/icp.md`. These match the revloop-solo vault structure. If your folder names differ, do a search-and-replace in the skill file before installing.
