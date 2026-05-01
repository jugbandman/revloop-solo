Customer success overlay tunes the template for CS managers handling post-close customer health, adoption, expansion, and churn defense. Activates the customers/ scaffold, CS-specific skills, and SLA-driven planning.

# Customer Success Overlay

For CS managers and customer-facing operators handling post-close customer health, adoption, expansion, and churn defense.

## Activation steps

1. Create directories:
   - `mkdir customers/`
2. Promote skills from `_available/skills/` into `.claude/skills/`:
   - `cs-customer-profile.md`
   - `cs-followup.md`
   - `customer-call-prep.md`
   - `account-research.md`
   - `cs-calendar-block.md`
3. Set USER.md preferences:
   - `transcript tool: gong` (or her actual tool)
   - `sensitive-data: route-to-openai: true` if her data is regulated
4. Do NOT promote (sales-only):
   - `_available/skills/{outreach, prospect-research, proposal-draft}.md`
5. Disable in CLAUDE.md (or just don't follow):
   - sales-coach agent auto-loading on revenue templates (the CS variant uses a future cs-coach agent)

## Sacred sources for this persona
- USER.md
- context/positioning.md (your company)
- context/brand-voice.md
- context/tool-stack.md (your CS tools)
- The customer's `customers/<name>/profile.md` when working on a specific customer

## What this overlay enables
- Customer entity scaffold (transcripts, emails, slack-saves, action-items)
- SLA-driven action item triage (`playbooks/sla-guide.md`)
- Multi-level call prep and account research
- Calendar follow-up blocking
