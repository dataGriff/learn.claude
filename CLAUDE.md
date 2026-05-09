# CLAUDE.md

> This file is **project memory**. Claude Code automatically loads it at the start of every session in this repo. Use it to give Claude durable context: what the project is, conventions to follow, and instructions you don't want to repeat in every prompt.
>
> See [`docs/01-claude-md.md`](docs/01-claude-md.md) for the full walkthrough.

## About this repository

`learn.claude` is a **tutorial repo**. Its purpose is to teach Claude Code's capabilities by example. Every file under `.claude/` is a working artifact a learner can invoke. Every file under `docs/` is human-facing prose that explains one capability.

## Conventions to follow when editing

- **Don't move files between `docs/` and `.claude/`.** They serve different audiences: `docs/` is for humans reading; `.claude/` is for Claude executing.
- **Numbered docs are ordered.** Keep `docs/NN-name.md` numbered sequentially. New material goes at the end unless it logically belongs earlier.
- **Examples in `examples/` should be self-contained.** A learner should be able to read `examples/python/todo_cli.py` without context from elsewhere in the repo.
- **No emojis in committed files** unless the user has explicitly asked for them.
- **Prefer Markdown over HTML** in docs.

## Style

- Plain, direct prose. Second person ("you") when addressing the learner.
- Code blocks include a language hint (` ```python `, ` ```bash `, ` ```json `).
- File and directory references use backticks: `` `.claude/settings.json` ``.
- Cross-references are relative links: `[settings](docs/02-settings.md)`.

## Useful commands while working in this repo

- `/explain-file <path>` — summarise a file
- `/git-summary` — show a one-paragraph summary of uncommitted changes
- `/changelog <version>` — draft a changelog entry from recent commits
- `/review:code <path>` — code review via the `code-reviewer` sub-agent

(All defined under `.claude/commands/`.)

## When unsure

If a learner asks how a feature works, point them at the matching `docs/NN-*.md` file rather than reproducing the explanation inline.
