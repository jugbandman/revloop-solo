# /sync-gh

One-command git sync. Commits, rebases, pushes.

**Token strategy:** Tidy check runs as a single Haiku agent. Git operations stay inline (they're fast shell commands). No Opus-level reasoning needed.

## Steps

### 1. Scan Local State (inline)
- `git status --short`
- `git log origin/main..HEAD --oneline` (if remote exists)
- `git fetch`

### 2. Tidy Check (Haiku agent)

Spawn ONE Haiku agent (model: "haiku"):
```
Run these checks on the vault and return a concise report.

MISPLACED FILES:
- List any .md files directly in pipeline/ root (should be in prospects/, deals/, or closed/)
- List any files in ++HOME/ that are NOT ++HOME.md or Recent Work.md
- List any non-template files in _templates/ (files without "template" in the name or not .example)

STALE IMPORTS:
- Count files in _imports/. For any older than 7 days (check mtime), flag them.

HEALTH.MD ACCURACY:
- Read _system/health.md
- Check: does USER.md (or _me/USER.md) exist? If yes but health.md says "Not configured" for identity, flag it.
- Check: does git remote exist? (git remote -v) If yes but health.md says "Not configured" for Git remote, flag it.

Return in this format:
Misplaced: {count or "clean"}
Stale imports: {count, oldest N days} or "clean"
Health.md: {accurate} or {list discrepancies}
```

### 3. Commit Local Changes (inline)
If uncommitted changes exist:
- `git add -A`
- Auto-generate commit message from diff stat:
  - Pipeline files → "Update: pipeline data"
  - Context files → "Update: context"
  - .claude/ files → "Update: skills/agents/hooks config"
  - Deliverables → "Add: deliverable"
  - _system/ → "Update: system status"
  - Mixed → "Sync: vault updates"
- Commit with format: `[Type]: [Description]`

### 4. Remote Sync (inline)
- No remote? Skip.
- Remote has changes: `git pull --rebase --autostash`
- Conflict on .session/ files: auto-resolve with ours
- Conflict on content: ask user
- `git push`

### 5. Report (inline)

Print concise summary:
```
Synced: {N} files committed, pushed to origin/main

Vault Tidy:
- Misplaced: {from Haiku agent}
- Imports: {from Haiku agent}
- Health.md: {from Haiku agent}
```

If discrepancies found: "Run `/vault-review` for full diagnostic."
