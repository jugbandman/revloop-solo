# 30-Workflows/skills-examples/ — Opt-In Feature Gallery

This folder is an inspiration gallery, not an active plugin directory. Nothing here runs automatically. Every subfolder is a self-contained capability you can enable by following the install instructions inside it.

The pattern works like this: browse the subfolders, find something useful, follow its README to activate it. Most installs are a file copy or a shell command. Nothing touches your active vault config until you explicitly do it.

## Subfolders

**skills/**
Six pre-built Claude skills covering the core outbound sales workflow: prospect research, discovery prep, outreach sequencing, proposal drafting, account planning, and action-item reviews. Install any skill by moving its `.md` file into `.claude/skills/`. Claude will pick it up automatically on the next session.

**enrichment/**
Example scripts for connecting a Clay table to your vault's lead files. The Python script scans for un-enriched leads and fires Clay enrichment requests. The shell wrapper orchestrates the full pipeline (check deps, start tunnel, enrich, promote, update dashboard). The HeyReach sync script pulls campaign status back into prospect frontmatter. All three ship as `.example` files so they can live in version control without leaking credentials. Rename and configure to activate.

**automation/**
A sample n8n workflow that demonstrates the webhook-to-vault pattern: an external system posts a lead payload to n8n, n8n validates and normalizes the data, then shells out to a vault ingest script that writes a markdown file. The workflow ships as a `.json.example` file you import into your n8n instance.

**dashboard/**
Documentation for the optional React dashboard pattern. The dashboard reads vault frontmatter and renders pipeline charts, enrichment scores, and prospect lists. This subfolder contains a README only, no code to copy, because the app is too project-specific to port generically. Use it as a reference when you're ready to build.

## Philosophy

These features are opt-in because not every operator needs all of them. A solo consultant running 20 deals does not need a webhook pipeline. An operator at 200+ contacts does. The gallery lets you see what's possible without cluttering the active vault with unused infrastructure.

If you find yourself frequently wishing a skill existed, check here first. If it's not here, the skills README explains the authoring pattern so you can write your own and drop it in.

## Installation Summary

| Feature | Install |
|---------|---------|
| A skill | `mv 30-Workflows/skills-examples/skills/{name}.md .claude/skills/{name}.md` |
| Enrichment scripts | Rename `.example` files, set env vars, run `clay auth login` |
| n8n workflow | Import `.json.example` into n8n, update path and webhook URL |
| Dashboard | Read `dashboard/README.md`, build from scratch per your stack |
