# 04 — Slash commands

A slash command is a reusable prompt you can fire by typing `/<name>` in the Claude Code chat. They live as markdown files in `.claude/commands/` (project-scoped) or `~/.claude/commands/` (personal).

## Anatomy of a command

A command file is plain markdown with optional YAML frontmatter:

```markdown
---
description: Summarise a file in 4-6 bullet points
argument-hint: <path>
allowed-tools: ["Read", "Glob"]
---

Read the file at $ARGUMENTS and produce a 4-6 bullet summary covering:

- What this file is for
- Key exports / public API
- Anything surprising or non-obvious
```

When a learner types `/explain-file docs/00-overview.md`, Claude:

1. Loads the markdown body.
2. Substitutes `$ARGUMENTS` with `docs/00-overview.md`.
3. Sends the result as the next user message.

## Frontmatter fields

| Key             | Purpose                                                      |
| --------------- | ------------------------------------------------------------ |
| `description`   | Shown in the `/`-menu picker.                                 |
| `argument-hint` | Placeholder text after the command name.                      |
| `allowed-tools` | Restricts which tools Claude may use during the command.      |
| `model`         | Pin a specific model for this command (rare).                 |

Frontmatter is optional — a command file with only a body still works.

## Argument substitution

- `$ARGUMENTS` — everything the user typed after the command name.
- `$1`, `$2`, ... — positional words.

If you don't reference any of these, the command takes no arguments.

## Examples in this repo

- [`/explain-file`](../.claude/commands/explain-file.md) — file summariser.
- [`/git-summary`](../.claude/commands/git-summary.md) — uncommitted changes recap.
- [`/changelog`](../.claude/commands/changelog.md) — drafts a CHANGELOG entry.
- [`/review:code`](../.claude/commands/review/code.md) — delegates to the `code-reviewer` sub-agent. Note the `:` in the name — that's a slash in the path on disk (`commands/review/code.md`).

## When to use a command vs a skill

A slash command is a prompt **you trigger by name**. A [skill](05-skills.md) is a prompt Claude **chooses to invoke** when the situation matches. Use commands for things you do deliberately and frequently; use skills for things Claude should reach for on its own.
