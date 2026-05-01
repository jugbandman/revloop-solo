# Credential Setup

Step-by-step guide for configuring credentials the revloop-solo system may use. Set up only the sections that apply to your toolchain.

## 1. Create .env from Template

```bash
cp .env.example .env
```

Open `.env` in your editor and fill in each value as you complete the steps below.

**Verify it's gitignored:**

```bash
git check-ignore .env  # Should print ".env"
```

## 2. Anthropic API Key (Claude Code)

Claude Code uses the Anthropic API for all AI operations.

1. Go to [console.anthropic.com](https://console.anthropic.com)
2. Navigate to API Keys
3. Create a new key (name it something like "revloop-claude-code")
4. Copy the key (starts with `sk-ant-`)
5. Add to `.env`:

```
ANTHROPIC_API_KEY=sk-ant-your-key-here
```

**Verify:**

```bash
claude --version  # Claude Code should be installed and configured
```

Note: Claude Code may also use its own config at `~/.claude/` for the API key. Check Claude Code docs for the preferred method.

## 3. n8n Setup (optional)

n8n handles workflow automation and acts as the credential isolation layer.

### Option A: Docker (Self-Hosted, Recommended)

```bash
docker run -d \
  --name n8n \
  -p 5678:5678 \
  -v n8n_data:/home/node/.n8n \
  n8nio/n8n
```

Open http://localhost:5678 and complete the setup wizard. Create your first workflow with a Webhook trigger node and copy the webhook URL.

### Option B: n8n Cloud

1. Sign up at [n8n.io](https://n8n.io)
2. Create a new workflow with a Webhook trigger node
3. Copy the production webhook URL

### Configure n8n-agent-cli

1. Add your n8n instance URL to `.env`:

```
N8N_BASE_URL=http://localhost:5678
```

2. Register webhook URLs for each workflow:

```bash
n8n-agent-cli register --name "enrich-lead" --url "https://your-n8n-instance/webhook/abc123"
n8n-agent-cli list  # Verify registered workflows
```

### Store Credentials in n8n

For the zero-trust pattern, add API credentials to n8n's built-in credential store (not in .env):

1. In n8n UI, go to Credentials
2. Add credentials for each service your workflows call (e.g., Slack, email providers, CRM APIs)
3. Reference these credentials in your workflow nodes

## 4. Gmail and Google Calendar OAuth (optional)

Used for the morning brief workflow (email summaries, calendar review).

### Google Cloud Console Setup

1. Go to [console.cloud.google.com](https://console.cloud.google.com)
2. Create a new project (or use an existing one)
3. Enable these APIs:
   - Gmail API
   - Google Calendar API
4. Go to **Credentials** > **Create Credentials** > **OAuth 2.0 Client ID**
5. Application type: **Desktop app**
6. Download the credentials JSON file

### OAuth Scopes Needed

| API | Scope | Purpose |
|-----|-------|---------|
| Gmail | `gmail.readonly` | Read emails for morning brief |
| Calendar | `calendar.readonly` | Read calendar events for daily planning |

### Configure

1. Place the downloaded credentials file:

```bash
mkdir -p ~/.google_workspace_mcp/credentials
mv ~/Downloads/client_secret_*.json ~/.google_workspace_mcp/credentials/credentials.json
```

2. Add to `.env`:

```
GOOGLE_CREDENTIALS_DIR=~/.google_workspace_mcp/credentials
```

3. Run the OAuth flow (first time only):

The specific auth flow depends on which tool consumes the Google APIs. Follow the tool's documentation. Typically:

```bash
# The tool will open a browser for OAuth consent
# After authorizing, a token file is saved locally
```

4. Verify:

```bash
# Check that token files exist
ls ~/.google_workspace_mcp/credentials/
# Should show: credentials.json, token.json (after first auth)
```

## 5. Generic MCP Server Pattern

For any MCP server you add, the pattern is:

1. Add the server to `.claude/settings.json` under `mcpServers`
2. Pass credentials via environment variables (never hardcode in settings.json)
3. Restart Claude Code and verify with `claude mcp list`

Example:

```json
{
  "mcpServers": {
    "my-service": {
      "command": "npx",
      "args": ["-y", "my-service-mcp"],
      "env": {
        "MY_SERVICE_API_KEY": "${MY_SERVICE_API_KEY}"
      }
    }
  }
}
```

## Post-Setup Verification

After completing all steps, run through the checklist for what you've installed:

```bash
# Claude Code configured
claude --version

# MCP servers loaded (if any configured)
claude mcp list

# Environment complete
grep -c "=" .env  # Should match expected count

# No secrets exposed
git check-ignore .env
git status  # .env should NOT appear as untracked
```

## Troubleshooting

**"Command not found" for any CLI tool:**
Ensure Node.js 18+ is installed and the global npm bin directory is in your PATH.

```bash
npm config get prefix  # Check global install location
echo $PATH  # Verify it includes the npm bin dir
```

**n8n webhook returns 404:**
Verify the workflow is active (not just saved as draft). Production webhook URLs only work when the workflow is activated.

**MCP server not appearing in Claude Code:**
Check `.claude/settings.json` for syntax errors. Restart Claude Code after changes. Verify the required environment variables are set.
