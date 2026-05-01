---
name: connect-transcripts
description: Transcript connection milestone. Offers Granola MCP setup OR paste fallback. Integrates with /transcript-sync and /process-transcripts.
---

# /connect-transcripts

Get meeting transcripts flowing into the vault so `/process-transcripts` can summarize, extract action items, and link to entities.

## Flow

1. **Ask: do you record calls?** Yes / No / Skip for now.
2. **If yes, ask: via what tool?**
   - **Granola** → offer MCP setup (Step A).
   - **Otter / Fathom / Fireflies / Read / Gong** → document the paste-to-inbox flow (Step B).
   - **Other** → paste-to-inbox flow (Step B).
3. **If no** → tell the user they can still paste transcripts manually. Document paste flow (Step B). Flip milestone.

## Step A: Granola MCP setup

1. Check `.mcp.json` for an existing `granola` server entry. If present, skip to verification.
2. If not present, ask the user where their Granola desktop app drops transcripts. Common path on Mac: `~/Documents/Obsidian Vault/Granola/` or `~/Library/Application Support/Granola/`.
3. Update `USER.md` Tools section with `Granola sync path: <path>`.
4. Offer to edit `.mcp.json` to add a local filesystem MCP server scoped to that path (or skip if the user prefers the built-in `/transcript-sync` script — that script reads the path from `USER.md` and polls directly; no MCP required).
5. **Verify.** Reuse the Setup Gate from `.claude/skills/transcript-sync.md`: confirm the path exists, readable, contains at least one file matching the Granola export pattern.
6. Run `/transcript-sync` once. It should pull any existing transcripts into `70-Meetings/inbox/` (create if missing).

## Step B: paste-to-inbox fallback

1. Tell the user: *"Paste any transcript into a new file under `70-Meetings/inbox/` with a name like `YYYY-MM-DD-company-topic.md`. Run `/process-transcripts` to summarize + extract action items + link to entities."*
2. Offer to create `70-Meetings/inbox/.gitkeep` so the folder exists.

## Finish

Flip `milestones.transcripts_connected.done = true`. Set `connections.granola.status` to `configured | paste-only | declined` as appropriate.

## Skip

Push `transcripts_connected` into `skipped[]`. The `/process-transcripts` skill still works if the user later drops a transcript manually.

## Reuse

- `.claude/skills/transcript-sync.md` (the Setup Gate and sync loop)
- `.claude/skills/process-transcripts.md` (summary + action item extraction)
