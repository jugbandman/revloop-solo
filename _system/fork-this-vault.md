# Fork This Vault

How to use `revloop-solo` as the starting point for your own self-onboarding business vault.

This vault is designed to be forked. The scaffolding, skills, and state machine are generic. Your content — positioning, ICP, voice, deals, transcripts — is what makes it yours.

## Who This Is For

Operators who want a Claude Code-native vault for their own GTM motion: solo founders, consultants, fractional executives, independent sellers. You're not migrating an existing complex vault; you're starting fresh from a working template.

## Prerequisites

- Git installed (optional but recommended)
- Claude Code installed (`npm i -g @anthropic-ai/claude-code` or see Claude docs)
- 15 minutes for first onboarding

## Steps

### 1. Fork or download

```bash
# Fork via GitHub (keeps update path)
gh repo fork your-org/revloop-solo --clone --remote

# Or download a zip — no git required
# GitHub > Code > Download ZIP > unzip to ~/Vaults/my-vault/
```

### 2. Open with Claude Code

```bash
cd ~/Vaults/my-vault
claude
```

That's it. On first boot, Claude Code reads `CLAUDE.md` + `.revloop/onboarding.json` and walks you through setup. You don't need to read any docs before opening.

### 3. Run /start

Type `/start` at the Claude Code prompt. The state machine takes it from there:

- **identity** — who you are, what you do
- **voice** — how you communicate (writes `context/brand-voice.md`)
- **business_context** — your positioning, ICP, offerings (writes `context/` files)
- **transcripts_connected** — link your meeting source (Granola, paste, or skip)
- **first_deal** — research your first prospect
- **knowledge_curated** — fill any context gaps

Each step can be skipped. Resume any time.

### 4. Personalize CLAUDE.md

The root `CLAUDE.md` is thin by design. Add your name, working style preferences, and any tool-specific config. Keep the boot protocol intact (the first 20 lines that read USER.md and onboarding.json).

### 5. Gitignore your data

By default, `USER.md`, `pipeline/`, `meetings/`, `context/`, and `Workspace/` are gitignored. Your data stays local. The scaffolding (`.claude/`, `.revloop/`) is tracked and can be shared or updated.

If you want to track your own data (personal vault, not shared repo), remove those lines from `.gitignore`.

### 6. Customize skills (optional)

Skills live in `.claude/skills/`. They're markdown files that describe what Claude should do. Read one, modify it, or write a new one. The pattern is simple: "do this, read these files, write output here."

To add a new milestone skill, follow the contract in `_system/milestone-skill-contract.md`.

## Folder Layout After Onboarding

```
USER.md              # you
CLAUDE.md            # boot protocol (thin)

pipeline/            # your prospects, deals, customers
  prospects/
  deals/
  customers/
people/              # individuals
meetings/            # transcripts + notes
context/             # brand voice, positioning, ICP, playbooks
Deliverables/        # client-ready output
Workspace/           # scratch + WIP

.revloop/            # scaffolding (hidden in Obsidian)
  onboarding.json    # your progress
  system/            # FEATURES.md, health.md, ROADMAP.md
  templates/         # entity templates
  scripts/           # automation

.claude/             # skills, agents, hooks
```

## Keeping in Sync with Upstream

If you forked via GitHub, you can pull template improvements:

```bash
git fetch upstream
git merge upstream/main --no-commit
# Review changes, especially to .claude/ and .revloop/
# Your data files are gitignored, so no conflicts there
git commit -m "Merge upstream template updates"
```

Breaking changes are documented in `_system/CHANGELOG.md`.

## Common Customizations

**Different meeting source.** Replace the Granola integration in `/connect-transcripts` with your source. Paste-based ingestion always works as a fallback.

**Different outreach tool.** The template references HeyReach as an optional CLI. Swap it for your preferred outreach stack, or remove it entirely.

**Add a morning brief.** Copy `.claude/skills/morning-brief.md` from any revloop deployment. Wire up Gmail + Google Calendar MCP (see `_system/CREDENTIAL-SETUP.md`).

**Team mode.** The template is solo-first. For a shared vault, keep `USER.md` gitignored and add a separate business-context file for the client entity. Every skill checks `USER.md` first, then falls back to the business-context file if present.

## Getting Help

- Boot the vault and ask Claude Code directly — the skills know the architecture
- `_system/self-onboarding-architecture.md` — the why
- `_system/milestone-skill-contract.md` — adding new milestones
- `_system/CHANGELOG.md` — version-to-version migration notes
