#!/usr/bin/env bash
# PostToolUse hook: appends a one-line audit entry every time Claude edits or writes a file.
#
# Hooks receive a JSON payload on stdin describing the tool call. We extract the
# file path with a small jq fallback (or python if jq isn't installed).
#
# Output: a line in .claude/hooks/edits.log (gitignored).
# Configured in .claude/settings.json under hooks.PostToolUse.

set -euo pipefail

LOG="${CLAUDE_PROJECT_DIR:-$(pwd)}/.claude/hooks/edits.log"

# Read the JSON payload from stdin.
payload="$(cat)"

# Try jq first, fall back to python.
if command -v jq > /dev/null 2>&1; then
  tool="$(echo "${payload}" | jq -r '.tool_name // "unknown"')"
  path="$(echo "${payload}" | jq -r '.tool_input.file_path // .tool_input.path // "unknown"')"
else
  tool="$(echo "${payload}" | python3 -c 'import json,sys; d=json.load(sys.stdin); print(d.get("tool_name","unknown"))')"
  path="$(echo "${payload}" | python3 -c 'import json,sys; d=json.load(sys.stdin); ti=d.get("tool_input",{}); print(ti.get("file_path", ti.get("path","unknown")))')"
fi

mkdir -p "$(dirname "${LOG}")"
printf '%s  %-6s  %s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)" "${tool}" "${path}" >> "${LOG}"

# Hooks must exit 0 unless they want to block the action (exit 2 = block + send stderr to Claude).
exit 0
