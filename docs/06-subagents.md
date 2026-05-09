# 06 — Sub-agents

A sub-agent is a separate Claude conversation that the main session can delegate work to. The sub-agent has its own system prompt, its own tool allowlist, and its own context window. When it finishes, it returns a single message to the parent.

## Why bother

Three reasons to delegate:

1. **Context hygiene.** A search across hundreds of files would otherwise fill your main conversation with grep output. The sub-agent absorbs the noise and reports a summary.
2. **Specialisation.** A `code-reviewer` agent with read-only tools is safer than letting your main session also be a reviewer.
3. **Parallelism.** You can launch multiple sub-agents in one turn — independent investigations run concurrently.

## Defining an agent

Agents live in `.claude/agents/<name>.md`:

```markdown
---
name: code-reviewer
description: Use proactively for code reviews. Reads a file or diff, returns
  findings grouped by severity. Read-only — never edits.
tools: ["Read", "Grep", "Glob", "Bash(git diff *)", "Bash(git log *)"]
model: sonnet
---

You are a senior code reviewer. When invoked:

1. Read the target file or diff.
2. Group findings as **Blocking**, **Suggested**, **Nit**.
3. Quote the offending lines with `path:line` references.
4. Do not propose edits — only review.
```

Frontmatter keys:

| Key           | Purpose                                                           |
| ------------- | ----------------------------------------------------------------- |
| `name`        | Identifier used by the parent when delegating.                    |
| `description` | Used by Claude to decide *when* to delegate.                      |
| `tools`       | Allowlist for this agent. Omit to inherit the parent's tools.     |
| `model`       | Optional — override the model (e.g. `haiku` for cheap searches).  |

## Invoking from the main session

You usually don't have to ask. If the description matches the task, Claude will offer to spawn the agent. To force it, say "use the `code-reviewer` agent on `src/foo.ts`".

## Built-in agent types

Even with no custom agents, the harness ships a few defaults: `general-purpose`, `Explore` (fast read-only search), `Plan` (architect for implementation plans), `code-reviewer`, `doc-writer`, `test-runner`, and a couple more. They're listed in the Agent tool's docstring.

## Cost considerations

Each sub-agent is a separate context, so it's billed separately. For trivial searches, prefer the `Explore` agent or just a direct `grep`. Reserve heavyweight sub-agents for tasks that benefit from isolation.
