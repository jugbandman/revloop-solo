---
name: capture-business
description: Business context milestone. Captures positioning, offerings, ICP via short interview OR paste-a-deck shortcut. Writes to context/.
---

# /capture-business

Populate `context/positioning.md`, `context/offerings.md`, `context/icp.md`, `context/competitors.md` so downstream outbound copy has a real business to anchor against.

## Flow

1. **Offer two paths.**
   - **Interview (default).** AskUserQuestion sequence:
     - What do you sell?
     - Who do you sell to? (role, company size, industry)
     - What's the single hardest problem your customer has that you solve?
     - Who do you lose to most often?
     - Pricing range (rough) per offering?
   - **Paste shortcut.** User drops a deck, one-pager, website URL, or a block of text describing the business. Skill parses and fills.
2. **Write four files.**
   - `context/positioning.md` — statement, mission, differentiators.
   - `context/offerings.md` — table with offering / problem / when-to-reference / price range.
   - `context/icp.md` — primary + secondary with firmographics, pain points, red flags.
   - `context/competitors.md` — name, positioning, when-they-win, when-we-win.
   Preserve existing content — merge, don't overwrite. Flag conflicts for the user.
3. **Gap detection.** Reuse the pattern from `/import-context`: list which fields are still `{add value}` and prompt the user to fill one.
4. **Flip milestone.** `milestones.business_context.done = true`, `at = <today>`.

## Skip

Push `business_context` into `skipped[]`. Outbound copy skills will warn when they run without business context.
