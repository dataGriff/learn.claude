#!/usr/bin/env bash
# Status line hook: prints a single line shown at the bottom of the Claude Code UI.
#
# Claude pipes a JSON payload on stdin describing the current session
# (workspace, model, cost, etc.). We pull a few useful fields and print
# one line. See docs/10-status-line.md for the full payload schema.

set -euo pipefail

payload="$(cat)"

if command -v jq > /dev/null 2>&1; then
  cwd="$(echo "${payload}" | jq -r '.workspace.current_dir // .cwd // "."')"
  model="$(echo "${payload}" | jq -r '.model.display_name // .model.id // "claude"')"
else
  cwd="$(echo "${payload}" | python3 -c 'import json,sys; d=json.load(sys.stdin); print(d.get("workspace",{}).get("current_dir") or d.get("cwd","."))')"
  model="$(echo "${payload}" | python3 -c 'import json,sys; d=json.load(sys.stdin); m=d.get("model",{}); print(m.get("display_name") or m.get("id","claude"))')"
fi

branch="$(git -C "${cwd}" symbolic-ref --short HEAD 2>/dev/null || echo 'no-git')"
folder="$(basename "${cwd}")"

printf '[%s] %s  on  %s\n' "${model}" "${folder}" "${branch}"
