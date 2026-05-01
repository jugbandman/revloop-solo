# RevLoop Roadmap

## Automation Progression

Start with skills. Run them manually until the workflow feels right. Then automate.

**Three tiers:**

1. **Manual** (run /skill-name in a Claude Code session)
2. **Scheduled** (cron job on an always-on machine)
3. **Always-on** (watch folders, webhook triggers)

## What to Automate First (Quick Wins)

| Workflow | Current | Target | Effort | Impact |
|----------|---------|--------|--------|--------|
| Morning brief | Manual skill | Cron (daily 7am) | Low | High |
| Git sync | Manual skill | Cron (every 30min) | Low | Medium |
| Vault health check | Manual | Cron (daily) | Low | Medium |

## What to Automate Next (Medium Effort)

| Workflow | Current | Target | Effort | Impact |
|----------|---------|--------|--------|--------|
| Transcript processing | Drop file in 00-Inbox/ | Watch folder auto-processes | Medium | High |
| 00-Inbox/ routing | Manual | Watch folder auto-routes | Medium | High |

## What to Keep Manual (Human Judgment Required)

- **Outreach copy generation** needs review before sending
- **Deal stage transitions** need context judgment
- **Proposal drafting** is high-stakes, always needs review
- **ICP refinement** is a strategic decision

## Scheduling Infrastructure

For cron jobs, use an always-on machine (e.g., Mac Mini, cloud VM). RevLoop skills can be invoked via Claude Code's remote trigger or direct cron.
