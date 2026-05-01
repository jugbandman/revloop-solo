#!/usr/bin/env bash
# health-check.sh - Vault integrity report for revloop-solo
#
# Checks:
#   - claude CLI installed
#   - git installed
#   - USER.md exists and differs from USER.md.example
#   - Required 60-Context/ files exist and lack placeholder markers
#   - .revloop/onboarding.json exists
#   - .env file exists
#   - .claude/hooks/*.sh are executable
#
# Usage:
#   bash 90-System/scripts/health-check.sh
#   ./90-System/scripts/health-check.sh

set -uo pipefail

# Resolve vault root (two levels up from 90-System/scripts/)
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
VAULT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

ISSUES=0

echo ""
echo "========================================"
echo "  RevLoop Solo Health Check"
echo "  $(date +%Y-%m-%d)"
echo "========================================"
echo ""

# ── 1. CLI tools installed ──

echo "--- CLI Tools ---"

if command -v claude &>/dev/null; then
    echo "  ✓ claude CLI installed"
else
    echo "  ⚠ claude CLI not found — install from https://claude.ai/download"
fi

if command -v git &>/dev/null; then
    echo "  ✓ git installed"
else
    echo "  ⚠ git not found — install git before proceeding"
fi
echo ""

# ── 2. USER.md exists and differs from example ──

echo "--- USER.md Setup ---"

USER_FILE="$VAULT_ROOT/USER.md"
USER_EXAMPLE="$VAULT_ROOT/USER.md.example"

if [ ! -f "$USER_FILE" ]; then
    echo "  ✗ USER.md missing — copy USER.md.example and fill in your details"
    ISSUES=$((ISSUES + 1))
elif [ -f "$USER_EXAMPLE" ] && cmp -s "$USER_FILE" "$USER_EXAMPLE"; then
    echo "  ✗ USER.md is unchanged from USER.md.example — fill in your details"
    ISSUES=$((ISSUES + 1))
else
    echo "  ✓ USER.md exists and has been customized"
fi
echo ""

# ── 3. Required 60-Context/ files ──

echo "--- Required Context Files ---"

REQUIRED_FILES=("positioning.md" "icp.md" "brand-voice.md" "offerings.md" "competitors.md")
CTX_DIR="$VAULT_ROOT/60-Context"
MISSING_REQ=0

for req in "${REQUIRED_FILES[@]}"; do
    filepath="$CTX_DIR/$req"
    if [ ! -f "$filepath" ]; then
        echo "  ✗ MISSING: 60-Context/$req"
        MISSING_REQ=$((MISSING_REQ + 1))
    else
        if grep -qE '\{add value\}|\{add date\}' "$filepath" 2>/dev/null; then
            echo "  ⚠ 60-Context/$req contains placeholder markers (fill in before use)"
        else
            echo "  ✓ 60-Context/$req"
        fi
    fi
done

if [ "$MISSING_REQ" -gt 0 ]; then
    ISSUES=$((ISSUES + MISSING_REQ))
fi
echo ""

# ── 4. .revloop/onboarding.json ──

echo "--- Onboarding State ---"

ONBOARDING_FILE="$VAULT_ROOT/.revloop/onboarding.json"

if [ -f "$ONBOARDING_FILE" ]; then
    echo "  ✓ .revloop/onboarding.json exists"
else
    echo "  ⚠ Run /start to initialize"
fi
echo ""

# ── 5. .env file ──

echo "--- Environment ---"

ENV_FILE="$VAULT_ROOT/.env"

if [ -f "$ENV_FILE" ]; then
    echo "  ✓ .env file exists"
else
    echo "  ⚠ .env file not found — some integrations may not work"
fi
echo ""

# ── 6. .claude/hooks/*.sh executability ──

echo "--- Claude Hooks ---"

HOOKS_DIR="$VAULT_ROOT/.claude/hooks"
HOOK_ISSUES=0

if [ -d "$HOOKS_DIR" ]; then
    found_any=0
    for hook in "$HOOKS_DIR"/*.sh; do
        [ -f "$hook" ] || continue
        found_any=1
        if [ ! -x "$hook" ]; then
            echo "  ✗ NOT EXECUTABLE: $(basename "$hook") — run: chmod +x $hook"
            HOOK_ISSUES=$((HOOK_ISSUES + 1))
        else
            echo "  ✓ $(basename "$hook")"
        fi
    done
    if [ "$found_any" -eq 0 ]; then
        echo "  ✓ No hooks found (none required)"
    elif [ "$HOOK_ISSUES" -eq 0 ]; then
        echo "  ✓ All hooks are executable"
    fi
else
    echo "  ✓ No .claude/hooks directory (none required)"
fi

ISSUES=$((ISSUES + HOOK_ISSUES))
echo ""

# ── Final Verdict ──

echo "========================================"
if [ "$ISSUES" -eq 0 ]; then
    echo "  ✓ HEALTHY: No blocking issues found."
else
    echo "  ✗ $ISSUES blocking issue(s) detected — see above."
fi
echo "========================================"
echo ""
