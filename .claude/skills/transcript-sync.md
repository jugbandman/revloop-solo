# /transcript-sync

Scan the operator's personal Obsidian Vault for new Granola transcripts related to Arbor, copy them into `o-transcripts/internal/`, and optionally process them.

## Vault Path Resolution

Each contributor has their own Obsidian Vault with Granola sync. Detect the current operator via `git config user.name`, then resolve the vault path:

| Operator | Vault Granola Path |
|----------|-------------------|
| Andy Carlson | `/Users/andycarlson/Documents/Obsidian Vault/Granola/` |
| Tim Shisler | `{ask Tim for path on first run, then remember}` |

If the operator is not mapped, ask them for their Granola vault path and remind them to add it to this file.

**Important:** Granola drops new transcripts in the root Granola folder. After ~7 days they get sorted into project subfolders (e.g., `Remix-Arbor/`). Always scan BOTH the root folder AND project subfolders for Arbor-related transcripts. Match by:
- Files in the `Remix-Arbor/` subfolder (all are Arbor-related)
- Files in root containing "Arbor", "Dmitry", "Grace", "Stephane", "John" (Arbor team members) in the filename or `attendees` frontmatter

**Filtering:** Only import transcripts where Arbor team members are present (Dmitry, Grace, Stephane, John) OR the meeting is explicitly Arbor-tagged (title, folder, or frontmatter). Operator-only calls (Tim-Andy internals) should NOT be imported unless the title/content clearly indicates it's an Arbor planning session.

## Workflow

### 1. Scan for New Transcripts

Read the operator's Granola Arbor folder. Compare filenames against what already exists in `o-transcripts/internal/`. A transcript is "new" if no file in `o-transcripts/internal/` shares the same `granola_id` frontmatter value.

List new transcripts for the operator with date and title. If none found, report that and stop.

### 2. Select and Import

If there's only one new transcript, proceed with it. If multiple, ask which ones to import (or "all").

For each selected transcript:

1. Read the source file from the Granola vault
2. Normalize the filename to the repo convention: `YYYY-MM-DD-{first-names-lowercase-kebab}.md`
   - Example: `2026-04-03-Dmitry-Arbor-x-Tim-Shisler-x-Andy-Carlson.md` becomes `2026-04-03-dmitry-tim-andy.md`
   - Use first names only, alphabetical by last name, skip company suffixes
3. Copy the full file content (frontmatter + notes + transcript) into `o-transcripts/internal/`
4. Update the frontmatter `participants` links to use `o-people/` paths instead of personal vault paths:
   - `[[40-People/dmitry-koltunov]]` becomes `[[o-people/client/dmitry-koltunov]]`
   - `[[40-People/tim-shisler]]` becomes `[[o-people/operators/tim-shisler]]`
   - `[[Andy Carlson]]` becomes `[[o-people/operators/andy-carlson]]`
   - Map any other known people similarly
5. Report what was imported

### 3. Offer Processing

After import, ask if the operator wants to run `/process-transcript` on the imported file(s) for structured summary extraction and entity context updates.

## Notes

- This skill only reads from the personal vault, never writes to it
- The Granola sync plugin in Obsidian handles the Granola API sync (every 15 min)
- Subfolders in the Granola vault are configured per-user in Obsidian (Remix-Arbor, etc.)
- If a transcript has already been imported (matching granola_id), skip it and note the duplicate
