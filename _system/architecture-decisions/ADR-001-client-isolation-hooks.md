# ADR-001: Vault-Level Write Gating via Hooks

**Status:** Accepted
**Date:** 2026-03-31
**Decision makers:** the operator

## Context

Claude Code agents can read and write files freely. In a revloop-solo vault containing positioning, ICP data, prospect context, and deliverables, there is no built-in mechanism to ensure the agent loads required context before generating output. This leads to:

1. Deliverables written without current positioning or ICP context loaded
2. Prospect-specific outreach generated without reading that prospect's context
3. No mechanical traceability between source files and output

## Decision

Implement Claude Code hooks with vault-level write gating:

**Vault-level gate:** Block ALL writes until global Required Sources from `CLAUDE.md` (or a sacred sources checklist it references) are loaded. These are foundational files (context/positioning.md, context/icp.md, context/brand-voice.md) that must inform every piece of output.

**Session lifecycle:** A pre-tool hook initializes session state on first vault file access. A post-read hook tracks every file read. The Stop hook clears all session state automatically.

Solo mode does not implement entity-level gating (Level 2 from multi-operator deployments). The vault-level gate is sufficient when one operator owns all entities.

## How It Works

### Hook chain (in execution order)

| Hook point | Script | Purpose |
|------------|--------|---------|
| PreToolUse (all tools) | `pre-tool.sh` | Initialize session lock on first vault file access |
| PreToolUse (Write/Edit) | `write-gate.sh` | Block writes until vault-level gate passes |
| PostToolUse (Read) | `post-read.sh` | Track loaded files in `.session/loaded-sources.txt` |
| Stop | inline rm | Clear `.session/` state files |

### Write gate flow

```
Write requested for: pipeline/prospects/Acme/outreach-draft.md

Vault gate: Check CLAUDE.md Sacred Sources
  ├── context/positioning.md loaded? YES
  ├── context/icp.md loaded? YES
  └── context/brand-voice.md loaded? YES
  → PASS

Result: Write ALLOWED
```

If the gate fails, the write is blocked with a message telling the agent exactly which files to read.

### Exemptions

- Files outside the vault: not gated
- `.session/`, `.git/`, `.claude/` paths: not gated (infrastructure)
- Writing TO a context.md itself: allowed (you should be able to create/edit context files)

## Alternatives Considered

**CLAUDE.md instructions only (advisory):** The agent is told to read context first. Problem: instructions are suggestions. The agent can skip them under pressure or through drift. No mechanical guarantee.

**Pre-commit git hooks:** Would catch bad output after the fact, but cannot prevent the write from happening. The agent would need to redo work. Wasteful.

## Tradeoffs

| Tradeoff | Assessment |
|----------|------------|
| Slower session start (must read sources first) | Acceptable. 3 files is seconds. Prevents hours of bad output. |
| Python dependency for JSON parsing in hooks | Acceptable. Python3 is universally available on macOS/Linux. |
| No enforcement on Bash tool file writes | Known gap. Hooks only fire for Claude Code's Read/Write/Edit tools, not raw bash commands. Documented as limitation. |

## Consequences

- Every deliverable is mechanically guaranteed to have been written after required context was loaded
- Session state is ephemeral and auto-clears, so no stale lock issues
- Adding new required sources is a one-line edit to the sacred sources checklist in `CLAUDE.md`
- When hooks aren't running (Claude Desktop or plain editor sessions), the sacred sources checklist in `CLAUDE.md` carries the gate as an advisory instruction
