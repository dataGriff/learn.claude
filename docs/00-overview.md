# 00 — Overview

Welcome to `learn.claude`. This repo is a hands-on tour of Claude Code — Anthropic's CLI for working with Claude in your terminal. Every doc in this folder pairs with a working artifact under `.claude/` or `examples/` that you can invoke yourself.

## What Claude Code is

Claude Code runs an interactive Claude session inside your shell. It reads files, runs commands, edits code, and uses tools — all in your project's working directory. You drive it with natural language. It drives the codebase through a small set of built-in tools (Read, Edit, Bash, Grep, ...) plus anything you wire up via hooks, slash commands, sub-agents, and MCP servers.

## How this repo is laid out

```
.claude/        Working artifacts: settings, commands, agents, hooks, skills
docs/           One markdown file per capability (you are here)
examples/       Self-contained code samples used by the docs
CLAUDE.md       Project memory loaded automatically at session start
```

`docs/` is for humans. `.claude/` is for Claude. The two never overlap in purpose — see `CLAUDE.md` for the rule.

## Suggested reading order

The numbering reflects a learning path. Skim in order if it's your first pass:

1. [`01-claude-md.md`](01-claude-md.md) — project memory
2. [`02-settings.md`](02-settings.md) — `settings.json`
3. [`03-permissions.md`](03-permissions.md) — allow / ask / deny
4. [`04-slash-commands.md`](04-slash-commands.md) — your own `/commands`
5. [`05-skills.md`](05-skills.md) — auto-invoked instructions
6. [`06-subagents.md`](06-subagents.md) — delegating to specialists
7. [`07-hooks.md`](07-hooks.md) — lifecycle scripts
8. [`08-mcp.md`](08-mcp.md) — external tools via MCP
9. [`09-output-styles.md`](09-output-styles.md) — change Claude's voice
10. [`10-status-line.md`](10-status-line.md) — bottom-bar customisation
11. [`11-plan-mode.md`](11-plan-mode.md) — read-only planning
12. [`12-tips.md`](12-tips.md) — productivity tips and gotchas
13. [`13-cheat-sheet.md`](13-cheat-sheet.md) — quick-reference prompts and shortcuts

## Trying things out

After cloning, run `claude` from the repo root and ask: "what slash commands are available here?" Claude will read `CLAUDE.md`, discover `.claude/commands/`, and list them. From there, `/explain-file docs/00-overview.md` is a good first command to try.
