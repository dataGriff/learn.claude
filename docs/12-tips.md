# 12 — Tips, shortcuts, and gotchas

A grab-bag of things worth knowing once you're past the basics.

## Productivity

- **Reference files by path.** Typing `@docs/02-settings.md` in the prompt attaches the file inline. Faster than asking Claude to find it.
- **Image input.** Drag-and-drop a screenshot (or paste from the clipboard) and Claude will read it. Great for UI bug reports and diagrams.
- **Run things in parallel.** When you need several independent results — "run the tests and show me the lint errors" — Claude can do those in one turn. Just say so.
- **Plan before big edits.** A 30-second plan saves a 5-minute revert. Use [plan mode](11-plan-mode.md) or the `Plan` sub-agent.

## Shortcuts

| Keys              | Action                                       |
| ----------------- | -------------------------------------------- |
| `Shift+Tab`       | Cycle permission modes (default → plan → ...) |
| `Ctrl+R`          | Search the session transcript                 |
| `Ctrl+L`          | Clear the screen (transcript intact)          |
| `/`               | Open the slash-command picker                 |
| `@`               | Open the file picker                          |
| `Esc`             | Interrupt Claude mid-turn                     |

You can rebind anything in `~/.claude/keybindings.json` — see the `keybindings-help` skill.

## Gotchas

- **`Bash(git *)` is too permissive.** It allows `git push --force`. Always tighten Bash globs.
- **Hooks see *every* matching event.** A `PreToolUse` hook with `matcher: "*"` runs before every tool call — keep it fast.
- **MCP servers don't refresh on settings change.** After editing `mcpServers`, restart the Claude Code session (or use `/mcp` to reload).
- **`CLAUDE.md` is loaded once per session.** Edits during a session don't take effect until you restart or run `/memory reload` (when available).
- **`settings.local.json` shadows `settings.json`.** If a setting "isn't taking effect", check whether your local file is overriding it.

## Where to go next

- `/help` — built-in help.
- `https://github.com/anthropics/claude-code/issues` — bug reports and feature requests.
- `https://docs.claude.com/en/docs/claude-code` — the official Claude Code documentation.

If something in this tutorial repo is wrong, out of date, or unclear, open an issue. The repo is meant to evolve.
