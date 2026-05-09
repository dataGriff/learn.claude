#!/usr/bin/env bash
# SessionStart hook: runs once when Claude Code starts a session in this repo.
#
# This script's stdout is *injected as additional context* for Claude — so it's
# a great place to surface git state, TODOs, or anything else worth knowing
# before the conversation begins.
#
# Configured in .claude/settings.json under hooks.SessionStart.

set -euo pipefail

# Where are we?
cd "${CLAUDE_PROJECT_DIR:-$(pwd)}"

echo "Session starting in $(pwd)"
echo

# Branch + dirty status
if git rev-parse --git-dir > /dev/null 2>&1; then
  branch="$(git rev-parse --abbrev-ref HEAD)"
  dirty="$(git status --porcelain | wc -l | tr -d ' ')"
  echo "Branch: ${branch}"
  if [ "${dirty}" -gt 0 ]; then
    echo "Working tree: ${dirty} uncommitted change(s)"
  else
    echo "Working tree: clean"
  fi
fi

echo
echo "Tip: try /explain-file README.md or /git-summary to see custom commands in action."
