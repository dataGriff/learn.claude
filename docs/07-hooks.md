# 07 — Hooks

Hooks are shell commands the Claude Code harness runs at specific lifecycle events. They're how you make things happen *automatically* — not because Claude decided to, but because the harness fired the event.

## Lifecycle events

| Event                | Fires when                                                |
| -------------------- | --------------------------------------------------------- |
| `SessionStart`       | A new Claude Code session begins.                          |
| `UserPromptSubmit`   | The user submits a prompt (before Claude sees it).         |
| `PreToolUse`         | Claude is about to call a tool.                            |
| `PostToolUse`        | A tool call has just returned.                             |
| `Stop`               | Claude has finished its turn.                              |
| `SubagentStop`       | A sub-agent has finished.                                  |

## Configuring a hook

In `settings.json`:

```json
{
  "hooks": {
    "SessionStart": [
      { "matcher": "*", "hooks": [{ "type": "command", "command": ".claude/hooks/session-start.sh" }] }
    ],
    "PreToolUse": [
      { "matcher": "Bash", "hooks": [{ "type": "command", "command": ".claude/hooks/pre-bash.sh" }] }
    ]
  }
}
```

The `matcher` filters by tool name (or `*` for all). Each event can have multiple hook scripts.

## What the hook receives

The harness pipes a JSON payload on stdin. Typical fields:

```json
{
  "session_id": "...",
  "cwd": "/home/you/project",
  "tool_name": "Bash",
  "tool_input": { "command": "rm -rf /" }
}
```

Read it with `jq` or your language of choice.

## What the hook can do

- **Exit 0** — silent success, Claude continues.
- **Exit non-zero with stderr output** — the message is shown to Claude as a tool error. For `PreToolUse`, this *blocks* the call.
- **Print to stdout** — added to the conversation as feedback (visible to both you and Claude).

This makes hooks great for guardrails: a `PreToolUse` script can refuse `rm -rf` outside the workspace, or auto-format files after every `Edit` via `PostToolUse`.

## Examples in this repo

- [`.claude/hooks/session-start.sh`](../.claude/hooks/session-start.sh) — a `SessionStart` hook. Its stdout is *injected as additional context* for Claude, so it's a good place to surface git state or pending TODOs at the top of every session.
- [`.claude/hooks/log-edits.sh`](../.claude/hooks/log-edits.sh) — a `PostToolUse` hook that appends a one-line audit entry to `.claude/hooks/edits.log` (gitignored) every time Claude edits or writes a file. Read it as a reference for parsing the `tool_input` payload.
- [`.claude/hooks/status-line.sh`](../.claude/hooks/status-line.sh) — see [`docs/10-status-line.md`](10-status-line.md). (The status line is technically a separate `statusLine` config, not the `hooks` block — but it follows the same stdin-JSON pattern.)

For a hands-on exercise, see [`exercises/02-add-a-hook.md`](../exercises/02-add-a-hook.md): write a `PreToolUse` guardrail that blocks `rm` calls outside the project directory.

## Debugging

If a hook misbehaves, run it manually with a sample payload:

```bash
echo '{"cwd":"'"$PWD"'"}' | .claude/hooks/your-hook.sh
```

The harness logs hook stderr to the session transcript — check there if a hook silently fails.
