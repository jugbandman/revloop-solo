#!/usr/bin/env bash
# post-read.sh — tracks loaded source files for write gate enforcement
#
# Runs after every successful Read. Logs the basename, full path, and
# relative path so the sacred-sources list can match either form.
#
# Graceful degradation: no-op if not running under Claude Code.

if [ -z "$CLAUDE_PROJECT_DIR" ] && [ -z "$CLAUDE_CODE_SESSION" ]; then
  exit 0
fi

TOOL_INPUT=$(cat)
VAULT_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
SESSION_DIR="$VAULT_ROOT/.session"
LOADED_FILE="$SESSION_DIR/loaded-sources.txt"

FILE_PATH=$(echo "$TOOL_INPUT" | python3 -c "
import sys, json
data = json.load(sys.stdin)
path = data.get('path') or data.get('file_path') or ''
print(path)
" 2>/dev/null)

if [[ -z "$FILE_PATH" ]]; then
  exit 0
fi

# Only track files inside this vault
if [[ "$FILE_PATH" != "$VAULT_ROOT"* ]]; then
  exit 0
fi

# Ensure session directory exists
mkdir -p "$SESSION_DIR"

# Log basename (for sacred-sources matching) and full + relative path
BASENAME=$(basename "$FILE_PATH")
REL_PATH="${FILE_PATH#$VAULT_ROOT/}"

# Avoid duplicate entries
if [[ -f "$LOADED_FILE" ]]; then
  grep -qxF "$BASENAME" "$LOADED_FILE" 2>/dev/null || echo "$BASENAME" >> "$LOADED_FILE"
  grep -qxF "$FILE_PATH" "$LOADED_FILE" 2>/dev/null || echo "$FILE_PATH" >> "$LOADED_FILE"
  grep -qxF "$REL_PATH" "$LOADED_FILE" 2>/dev/null || echo "$REL_PATH" >> "$LOADED_FILE"
else
  echo "$BASENAME" >> "$LOADED_FILE"
  echo "$FILE_PATH" >> "$LOADED_FILE"
  echo "$REL_PATH" >> "$LOADED_FILE"
fi

exit 0
