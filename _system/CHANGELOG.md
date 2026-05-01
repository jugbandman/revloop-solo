# Changelog

## 2026-05-01 — CS overlay + SLA-driven daily planning

- Added `customer-success` persona to CLAUDE.md and USER.md.example
- Added `_personas/` directory with overlay manifests (founder stub, sales-leader documents current defaults, customer-success new)
- Added "Sensitive Data Routing" section to CLAUDE.md (route-to-openai for regulated data)
- Added "Obsidian as Primary Surface" section to CLAUDE.md (with Obsidian CLI commands)
- Added top-level `workflows/` directory with MOC and template
- Added `_bin/` and `_reports/` directories
- Added `_reports/` Dataview rollup stubs (customer action items, customer health, weekly touches)
- Added `_templates/`: daily-planning, meeting-note, customer (replaces prospect-style with folder-shaped scaffold), action-item, weekly-review
- Added `playbooks/sla-guide.md` — doctrine for priority tiers, due dates, follow-up cadences, today.md flow
- Added 6 new `_available/skills/`: cs-customer-profile, cs-followup, cs-call-prep (deprecated redirect), customer-call-prep (multi-level), account-research (multi-level, job-sniper-patterned), cs-calendar-block
- Added `_available/dashboards/workflow-health/` scaffolding (README, spec, sample-output)
- Expanded folder map in CLAUDE.md

## v0.2.0 — 2026-04-17

- Self-onboarding state machine via `.revloop/onboarding.json`
- Milestone skills: `/start`, `/capture-voice`, `/capture-business`, `/connect-transcripts`
- `_available/` inspiration gallery (opt-in skills, enrichment, automation, dashboard)
- `DESKTOP-GUIDE.md` for Claude Desktop cowork path
- Graceful three-surface degradation (Claude Code / Claude Desktop / plain editor)
- Hooks hardened with env guards; `write-gate.sh` simplified to vault-level only
- System docs library: `DEPENDENCIES.md`, `OBSIDIAN-DEPS.md`, `CREDENTIAL-SETUP.md`, `self-onboarding-architecture.md`, `milestone-skill-contract.md`, `fork-this-vault.md`, `scheduled-jobs.md`
- Architecture decisions: ADR-001 through ADR-004
