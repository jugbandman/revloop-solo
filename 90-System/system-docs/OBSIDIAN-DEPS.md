# Obsidian Dependencies

Optional Obsidian plugins and the Obsidian CLI that enhance this vault. The vault works fully without Obsidian, these are enhancers, not prerequisites.

## Obsidian CLI (preferred for vault-aware ops)

The Obsidian CLI is the preferred tool for vault-aware operations per CLAUDE.md "Obsidian as Primary Surface". Use `Obsidian <command>` via Bash.

### Install

```bash
brew install kepano/tap/obsidian-cli
```

(or follow current install instructions at the obsidian-cli GitHub repo)

### Common commands

| Command | Use |
|---------|-----|
| `Obsidian backlinks path=<path>` | Check backlinks before moving or renaming a file |
| `Obsidian search query=<text>` | Vault-wide search |
| `Obsidian orphans` | Find notes with no incoming links |
| `Obsidian deadends` | Find notes with no outgoing links |
| `Obsidian unresolved` | Find broken wikilinks |
| `Obsidian property:set name=<n> value=<v> path=<p>` | Set frontmatter property (triggers reindex) |
| `Obsidian eval code="<javascript>"` | Run JS against the live metadata cache for graph queries |

### When to use the CLI vs filesystem tools

CLI for: backlinks, orphans, dead-ends, unresolved links, property writes, graph queries. Anything that needs Obsidian's metadata cache.

Filesystem for: bulk file creation, content reads, regex search across files. Faster for non-graph work.

## Plugins

Install via Settings > Community Plugins > Browse.

### Dataview (essential)

- **Plugin ID:** `dataview`
- **Why required:** `999-Reports/` uses Dataview queries to roll up customer action items, customer health, and weekly transcripts. Without Dataview the rollup files render as code blocks.
- **Useful settings:**
  - Enable JavaScript Queries: ON (for advanced rollups)
  - Enable Inline Queries: ON
  - Date format: yyyy-MM-dd

### Templater (optional but useful)

- **Plugin ID:** `templater-obsidian`
- **Why useful:** Template insertion for new customer/meeting/deal entities from `90-System/templates/`. Skip if you create files manually or rely on Claude.
- **Useful settings:**
  - Template folder location: `90-System/templates/`
  - Trigger Templater on new file creation: ON (optional)

That's it. Anything else (Kanban, Buttons, Calendar, Periodic Notes, Tasks, Obsidian Git, Metadata Menu) is a personal preference. Add as you find a real need, don't preinstall.
