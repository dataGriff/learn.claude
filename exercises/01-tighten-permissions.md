# Exercise 01 — Tighten permissions

**Concept:** [`docs/03-permissions.md`](../docs/03-permissions.md)

## Goal

Audit the `permissions` block in `.claude/settings.json` and tighten any Bash globs that are looser than they need to be. The end state: every `allow` entry is the *narrowest* pattern that still covers the read-only commands you actually want pre-approved.

## Steps

1. Open `.claude/settings.json` and read the current `permissions.allow` and `permissions.deny` lists.
2. For each `Bash(...)` entry under `allow`, ask: *what is the most destructive command this glob would also let through?* Write the answer in a comment (or a scratch note) for each.
3. Replace any over-broad pattern with a tighter one. Examples of common too-loose patterns:
   - `Bash(git *)` — also matches `git push --force`. Tighten to specific subcommands.
   - `Bash(npm *)` — also matches `npm publish`.
   - `Bash(ls *)` — usually fine, but consider `Bash(ls)`, `Bash(ls -la)`, `Bash(ls *)` is reasonable since `ls` is read-only by definition.
4. Add a `deny` entry for at least one obviously-destructive pattern (e.g. `Bash(rm -rf /*)`, `Bash(curl * | sh)`).
5. Save, then start a fresh Claude session and try a few commands to confirm the right ones still auto-allow and the right ones now prompt.

## Acceptance

- No `Bash(...)` allow entry would silently permit a destructive subcommand.
- At least one `deny` entry exists.
- Read-only operations you use frequently still auto-approve.

## Stretch

- Run the bundled `fewer-permission-prompts` skill and compare its proposed allowlist with yours.
- Move personal-only relaxations (e.g. `Bash(docker *)` on your laptop) into `.claude/settings.local.json`.
