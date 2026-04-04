#!/bin/bash
# pre-tool.sh — session lock on first file access (vault-level)
#
# Locks session on first file access inside the vault, ensuring
# .session/ state is initialized for the write gate and source tracker.

TOOL_INPUT=$(cat)
VAULT_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
SESSION_DIR="$VAULT_ROOT/.session"
LOCK_FILE="$SESSION_DIR/locked-client.txt"

# Extract the file path from the tool call
FILE_PATH=$(echo "$TOOL_INPUT" | python3 -c "
import sys, json
data = json.load(sys.stdin)
path = data.get('path') or data.get('file_path') or data.get('filename') or ''
print(path)
" 2>/dev/null)

# Only enforce on paths inside this vault
if [[ "$FILE_PATH" != "$VAULT_ROOT"* ]]; then
  exit 0
fi

# Ensure session directory exists
mkdir -p "$SESSION_DIR"

# Lock session on first vault file access
if [[ ! -f "$LOCK_FILE" ]]; then
  VAULT_NAME=$(basename "$VAULT_ROOT")
  echo "$VAULT_NAME" > "$LOCK_FILE"
  echo "[ISOLATION HOOK] Session locked to vault: $VAULT_NAME" >&2
fi

exit 0
