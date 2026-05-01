# Vault Health

## Setup Checklist

| Component | Status | Notes |
|-----------|--------|-------|
| Claude Code | Not configured | Required for skills and agents |
| USER.md filled in | Not configured | Run /get-started or copy USER.md.example |
| Context files created from examples | Not configured | Copy .example files from 60-Context/, customize |
| Git remote configured | Not configured | Recommended for backup and sync |
| Obsidian + Dataview plugin | Not configured | Optional, needed for dynamic dashboards |
| Obsidian + Templater plugin | Not configured | Optional, needed for note templates |

## Automation Status

| Automation | Mode | Last Run | Status |
|------------|------|----------|--------|
| Morning brief | Manual | Never | Not started |
| Vault health check (/vault-review) | Manual | Never | Not started |
| Git sync | Manual | Never | Not started |
| Transcript processing | Manual | Never | Not started |

## Vault Integrity

- [ ] All prospect folders have context.md
- [ ] All deal folders have context.md
- [ ] Frontmatter on all entity files (type, status, updated)
- [ ] No orphan files outside folder structure
- [ ] Write-gate hooks functioning
