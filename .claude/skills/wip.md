# /wip

Save or resume work-in-progress sessions across conversation boundaries.

Commands:
- `/wip` or `/wip pause` (save current state)
- `/wip list` (show active WIP items)
- `/wip resume` (pick up where you left off)

## Pause Mode

### 1. Orient
- Check `git status` for current state
- Identify what was being worked on (recent file changes, active deals, research)

### 2. Commit Current State
- Stage all changes: `git add -A`
- Commit: `WIP: pause {summary}`
- Push to remote (if configured)

### 3. Write Re-entry File
Create `scratch/wip/YYYY-MM-DD-{slug}.md` with:

```yaml
---
project: RevLoop
phase: {what phase of work}
paused: YYYY-MM-DD HH:MM
---
```

Body:
- **What was done:** bullet list of completed work
- **In progress:** what's partially complete
- **Files touched:** list of key files modified
- **Next actions:** numbered list of what to do next
- **Re-entry instructions:** specific steps to pick up (which files to read, which skill to run)

### 4. Report
Show: WIP saved, re-entry file location, next actions preview.

## List Mode

Scan `scratch/wip/` for active WIP files. Show table: Date | Summary | Next Action.

## Resume Mode

### 1. List active WIP items (or pick from argument)
### 2. Read the re-entry file
### 3. Load context (read files mentioned in re-entry)
### 4. Show re-entry brief to user
### 5. Wait for confirmation
### 6. Begin first next action
