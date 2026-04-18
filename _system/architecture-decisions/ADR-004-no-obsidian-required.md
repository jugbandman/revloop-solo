# ADR-004: Three-Surface Approach — No Obsidian Required

**Status:** Accepted
**Date:** 2026-04-17

## Context

Early revloop deployments treated Obsidian as a hard dependency. The README led with Obsidian installation, the setup guide required specific community plugins, and skills assumed the Obsidian CLI was available. This created two problems:

First, it excluded a wide range of operators who prefer different editors, work headlessly, or simply don't want to learn Obsidian. Second, it created a false dependency — the actual intelligence lives in Claude Code and the vault file structure. Obsidian is a viewer and editor, not the engine.

Claude Desktop became an increasingly viable alternative for operators who want AI-assisted vault work without the Claude Code CLI. And for many tasks, a plain text editor (VS Code, Cursor, any editor) combined with Claude Desktop cowork is a complete workflow.

The template needed to support all three surfaces without degrading the experience on any of them.

## Decision

Treat Claude Code, Claude Desktop cowork, and plain editor as three first-class surfaces. Obsidian and GitHub are optional enhancers that improve the experience but are not required for any core workflow.

**Claude Code (recommended).** Full experience. Hooks run, skills are slash-invocable, the state machine operates automatically. All automation, scheduling, and hook-gated writes are available.

**Claude Desktop cowork (recommended).** Full AI-assisted experience via Projects. Operator opens the vault folder as a Project, attaches key context files, and uses Claude for all writing and analysis. No hook enforcement, but the sacred sources checklist in `CLAUDE.md` carries the gate as an advisory instruction. Skills are readable as reference and executable via conversation.

**Plain editor.** Operator edits markdown directly. Claude is available on-demand via Claude.ai or Claude Desktop without a project. Skills serve as documented playbooks. No enforcement, full flexibility.

**Obsidian (optional enhancer).** Adds Dataview pipeline views, visual graph, Kanban boards, and one-click plugin actions. The `.revloop/` scaffolding is hidden by default in Obsidian's file tree (dot-folder). All Dataview queries should have plain-markdown fallbacks for the non-Obsidian case.

**GitHub (optional enhancer).** Adds version control, remote backup, and the ability to pull upstream template updates. The vault works identically via Dropbox/Drive sync or no sync at all.

The sacred sources checklist in `CLAUDE.md` is the fallback gate when hooks aren't running. It instructs Claude to load required context before writing — advisory but effective for disciplined operators. The checklist lists the same files the `write-gate.sh` hook enforces mechanically.

## Consequences

- The template is accessible to non-technical operators and those on constrained environments
- Claude Desktop users get full AI capability without any CLI setup
- Obsidian-specific instructions (plugin setup, CLI usage) are documented in `_system/OBSIDIAN-DEPS.md` as optional enhancers, not in the main README
- Skills are written to work in both execution (Claude Code) and conversation (Claude Desktop) modes — they describe goals and file paths clearly enough to be used as reference without running them
- GitHub setup is documented in `_system/fork-this-vault.md` as optional, not in the onboarding flow
- The three-surface model is explicitly communicated in README.md so operators self-select the right path for their setup
