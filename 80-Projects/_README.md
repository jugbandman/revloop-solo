---
type: project-pattern-readme
updated: 2026-05-01
---

How big-work projects are scaffolded in this vault. Modeled on the AI Advisor pattern from adc-main-vault.

# 80-Projects

This folder holds scaffolding for projects that need their own AI Advisor (multi-session work with persistent context, persona, and changelog). Smaller, single-session work belongs in 80-Pipeline (deals), 70-Meetings, or 60-Context, not here.

## Pattern

Every project gets a folder with three files:

- `{Project}, MOC.md` — navigation hub for this project. Status, links to deliverables, active workstreams, recent activity.
- `{Project}, AI Advisor Instructions.md` — how Claude should help. Persona, rules, contacts, what to read, what to avoid.
- `{Project}, Changelog.md` — session continuity. Where we left off, what's next.

## Bootstrapping a project

1. Copy `_template/` to a new folder named after the project (lowercase-kebab-case).
2. Rename the three template files (replace `Project` with the project's display name).
3. Fill in placeholders (`{add value}`).
4. Update the project's MOC with at least Status and one workstream.
5. From `++HOME/`, link the new MOC under Projects.

## Working on a project

When the user says "work on X" or "help me with X":

1. Read `80-Projects/{x}/{X}, AI Advisor Instructions.md` first.
2. Check `{X}, Changelog.md` for where we left off.
3. Use `{X}, MOC.md` to navigate to active workstreams.

If a project folder doesn't exist yet, offer to bootstrap from `_template/`.
