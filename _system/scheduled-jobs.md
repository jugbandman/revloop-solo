---
type: system-doc
scope: automation
updated: 2026-04-17
---

# Scheduled Jobs

Cron jobs that run vault skills on a schedule. Each operator manages their own crontab locally.

## Active Schedules

### `/morning-brief` at 9am daily

Runs on the operator's Mac. Archives yesterday's brief to `.revloop/reports/daily-briefs/` and writes a new one to `++HOME/daily-brief.md`.

**Crontab line:**

```cron
0 9 * * * cd {VAULT_PATH} && /usr/bin/timeout 600 /usr/local/bin/claude -p "/morning-brief" >> {VAULT_PATH}/.session/cron-morning-brief.log 2>&1
```

Install with `crontab -e`. Replace `{VAULT_PATH}` with the absolute path to your vault. Adjust the `claude` binary path per operator (run `which claude` to find it).

The `timeout 600` wrapper caps the run at 10 minutes. Observed behavior: `claude -p` completes the skill quickly (writes the brief in ~30-60s) but can take another 1-2 minutes to tear down MCP connections. Timeout protects against a hung MCP pinning a zombie process. Brief is already written well before timeout; kill just releases the slot.

## Setup Caveats

1. **Mac must be awake.** Closed laptop at 9am → cron doesn't fire. Use Amphetamine or schedule a wake with `pmset repeat wakeorpoweron MTWRFSU 08:55:00` (needs admin).
2. **Verify claude binary path.** Run `which claude` and update the crontab line if it's not at `/usr/local/bin/claude`.
3. **Headless flag.** `-p "<prompt>"` is the current non-interactive flag. If your Claude Code version differs, check `claude --help`.
4. **Cron environment is minimal.** No `.zshrc`, limited PATH. If the skill needs env vars, source them explicitly or wrap the command in a shell script that loads your profile.
5. **MCP auth.** Gmail and Google Calendar MCPs must be authed. If auth expires, the run fails silently into the log.
6. **First-run test.** Before trusting cron, run `cd {VAULT_PATH} && claude -p "/morning-brief"` manually. If it produces a brief, cron will too.

## Self-Monitoring

`/morning-brief` includes a Cron Health check each run. It inspects:

- `.revloop/reports/daily-briefs/` for missing dates in the last 7 days
- `.session/cron-morning-brief.log` for error signals
- H1 date of the archived brief for staleness

Any issue surfaces in the brief under a `## Cron Health` section with a fix action. If the brief itself fails to run, the archive will develop a gap — the next successful run flags it.

## Logs

Each scheduled job appends to `.session/cron-<job>.log`. `.session/` is gitignored — logs stay local. Rotate or truncate manually if they grow.

## Adding a New Scheduled Job

1. Add the crontab line under Active Schedules above with the skill, time, and purpose.
2. Install via `crontab -e`.
3. First-run test manually before trusting the cron.
4. Add a CHANGELOG entry.
