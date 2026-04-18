# Obsidian Recommended Enhancers

Optional Obsidian plugins that enhance this vault. None are required — the vault works fully without Obsidian. These are enhancers, not prerequisites.

## Installation

Settings > Community Plugins > Turn on community plugins > Browse > search by name > Install > Enable.

## Recommended Enhancers

### Dataview
- **Plugin ID:** `dataview`
- **Purpose:** Pipeline queries, entity indexes, auto-generated reports in .revloop/reports/
- **Useful Settings:**
  - Enable JavaScript Queries: ON (needed for advanced pipeline rollups)
  - Enable Inline Queries: ON (for inline entity counts in dashboards)
  - Refresh interval: 2500ms (default is fine)
  - Date format: yyyy-MM-dd
- **Why this one:** Dataview is the most mature Obsidian query engine for frontmatter-driven pipeline views. Alternatives like DB Folder are more opinionated and less flexible for custom stage transitions.

### Templater
- **Plugin ID:** `templater-obsidian`
- **Purpose:** Entity creation from `.revloop/templates/`. Powers lead, prospect, deal, transcript, and daily-brief templates.
- **Useful Settings:**
  - Template folder location: `.revloop/templates/`
  - Trigger Templater on new file creation: ON
  - Enable folder templates: ON (optional, map folders to default templates)
  - Suggested folder mappings:
    - `pipeline/` > `.revloop/templates/prospect.md`
    - `pipeline/deals/` > `.revloop/templates/deal.md`
    - `meetings/` > `.revloop/templates/transcript.md`

### Metadata Menu
- **Plugin ID:** `metadata-menu`
- **Purpose:** Frontmatter property editing, stage transitions (lead > prospect > deal), bulk field updates.
- **Useful Settings:**
  - Define fileClasses for: lead, prospect, deal, transcript, outreach
  - Configure stage field as a dropdown with allowed values
  - Enable "Add field" command for quick property additions
- **Alternative:** Linter plugin (`obsidian-linter`) for frontmatter formatting and field ordering, though it lacks the interactive editing that Metadata Menu provides.

### Kanban
- **Plugin ID:** `obsidian-kanban`
- **Purpose:** Visual pipeline board. Create boards that mirror Dataview pipeline stages for drag-and-drop deal management.
- **Settings:** Default board location in `.revloop/features/dashboard/`

### Buttons
- **Plugin ID:** `buttons`
- **Purpose:** One-click actions embedded in notes. Use cases include "Promote to Prospect", "Export Deliverable", "Run Morning Brief".
- **Settings:** No special configuration needed. Define buttons inline using code blocks.

### Calendar
- **Plugin ID:** `calendar`
- **Purpose:** Timeline view of meetings, daily briefs, and activities.
- **Settings:** Link to daily notes folder if using Periodic Notes.

### Obsidian Git
- **Plugin ID:** `obsidian-git`
- **Purpose:** Auto-backup and version control from within Obsidian. Keeps vault changes committed without manual git commands.
- **Settings:**
  - Auto backup interval: 10 minutes (adjust to preference)
  - Auto pull on open: ON
  - Commit message format: `Auto: vault backup {{date}}`

### Periodic Notes
- **Plugin ID:** `periodic-notes`
- **Purpose:** Daily note generation for morning briefs and activity logs.
- **Settings:**
  - Daily note template: `.revloop/templates/daily-brief.md`
  - Daily note folder: `Workspace/`

### Tasks
- **Plugin ID:** `obsidian-tasks-plugin`
- **Purpose:** Task tracking across all vault files. Query open action items from transcripts, deals, and daily briefs.
- **Settings:**
  - Global filter: none (track all tasks)
  - Done date: ON
