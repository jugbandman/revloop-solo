# `.revloop/` — Self-Onboarding State Machine

This directory holds the operator's onboarding progress tracker and state machine files.

## Files

### `onboarding.json` (gitignored — local to each operator)

The live state file that tracks your progress through the self-onboarding milestones. Created automatically on first `/start` invocation.

**Schema:**
- `schema_version`: Version of the state file format
- `started`: ISO 8601 timestamp when onboarding began
- `mode`: Always `"solo"` in revloop-solo
- `level`: Current onboarding level (0–6)
  - 0 = Fresh clone, not started
  - 1 = Identity captured
  - 2 = Voice captured
  - 3 = Business context captured
  - 4 = Transcripts connected
  - 5 = First deal tracked
  - 6 = Fully onboarded
- `milestones`: Object tracking completion status of each milestone
- `skipped`: Array of milestone names you've chosen to skip
- `connections`: Integration status (Granola, Gmail, Calendar)

Each milestone skill reads and updates this file as you progress. Your operator state is **local to your machine** — `onboarding.json` is gitignored so it never leaves your vault.

### `onboarding.json.example` (template — committed to repo)

Shows the schema for a fresh state file at level 0. Use this as a reference if you need to understand the structure or reset your state manually.

## How It Works

1. When you invoke `/start`, it checks for `onboarding.json`
   - If missing: creates one at level 0
   - If present: reads your current level and routes you to the next milestone
2. Each milestone skill updates the file as you complete tasks (advancing `level`, appending to `milestones` completed)
3. On boot, `CLAUDE.md` reads this file and prints your next action ("Next up: [milestone]")
4. The system gracefully handles returning to milestones you've skipped

## For Future Developers

When adding a new milestone skill, consult `90-System/system-docs/milestone-skill-contract.md` for the expected interface. Your skill must:
- Read `onboarding.json` (create at level 0 if missing)
- Detect if its milestone is already complete (idempotent)
- Write to designated context files
- Update `level` and `milestones_completed` on success
- Print confirmation + "Next up: [next milestone]"
