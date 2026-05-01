---
type: skill
status: scaffold
persona: customer-success
---

Sunday-night routine that scans next week's calendar for customer calls and adds 30-minute follow-up blocks the day after each one. Outputs a summary doc to _reports/.

# /cs-calendar-block

## What it does
Sunday-night calendar follow-up blocking. Reads next week's Google Calendar via MCP, identifies customer calls, and adds 30-minute follow-up blocks the day after each one.

## Inputs
- None (defaults to upcoming Mon–Fri of next week)
- Optional: `--week-of YYYY-MM-DD` to target a specific week

## Reads
- Google Calendar (via Google Workspace MCP)
- `customers/` directory to identify which calendar events are customer calls

## Outputs
- 30-minute follow-up blocks added to calendar (held for approval per autonomy gate)
- Summary doc at `_reports/calendar-blocks-week-of-YYYY-MM-DD.md`

## Extension hooks
- Skips calls already followed by an existing block
- Reads `playbooks/sla-guide.md` for default follow-up cadence

@TODO build with operator. Wire to Google Workspace MCP and define the customer-call detection heuristic (calendar attendees vs customers/ folder match).
