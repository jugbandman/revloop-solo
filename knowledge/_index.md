# Knowledge Base

Reference material you've collected. Frameworks, articles, posts, and guidance from external sources that inform how you sell.

## Categories

### frameworks/
Sales methodologies and mental models. The theoretical foundations.
- MEDDIC, Challenger, SPIN, value selling, gap selling
- Negotiation frameworks, objection handling models
- Business case structures, ROI frameworks

*Ships with:* MEDDIC cheat sheet, SCQA structure, discovery question bank

### prospecting/
Outbound tactics, research methods, and ICP frameworks.
- LinkedIn outreach strategies
- Cold email frameworks and templates
- Account-based selling approaches
- Signal-based prospecting methods

### deal-execution/
Guides for moving deals from discovery to close.
- Negotiation tactics and counter-objection strategies
- Proposal and pricing frameworks
- Closing techniques and timeline management
- Multi-threading and stakeholder mapping

### coaching/
Rep development and sales leadership.
- 1:1 meeting frameworks
- Performance coaching models
- Deal review structures
- Onboarding checklists for new reps

### articles/
Saved articles and blog posts worth referencing.
- Name files with date prefix: `YYYY-MM-DD-title.md`
- Include the source URL at the top
- Pull out key takeaways you want to remember

### posts/
LinkedIn posts, social content, and threads worth keeping.
- Same date prefix: `YYYY-MM-DD-author-topic.md`
- Good for outreach inspiration, messaging patterns, thought leadership examples

## How to Populate

**Quick:** Drop files in `_imports/` and run `/import-context`. It will route them to the right category.

**Manual:** Save directly to the relevant folder. Any markdown file works.

**Continuous:** Run `/import-context setup` to configure automatic imports from email, RSS, or other sources.

## How This Gets Used

The **sales-coach** agent reads `knowledge/frameworks/` and `playbooks/` when coaching you on deals, business cases, and messaging. The more context you give it, the better the coaching.

The **/meeting-prep** skill checks `knowledge/` for relevant frameworks when building your prep brief.
