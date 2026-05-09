# 10 — Status line

The status line is the single line shown at the bottom of the Claude Code UI. By default it's minimal. You can replace it with the output of any command of your choosing.

## Configuring it

In `settings.json`:

```json
{
  "statusLine": {
    "type": "command",
    "command": ".claude/hooks/status-line.sh"
  }
}
```

The harness invokes the command on every refresh, pipes a JSON payload on stdin, and renders the first line of stdout.

## What's in the payload

Roughly:

```json
{
  "session_id": "...",
  "cwd": "/home/you/learn.claude",
  "workspace": { "current_dir": "/home/you/learn.claude" },
  "model": { "id": "claude-opus-4-7", "display_name": "Opus 4.7" },
  "transcript_path": "...",
  "cost": { "total_usd": 0.42 }
}
```

Field names occasionally evolve, so write your script defensively (`jq -r '.field // "fallback"'`).

## This repo's status line

[`.claude/hooks/status-line.sh`](../.claude/hooks/status-line.sh) prints `[<model>] <folder> on <branch>`. For example:

```
[Opus 4.7] learn.claude  on  claude/create-tutorial-repo-2gWlU
```

It uses `jq` if available, with a Python fallback.

## Writing your own

A few good things to surface:

- Current git branch (cheap; `git symbolic-ref --short HEAD`).
- Pending changes count (`git status --porcelain | wc -l`).
- Active python virtualenv or node version.
- Cumulative session cost from `.cost.total_usd`.

Keep the script fast — it runs on every redraw. Anything above ~50 ms will feel sluggish. If you need expensive data, cache it to `/tmp` and refresh on a timer.

## Testing locally

```bash
echo '{"workspace":{"current_dir":"'"$PWD"'"},"model":{"display_name":"Test"}}' \
  | .claude/hooks/status-line.sh
```

If your script errors, the harness falls back to the default — so check stderr if the line goes blank unexpectedly.
