# /sync-gh

One-command git sync for the vault. Commits local changes, handles divergent branches with rebase, pushes to remote, pulls updates.

## Steps

### 1. Scan Local State
- Run `git status` to see uncommitted changes
- Run `git log origin/main..HEAD` to see unpushed commits (if remote exists)
- Run `git fetch` to check for remote changes

### 2. Commit Local Changes
If there are uncommitted changes:
- Stage all changes: `git add -A`
- Auto-generate commit message based on what changed:
  - Pipeline entity files > "Update: pipeline data"
  - Context files > "Update: context"
  - .claude/ files > "Update: skills/agents/hooks config"
  - Deliverables > "Add: deliverable"
  - _system/ > "Update: system status"
  - Mixed changes > "Sync: vault updates"
- Commit with format: `[Type]: [Description]`

### 3. Handle Remote Sync
- If no remote configured, skip this step
- If remote has changes: `git pull --rebase --autostash`
- If merge conflict on tracking files (.session/): auto-resolve with ours
- If merge conflict on content files: ask user
- Push: `git push`

### 4. Report
Show summary:
- Files committed
- Conflicts resolved (if any)
- Current sync status (ahead/behind/clean)
