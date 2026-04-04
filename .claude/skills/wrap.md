# /wrap

End-of-task closure. Verifies vault integrity, updates Recent Work, and commits.

Two modes:
- `/wrap` (interactive, asks before each step)
- `/wrap fast` (automatic, no prompts)

## Steps

### 1. Inventory Work Done
- Check `git diff --stat` for what changed this session
- List new/modified files by category (deals, prospects, leads, deliverables, context, skills)

### 2. Verify Entity Integrity
For each modified entity:
- Frontmatter has type, status, updated fields
- updated field reflects today's date
- context.md exists in entity folders

### 3. Update Recent Work
- Add entries to `++HOME/Recent Work.md` in the "This Week" table
- Format: `| Date | Who | File | Summary |`
- Who comes from USER.md identity
- File column links to the actual deliverable

### 4. Update _system/health.md
If any automation was run or setup was completed, update the relevant row.

### 5. Commit and Push
- Stage changes: `git add -A`
- Commit: `Wrap: [summary of session work]`
- Push to remote (if configured)

### 6. Check for Unfinished Work
If there are incomplete items (deals without next steps, prospects without context):
- In interactive mode: ask if user wants to save WIP
- In fast mode: note them in commit message

### 7. Report
Show what was wrapped:
- Files committed
- Recent Work updated
- Entities verified
- Any flags or warnings
