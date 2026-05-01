---
type: customer-template
---

Customer entity scaffold. Each customer is a directory at 10-Customers/<customer-name>/ with a profile, transcripts, emails, slack-saves, and action-items file. This template documents the folder shape and the per-file frontmatter.

# Customer Entity Scaffold

Each customer is a directory at `10-Customers/<customer-name>/` with this shape:

```
10-Customers/<customer-name>/
├── profile.md              # Source of truth: status, key contacts, themes, open FRs, risks, next meeting
├── transcripts/            # Gong pastes, processed transcripts (one .md per call)
├── emails/                 # Saved customer emails (paste or drag-in)
├── slack-saves/            # Saved Slack threads/messages
└── action-items.md         # Frontmatter-tagged items; drives Dataview rollups
```

## profile.md template (place at 10-Customers/<customer-name>/profile.md)

````markdown
---
type: customer-profile
customer: <customer-name>
status: active | at-risk | churned | onboarding
last_contact: YYYY-MM-DD
next_meeting: YYYY-MM-DD
risk: low | medium | high
arr: 
contract_end: YYYY-MM-DD
---

# <Customer Name>

## Key Contacts

## Themes
<Recurring topics, what they care about>

## Open Feature Requests
<Linear FRs they've asked for>

## Risks
<Churn signals, dissatisfaction, evaluations of competitors>

## Recent Touches
<Auto-merged from transcripts and emails>

## Adoption Signals
<Product usage, expansion signals>
````

## action-items.md template (place at 10-Customers/<customer-name>/action-items.md)

````markdown
---
type: customer-action-items
customer: <customer-name>
---

# <Customer Name> — Action Items

- [ ] <item> | priority: P1 | due: 2026-05-08 | assignee: me | status: open
- [ ] <item> | priority: P0 | due: 2026-05-02 | assignee: me | status: open

(Each line uses inline-field syntax so Dataview reads them.)
````
