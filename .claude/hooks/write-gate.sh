#!/bin/bash
# write-gate.sh — two-level write gate enforcement
#
# Level 1 (Vault-level): Blocks ALL writes until Required Sources from
#   ROOT-INDEX.md are loaded. This ensures global context (positioning,
#   ICP, brand voice) is always present before any output is generated.
#
# Level 2 (Entity-level): When writing to entity subfolders (prospects/,
#   customers/, deals/), also requires that the specific entity's context.md
#   has been read this session.

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
if [[ "$REL_PATH" == .session/* ]] || [[ "$REL_PATH" == .git/* ]] || [[ "$REL_PATH" == .claude/* ]]; then
  exit 0
fi

# ═══════════════════════════════════════════════════════════
# LEVEL 1: Vault-level gate (ROOT-INDEX.md Required Sources)
# ══════════════════════════════════════════��════════════════

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
      echo "[WRITE GATE] Write BLOCKED. Vault-level required sources not yet loaded:" >&2
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

# ═══════════════════════════════════════════════════════════
# LEVEL 2: Entity-level gate (entity context.md)
# ═══════════════════════════════════════════════════════════

# Entity folders that require context.md loading before writes
ENTITY_DIRS="prospects customers deals"

for entity_dir in $ENTITY_DIRS; do
  if [[ "$REL_PATH" == *${entity_dir}/* ]]; then
    # Extract the entity name (subfolder after the entity dir)
    AFTER_DIR="${REL_PATH#*${entity_dir}/}"
    ENTITY_NAME=$(echo "$AFTER_DIR" | cut -d'/' -f1)

    if [[ -z "$ENTITY_NAME" ]]; then
      break
    fi

    # Find the entity dir prefix in the relative path
    ENTITY_PREFIX="${REL_PATH%%${entity_dir}/*}${entity_dir}"

    # The file being written might BE the context.md itself, allow that
    CONTEXT_FILE="${ENTITY_PREFIX}/${ENTITY_NAME}/context.md"
    if [[ "$REL_PATH" == "$CONTEXT_FILE" ]]; then
      break
    fi

    # Check if this entity even has a context.md
    CONTEXT_FULL_PATH="$VAULT_ROOT/$CONTEXT_FILE"
    if [[ ! -f "$CONTEXT_FULL_PATH" ]]; then
      echo "[WRITE GATE WARNING] No context.md found at ${CONTEXT_FILE}. Entity-level gate skipped." >&2
      break
    fi

    # Check if context.md has been loaded this session
    if [[ ! -f "$LOADED_FILE" ]] || ! grep -qF "$CONTEXT_FILE" "$LOADED_FILE"; then
      echo "[WRITE GATE] Write BLOCKED. Entity context not loaded." >&2
      echo "" >&2
      echo "  Writing to: $REL_PATH" >&2
      echo "  Required:   $CONTEXT_FILE" >&2
      echo "" >&2
      echo "Read the entity's context.md first, then retry the write." >&2
      exit 1
    fi

    break
  fi
done

exit 0
