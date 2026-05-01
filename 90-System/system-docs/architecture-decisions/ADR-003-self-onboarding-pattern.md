# ADR-003: Self-Onboarding Pattern via State Machine + Milestone Skills

**Status:** Accepted
**Date:** 2026-04-17

## Context

A vault template needs to be useful from minute one. The historical failure mode for templates is front-loading: the README lists 12 prerequisites, requires a git clone, asks the user to configure three tools, and then finally says "now you can use the vault." Most users never get there.

The alternative failure mode is the empty vault: beautiful structure, no guidance, the user opens it and has no idea what to run first. Skills exist but aren't discoverable. Value is invisible.

revloop-solo needed a way to be useful immediately — including for non-technical operators who've never run a CLI tool — without sacrificing depth for the operators who want the full toolchain.

## Decision

Implement a persistent maturity state machine as the template's primary onboarding mechanism:

1. **`.revloop/onboarding.json`** holds the state. It tracks six milestones (identity, voice, business context, transcripts connected, first deal, knowledge curated), each with a `done` flag, a date, and optional notes. The file is gitignored — it's personal to each operator's deployment.

2. **`/start` is the router.** Every session, the boot protocol reads `onboarding.json` and routes to the next undone milestone. The operator never has to remember where they left off. The vault tells them.

3. **Milestone skills are the front door.** Each milestone has a dedicated skill (`/capture-voice`, `/capture-business`, `/connect-transcripts`, etc.) that interviews the operator, generates the right context files, and flips the milestone's `done` flag. Skills are atomic — they can be re-run, skipped, or interrupted without corrupting state.

4. **The state machine is non-blocking.** At every prompt, the operator can say "skip." Skipped milestones are recorded in `skipped[]` and `/start` moves on. The vault is always usable. Onboarding is background infrastructure, not a gate.

5. **Fully onboarded means "suggest improvements," not "done."** Once all milestones are complete or skipped, `/start` routes to `/today` and surfaces one proactive suggestion. The state machine never terminates — it shifts from setup to maintenance mode.

## Consequences

- First-time operators get one clear instruction per session, not a menu
- Returning operators resume exactly where they left off, no bookkeeping required
- The template is self-documenting — the state machine itself teaches what the vault is for
- New milestones can be added to the contract without breaking existing deployments (additive JSON key)
- Operators who skip everything still have a fully functional vault; the state machine degrades gracefully
- The `onboarding.json` format is the canonical extension point for template forks — fork operators add their own milestones without touching the core skills
