#!/usr/bin/env bash
# write-gate.sh — vault-level write gate enforcement
#
# Blocks writes until Required Sources from ROOT-INDEX.md are loaded.
# This ensures global context (positioning, ICP, brand voice) is always
# present before any output is generated.
#
# Entity-level gate (requiring per-entity context.md before entity writes)
# was removed in v0.2.0 — solo template is single-operator, no team mode.
#
# Graceful degradation: no-op if not running under Claude Code.

if [ -z "$CLAUDE_PROJECT_DIR" ] && [ -z "$CLAUDE_CODE_SESSION" ]; then
  exit 0
fi

TOOL_INPUT=$(cat)
VAULT_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
SESSION_DIR="$VAULT_ROOT/.session"
LOADED_FILE="$SESSION_DIR/loaded-sources.txt"
ROOT_INDEX="$VAULT_ROOT/ROOT-INDEX.md"

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

# Never gate writes to session state, git internals, or hook config
REL_PATH="${FILE_PATH#$VAULT_ROOT/}"
if [[ "$REL_PATH" == .session/* ]] || [[ "$REL_PATH" == .git/* ]] || [[ "$REL_PATH" == .claude/* ]] || [[ "$REL_PATH" == .revloop/* ]]; then
  exit 0
fi

# ═══════════════════════════════════════════════════════════
# Vault-level gate (ROOT-INDEX.md Required Sources)
# ═══════════════════════════════════════════════════════════

if [[ -f "$ROOT_INDEX" ]]; then
  # Extract required files (lines under ## Required Sources, stop at next ##)
  REQUIRED=$(sed -n '/^## Required Sources/,/^## /p' "$ROOT_INDEX" | grep "^- " | sed 's/^- //' | sed 's/ *$//')

  if [[ -n "$REQUIRED" ]]; then
    MISSING=()
    while IFS= read -r required_file; do
      if [[ ! -f "$LOADED_FILE" ]] || ! grep -qF "$required_file" "$LOADED_FILE"; then
        MISSING+=("$required_file")
      fi
    done <<< "$REQUIRED"

    if [[ ${#MISSING[@]} -gt 0 ]]; then
      echo "[WRITE GATE] Write BLOCKED. Required sources not yet loaded:" >&2
      for f in "${MISSING[@]}"; do
        echo "  - $f" >&2
      done
      echo "" >&2
      echo "Read these files from context/ first, then retry the write." >&2
      echo "These are listed in ROOT-INDEX.md under Required Sources." >&2
      exit 1
    fi
  fi
fi

exit 0
