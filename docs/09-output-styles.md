# 09 — Output styles

Output styles change *how* Claude responds — its persona, its verbosity, the structure of its replies — without changing what tools or context are available. Useful when the same project gets used in different modes (e.g. learning vs. shipping).

## Setting an output style

In `settings.json`:

```json
{ "outputStyle": "default" }
```

Built-in styles include:

- `default` — concise, task-focused.
- `explanatory` — verbose, walks through reasoning. Good for learners.
- `learning` — explanatory plus inline comprehension checks.

You can switch live in a session with the `/output-style <name>` command.

## Custom styles

Drop a markdown file at `.claude/output-styles/<name>.md`:

```markdown
---
name: code-review
description: Terse, evidence-only review voice. No filler.
---

You are reviewing code. Respond in this format:

**Verdict:** approve | request-changes
**Findings:**
- `path:line` — one-sentence issue, one-sentence suggestion.

No preamble, no closing summary, no praise for working code.
```

Activate with `/output-style code-review`.

This repo ships exactly that style at [`.claude/output-styles/code-review.md`](../.claude/output-styles/code-review.md) — open it for a working reference.

## When to use a custom style

- Repos with a strict review or comms style guide.
- Teaching contexts where you want a particular voice.
- Demo recordings where consistency matters.

If the change is *task-specific* (e.g. "for this one PR, be terse"), prefer a slash command or just say so in the prompt. Use a saved style only when the voice should persist across many turns.

## Limits

Output styles change the assistant's voice, not its capabilities. Permissions, hooks, and MCP servers are unaffected. If you need different *behaviour* (e.g. read-only mode, no edits), that's [plan mode](11-plan-mode.md) or a [sub-agent](06-subagents.md), not an output style.
