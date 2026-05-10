# Exercise 02 — Add a guardrail hook

**Concept:** [`docs/07-hooks.md`](../docs/07-hooks.md)

## Goal

Add a `PreToolUse` hook that blocks any `Bash` call attempting to delete files *outside* the project directory, regardless of what the permissions allow.

This is a "belt and braces" example: even if a stray `Bash(rm *)` slips into your allowlist, the hook will refuse anything that touches paths above the project root.

## Steps

1. Create `.claude/hooks/guard-rm.sh`.
2. Make it executable: `chmod +x .claude/hooks/guard-rm.sh`.
3. The script should:
   - Read the JSON payload from stdin.
   - Extract `tool_input.command`.
   - If the command starts with `rm` and contains a path beginning with `/` that is not under `${CLAUDE_PROJECT_DIR}`, print a message to stderr and exit `2` (which blocks the call).
   - Otherwise exit `0`.
4. Wire it up in `.claude/settings.json` under `hooks.PreToolUse` with `matcher: "Bash"`.
5. Test it. In a Claude session, ask Claude to run `rm /tmp/some-file`. The hook should block it. Then ask Claude to run `rm ./scratch.txt`. The hook should let that pass (subject to the usual permission prompt).

## Acceptance

- The hook blocks `rm /etc/passwd` (and similar) with a useful stderr message.
- The hook does not block `rm` calls inside the project directory.
- The hook runs in well under 100 ms (use `time` to verify).

## Stretch

- Extend the hook to also block `mv`, `cp -f`, and `>` redirections that target paths outside the project.
- Log every block to `.claude/hooks/blocks.log` (gitignored) so you can audit how often it fires.
