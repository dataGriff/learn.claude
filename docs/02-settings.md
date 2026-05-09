# 02 — `settings.json`

`.claude/settings.json` configures Claude Code for this project. It's checked into git, so everyone working in the repo gets the same defaults.

## Where settings live

| File                              | Scope            | Committed? |
| --------------------------------- | ---------------- | ---------- |
| `~/.claude/settings.json`         | User (all repos) | No         |
| `.claude/settings.json`           | Project (shared) | Yes        |
| `.claude/settings.local.json`     | Project (you)    | No (gitignored) |

When the same key is defined in more than one file, the more specific scope wins: `settings.local.json` > `settings.json` > user settings.

## What you can set

The schema covers a lot, but the keys you'll touch most are:

```json
{
  "$schema": "https://json.schemastore.org/claude-code-settings.json",
  "permissions": { ... },          // see docs/03-permissions.md
  "hooks": { ... },                 // see docs/07-hooks.md
  "statusLine": { ... },            // see docs/10-status-line.md
  "outputStyle": "default",         // see docs/09-output-styles.md
  "env": { "EDITOR": "nvim" }       // env vars for tool calls
}
```

Always include the `$schema` line. Your editor will then autocomplete keys and flag typos.

## This repo's settings

See [`.claude/settings.json`](../.claude/settings.json). It enables:

- A small permissions block (read-only Bash like `ls`, `git status` are auto-allowed; `rm`/`git push` always ask).
- A status-line script defined in `.claude/hooks/status-line.sh`.
- A `SessionStart` hook that prints a one-line welcome.

## `settings.local.json`

Use this for things that should not be shared: machine-specific paths, secrets in `env`, personal permission relaxations. Keep it out of git — `.gitignore` already excludes it.

## Inspecting effective settings

Ask Claude "what settings are active in this session?" — it can read all three files and merge them mentally. The `/config` slash command (built-in) opens an interactive editor for the most common keys.
