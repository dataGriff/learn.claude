# 03 — Permissions

Claude Code asks before running anything that could change your machine. Permissions let you decide which tool calls are pre-approved, which always prompt, and which are forbidden outright.

## The three buckets

In `settings.json`:

```json
{
  "permissions": {
    "allow": ["Read", "Bash(ls *)", "Bash(git status*)"],
    "ask":   ["Bash(git push *)"],
    "deny":  ["Bash(rm -rf *)", "Bash(curl * | sh)"]
  }
}
```

- **`allow`** — runs without prompting.
- **`ask`** — Claude must ask you before each call (the default for tools not listed elsewhere).
- **`deny`** — refused unconditionally. Claude won't even ask.

`deny` always wins, then `allow`, then `ask`.

## Tool patterns

Each entry is either a tool name (`Read`, `Edit`, `Write`, `Grep`) or a tool with a parameter pattern in parentheses. The most useful pattern shape is `Bash(<glob>)`:

```
Bash(ls *)            # matches `ls`, `ls -la`, `ls foo/`
Bash(git status*)     # `git status`, `git status -s`
Bash(npm run test:*)  # `npm run test:unit`, `npm run test:e2e`
```

Globs are matched against the full command string. Be specific — `Bash(git *)` allows `git push --force` too.

## Choosing what to allow

Good defaults to pre-allow are **read-only** commands you run constantly: `ls`, `cat` (rare — Claude prefers `Read`), `git status`, `git diff`, `git log`, `rg`, `find`, `pytest`, `npm test`. Anything that writes to disk, the network, or git remotes deserves at least an `ask`.

If you're hitting a lot of permission prompts, the `fewer-permission-prompts` skill scans your recent transcripts and proposes a project allowlist.

## Per-machine relaxations

Want broader Bash access on your laptop without imposing it on teammates? Put it in `.claude/settings.local.json` (gitignored). The schemas merge.

## Permission modes

Claude Code can be launched in different permission modes (`--permission-mode default | acceptEdits | plan | bypassPermissions`). `plan` is read-only and is covered separately in [`docs/11-plan-mode.md`](11-plan-mode.md).
