# 01 — `CLAUDE.md`: project memory

`CLAUDE.md` is a markdown file Claude Code automatically loads at the start of every session inside the repo. Think of it as durable context — anything you'd otherwise paste into a prompt every time belongs here instead.

## When it loads

Claude looks for `CLAUDE.md` in three places, in this order:

1. **The current working directory** (project memory — checked into git, shared with your team).
2. **Each parent directory up to your home** (handy for monorepos with shared root context).
3. **`~/.claude/CLAUDE.md`** (personal memory — applies across every project).

All matching files are concatenated. Project memory wins the most reader-attention because it's closest to the task.

## What to put in it

Good `CLAUDE.md` content is **stable, non-obvious, and project-specific**:

- What the project is and who it's for.
- Conventions a fresh contributor wouldn't guess (file layout rules, naming, formatting).
- Build / test / lint commands.
- Pointers to deeper docs ("see `docs/...` for X").

Bad content is anything that changes per task, anything Claude can derive from the code itself, or boilerplate that bloats the file.

## Conventions in this repo

See the [`CLAUDE.md`](../CLAUDE.md) at the repo root. Note in particular:

- A short "About this repository" section so Claude knows the repo's purpose.
- A "Conventions" section with the rules that aren't visible from code alone.
- A "Useful commands" section listing the project's slash commands so Claude suggests them when relevant.

## Editing it

Treat `CLAUDE.md` like any other source file: edit, commit, review. Keep it short — every byte competes for attention. If a section grows past a screen, move the detail into a `docs/NN-*.md` file and link to it.

## Personal vs project memory

If you want personal preferences ("always run pytest with `-x`", "I prefer rye over poetry") that don't belong in a shared repo, put them in `~/.claude/CLAUDE.md`. They'll layer on top of any project memory.
