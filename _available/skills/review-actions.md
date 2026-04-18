# /review-actions

Weekly cleanup of `++Home/action-items.md`. Archives completed items, flags stale items, surfaces patterns. Also runs vault-mapping diagnostics as a bonus.

## Prerequisites

- `++Home/action-items.md` exists
- `obsidian-cli` installed (path in `_system/user.md`)
- Your vault registered with Obsidian
- **Obsidian must be running** — this skill depends on obsidian-cli which talks to a live Obsidian instance. If Obsidian is closed, commands return "The CLI is unable to find Obsidian." Prompt the operator to launch Obsidian before running `/review-actions`.

## Workflow

### 1. Snapshot Current State

```
obsidian vault=<your-vault-name> tasks file="action-items" todo format=json verbose
```

This returns every incomplete task with line number and heading context. Keep this snapshot for the rest of the run.

Also fetch:
```
obsidian vault=<your-vault-name> tasks file="action-items" done format=json verbose
```
for completed items.

### 2. Archive Completed Items (>7 days)

For each item in `## Done (Last 7 Days)` with `(done YYYY-MM-DD)` older than 7 days:
- Move to `## Archive`
- Change `(done YYYY-MM-DD)` to `(archived YYYY-MM-DD: completed)`

Use Edit to do the section-aware move. obsidian-cli doesn't have a move-line primitive.

### 3. Flag Stale Items

For each incomplete item, parse the `(added YYYY-MM-DD)` timestamp. Flag based on section:

| Section | Stale threshold |
|---------|-----------------|
| Must Do | 3+ days |
| Should Do | 7+ days |
| Could Do | no flag |
| Waiting On | 14+ days |
| Team Owes Us | 14+ days (since {date}) |

For each stale item, ask the operator:
- **Keep as-is** — refresh the `(added)` date to today (optional)
- **Demote** — move to a lower-priority section (Must to Should to Could, or push to backlog)
- **Delete** — item no longer relevant
- **Follow up** — for Waiting On, generate a nudge draft

Batch the questions — don't ask one at a time unless there are fewer than 3 stale items.

### 4. Surface Patterns

Look for patterns across the current and past snapshots:
- Items that have been demoted multiple times
- Items that keep getting re-added from transcripts (signal: root cause not addressed)
- Items where the owner might not be the right one

Report these as observations, not as action items.

### 5. Update Frontmatter

```
obsidian vault=<your-vault-name> property:set file="action-items" name="last-review" value="YYYY-MM-DD"
obsidian vault=<your-vault-name> property:set file="action-items" name="updated" value="YYYY-MM-DD"
```

Also update `updated` to today's date.

### 6. Vault Mapping Diagnostics (bonus)

Run these and surface issues in the review report:

```
obsidian vault=<your-vault-name> unresolved
obsidian vault=<your-vault-name> orphans
```

- **Unresolved links**: if any broken links exist, list the source files
- **Orphaned files**: files with no incoming links. Always filter out `_available/` (contains node_modules, tens of thousands of files), `_templates/`, `_system/`, and `.obsidian/`. Report only orphans in `pipeline/`, `scratch/`, `meetings/`, `people/`, `knowledge/`, `++Home/`.

### 7. Report

Produce a summary like:

```
## Review Summary — YYYY-MM-DD

**Archived:** 3 completed items moved to Archive
**Stale items flagged:** 2 Must Do (3+ days), 1 Waiting On (14+ days)
**Patterns:** "Draft follow-up email" pushed forward 3 times — consider breaking it down
**Vault health:** 1 broken link in pipeline/deals/acme-corp/context.md
**Orphaned files:** scratch/pipeline-analysis/old-notes.md (consider archiving)

Last review: 2026-04-06 → 2026-04-13
```

## Notes

- Never delete items silently — always confirm with operator
- `obsidian-cli eval` is available for complex in-file manipulations if Edit becomes unwieldy
- This skill is safe to run multiple times in a week (idempotent)
