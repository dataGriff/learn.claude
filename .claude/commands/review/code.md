---
description: Review code at a path via the code-reviewer sub-agent
argument-hint: <path>
---

Delegate a thorough code review of `$ARGUMENTS` to the **code-reviewer** sub-agent.

The sub-agent should look for:

- Correctness bugs and edge cases the author missed
- Security issues (injection, secrets, unsafe deserialisation)
- Readability and naming problems
- Tests that are missing or weak
- Style violations against the conventions in `CLAUDE.md`

Return the review as a Markdown report, grouped by severity (**critical**, **major**, **minor**, **nit**). Include file:line references for every finding.

> This command lives in a subdirectory (`.claude/commands/review/`) so it shows up as `/review:code`. That's the namespacing convention — see [`docs/04-slash-commands.md`](../../../docs/04-slash-commands.md).
