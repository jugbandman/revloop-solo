---
name: capture-voice
description: Voice calibration milestone. Harvests or paste-ingests the user's real writing samples and writes context/brand-voice.md. Invoked by /start or standalone.
---

# /capture-voice

Calibrate your authentic voice so the `my-voice` agent can write on your behalf.

## Flow

1. **Offer two paths.**
   - **Paste (default).** User pastes: LinkedIn "About" section, 2–3 recent outbound emails, one thought-leadership post or writing sample.
   - **Auto-harvest.** If a Gmail MCP is present (check `.mcp.json` for gmail server), offer to pull the 20 most recent sent messages for signal. If unavailable, fall back to paste.
2. **Analyze inline.** Extract: register (warm/casual/professional/formal), sign-off, signature block, cadence, DO/DON'T phrases, punctuation preferences, opening moves, closing moves.
3. **Write `context/brand-voice.md`.** Use the existing schema in that file if present — preserve and extend. Append a `## Source Samples` section at the bottom containing the raw paste (lightly trimmed) so future recalibration has a reference.
4. **Flip milestone.** Update `.revloop/onboarding.json`: `milestones.voice.done = true`, `at = <today>`.
5. **Verify.** Ask the `my-voice` agent to draft a 3-sentence outreach opener. Show it to the user. Ask: "does this sound like you?" If no, ask for one corrective sample and re-run analysis.

## Skip

If the user says "skip," push `voice` into `skipped[]` and exit without writing brand-voice.md. `/start` advances to the next milestone.

## Reuse

Schema template: `context/brand-voice.md` (if already present). Voice consumer: `.claude/agents/my-voice.md`.
