# Milestone Skill Contract

Every skill that participates in the self-onboarding state machine implements this interface. This makes new milestones easy to add.

## Interface

A milestone skill MUST:

1. **Read `.revloop/onboarding.json`** on entry to know current state.
2. **Do its work.** Interview, paste ingestion, MCP setup, or direct invocation of an existing skill.
3. **Accept "skip" at any prompt.** On skip:
   - Append the milestone name to `onboarding.json` → `skipped[]`.
   - Do NOT flip `done = true`.
   - Return.
4. **On success, flip state.** Set `milestones.{name}.done = true`, `milestones.{name}.at = YYYY-MM-DD` (today), optionally `milestones.{name}.notes = "<free text>"`.
5. **Write back atomically.** Read → mutate → write. Don't leave the JSON half-updated.
6. **Never block downstream work.** If a user wants to skip ahead, the skill exits gracefully. Onboarding is best-effort.

## Existing milestones

| Milestone | Skill | Writes |
|---|---|---|
| `identity` | inline in `/start` | `USER.md` |
| `voice` | `/capture-voice` | `60-Context/brand-voice.md` |
| `business_context` | `/capture-business` | `60-Context/positioning.md`, `offerings.md`, `icp.md`, `competitors.md` |
| `transcripts_connected` | `/connect-transcripts` | `70-Meetings/inbox/`, `.mcp.json` (optional), `connections.granola` state |
| `first_deal` | `/prospect-research` (direct invocation) | `80-Pipeline/{name}/context.md` |
| `knowledge_curated` | `/import-context` (direct invocation) | `60-Context/*.md` gaps filled |

## Adding a new milestone

1. Pick a stable name (lower_snake_case).
2. Add `milestones.{name}: { done: false }` to `.revloop/onboarding.json` schema.
3. Create `.claude/skills/{name}.md` implementing this contract.
4. Add a command passthrough at `.claude/commands/{name}.md`.
5. Insert `{name}` into the ordered list in `.claude/skills/start.md` at the right position.
6. Document in `.revloop/system/FEATURES.md`.

## Fully onboarded

When all milestones are `done: true` OR `skipped`, `/start` falls through to `/today` and suggests one improvement (e.g., "add a prospect," "review a stale deal," "capture a transcript"). The vault stays useful indefinitely; onboarding doesn't "end" so much as it becomes background.

## JSON schema (simplified)

```json
{
  "schema_version": 1,
  "started": "YYYY-MM-DD",
  "mode": "solo",
  "level": 0,
  "milestones": {
    "identity": { "done": false, "at": "YYYY-MM-DD", "notes": "..." },
    "voice": { "done": false },
    "business_context": { "done": false },
    "transcripts_connected": { "done": false },
    "first_deal": { "done": false },
    "knowledge_curated": { "done": false }
  },
  "skipped": ["milestone_name"],
  "connections": {
    "granola": { "status": "configured|paste-only|declined|unknown", "path": "..." },
    "gmail": { "status": "..." },
    "calendar": { "status": "..." }
  }
}
```

`level` is a convenience integer — one more than the highest done milestone index. Skills can use it for quick branching; the `milestones` object is authoritative.
