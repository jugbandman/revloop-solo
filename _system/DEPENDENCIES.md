# Dependencies

Complete dependency tracker for the revloop-solo system.

## Required

Nothing is strictly required. Claude Code (recommended), Claude Desktop cowork (recommended), Obsidian (optional), GitHub (optional).

## CLI Tools (npm global, optional)

### heyreach-cli

- **Source:** [bcharleson/heyreach-cli](https://github.com/bcharleson/heyreach-cli)
- **Install:** `npm i -g heyreach-cli`
- **Requires:** HeyReach API key
- **Purpose:** LinkedIn outreach campaign management, sequence control, lead list operations

### n8n-agent-cli

- **Source:** [bcharleson/n8n-agent-cli](https://github.com/bcharleson/n8n-agent-cli)
- **Install:** `npm i -g n8n-agent-cli`
- **Requires:** n8n instance URL, webhook URLs for each registered workflow
- **Purpose:** Trigger n8n workflows as CLI tools, pass structured data to automations without exposing raw API keys

## MCP Servers (optional)

### heyreach-mcp

- **Source:** [bcharleson/heyreach-mcp](https://github.com/bcharleson/heyreach-mcp)
- **Install:** Add to `.claude/settings.json` under `mcpServers`
- **Requires:** HeyReach API key (passed as header auth)
- **Purpose:** Gives Claude Code direct access to HeyReach operations (campaign status, lead management) via MCP protocol

**Example config (.claude/settings.json):**

```json
{
  "mcpServers": {
    "heyreach": {
      "command": "npx",
      "args": ["-y", "heyreach-mcp"],
      "env": {
        "HEYREACH_API_KEY": "${HEYREACH_API_KEY}"
      }
    }
  }
}
```

## Platform Requirements

| Tool | Minimum Version | Purpose |
|------|----------------|---------|
| Claude Code | Latest | AI agent, orchestration layer (recommended) |
| Node.js | 18+ | Runtime for optional npm CLI tools and MCP servers |
| Python | 3.10+ | Vault scripts, automation scripts |
| Obsidian | Latest | Vault UI, Dataview, community plugins (optional) |
| Git | 2.x+ | Version control, vault backup (optional) |
| n8n | Latest (Docker or Cloud) | Workflow automation, credential isolation (optional) |
| Docker | 20+ | Self-hosted n8n, local services (optional) |

## API Keys (add only what you use)

| Key | Used By | Where to Get |
|-----|---------|-------------|
| Anthropic API key | Claude Code | [console.anthropic.com](https://console.anthropic.com) |
| HeyReach API key | heyreach-cli, heyreach-mcp | HeyReach app, Settings > API |
| Gmail OAuth credentials | Morning brief workflow | Google Cloud Console |
| Google Calendar OAuth credentials | Morning brief workflow | Google Cloud Console |
| n8n webhook URLs | n8n-agent-cli | Your n8n instance, per-workflow |

## Setup Checklist

Run these verification commands after installing each dependency.

### 1. Node.js

```bash
node --version  # Should show v18.x or higher
npm --version   # Should show 9.x or higher
```

### 2. Python

```bash
python3 --version  # Should show 3.10+
```

### 3. heyreach-cli (optional)

```bash
npm i -g heyreach-cli
heyreach-cli --version
heyreach-cli campaigns list  # Verify API key works
```

### 4. n8n-agent-cli (optional)

```bash
npm i -g n8n-agent-cli
n8n-agent-cli --version
n8n-agent-cli list  # Show registered workflows
```

### 5. heyreach-mcp (optional)

```bash
# After adding to .claude/settings.json:
# Restart Claude Code, then verify MCP is loaded
claude mcp list  # Should show heyreach server
```

### 6. n8n (optional)

```bash
# Docker (self-hosted)
docker ps | grep n8n  # Should show running container

# Or verify cloud instance
curl -s https://your-instance.n8n.cloud/healthz
```

### 7. Obsidian (optional)

```bash
# Verify Obsidian CLI is available
Obsidian --version 2>/dev/null || echo "Obsidian CLI not found, ensure Obsidian is running"
```

### 8. Git (optional)

```bash
git --version
```

### 9. Environment Variables

```bash
# Verify .env is populated (does not print values)
[ -f .env ] && echo ".env exists" || echo "MISSING: copy .env.example to .env"
grep -c "=" .env  # Should match number of required vars
```

## Dependency Graph

```
Claude Code (orchestrator)
├── heyreach-cli ──> HeyReach API
├── heyreach-mcp ──> HeyReach API (via MCP protocol)
├── n8n-agent-cli ──> n8n instance ──> (any downstream API)
├── Obsidian vault (filesystem, optional)
│   ├── Dataview (pipeline queries)
│   └── Git plugin (auto-backup)
└── Python scripts (vault automation)
```
