# 13 — Claude Code cheat sheet

Use this as a quick reference once you've read the core docs.

## Core prompt patterns

| You want to... | Ask Claude Code this |
| -------------- | -------------------- |
| Understand a file | `Explain \`examples/python/todo_cli.py\` in 5 bullets.` |
| Find where something is defined | `Find where the todo item is marked complete.` |
| Make a safe plan first | `Plan the changes needed to add due dates. Do not edit anything yet.` |
| Implement a change | `Add due dates to the todo CLI and update the tests.` |
| Review code | `Review \`examples/python/todo_cli.py\` for bugs and design issues.` |
| Debug a failure | `Run the tests, explain the failure, and fix the bug.` |
| Edit documentation | `Rewrite \`README.md\` to make the setup steps clearer.` |

## Fast ways to point at context

| Input | What it does |
| ----- | ------------ |
| `` `path/to/file` `` | Mentions a path in plain text |
| `@path/to/file` | Attaches a file directly to your prompt |
| `/command` | Runs a slash command |
| Paste image | Lets Claude inspect a screenshot or diagram |

## Slash-command reminders

| Command | Use it for |
| ------- | ---------- |
| `/help` | See built-in commands |
| `/clear` | Clear the visible terminal session |
| `/explain-file <path>` | Summarise a file in this repo |
| `/git-summary` | Summarise uncommitted changes |
| `/changelog <version>` | Draft a changelog entry |

See [slash commands](04-slash-commands.md) for how commands are defined.

## Common request templates

### Explore

```text
Read `docs/08-mcp.md` and summarise the setup steps.
```

```text
Compare `docs/05-skills.md` and `docs/06-subagents.md`.
```

### Change code

```text
Add a `--json` flag to `examples/python/todo_cli.py`. Keep the change minimal and update any affected tests.
```

```text
Refactor this function for readability without changing behaviour.
```

### Validate work

```text
Run the relevant tests for the files you changed and explain any failures before fixing them.
```

```text
Review the diff and call out risks, missing tests, and edge cases.
```

## Permissions and safety

- Use **plan mode** when you want read-only analysis first.
- Be specific about scope: mention the files, commands, or tests you want touched.
- Ask Claude to explain risky commands before running them.
- Tighten broad shell permissions in `.claude/settings.json`.

See [permissions](03-permissions.md) and [plan mode](11-plan-mode.md).

## Keyboard shortcuts

| Keys | Action |
| ---- | ------ |
| `Shift+Tab` | Cycle permission modes |
| `Ctrl+R` | Search transcript |
| `Ctrl+L` | Clear screen |
| `/` | Open slash-command picker |
| `@` | Open file picker |
| `Esc` | Interrupt Claude mid-turn |

See [tips](12-tips.md) for more shortcuts and gotchas.

## Good habits

- Start with the outcome you want, not the tool you think Claude should use.
- Ask for a plan before large edits.
- Tell Claude to run targeted tests after changes.
- Mention constraints like "smallest possible change" or "do not rename files".
- When the repo has a `CLAUDE.md`, read it or ask Claude to follow it.

## Next references

- [01 — CLAUDE.md](01-claude-md.md)
- [03 — Permissions](03-permissions.md)
- [04 — Slash commands](04-slash-commands.md)
- [05 — Skills](05-skills.md)
- [06 — Subagents](06-subagents.md)
- [08 — MCP](08-mcp.md)
- [11 — Plan mode](11-plan-mode.md)
- [12 — Tips](12-tips.md)
