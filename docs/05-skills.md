# 05 — Skills

A skill is a bundle of instructions Claude can choose to invoke when a task matches its description. Where a [slash command](04-slash-commands.md) waits for you to type `/name`, a skill activates by itself when its trigger phrase fits.

## Where skills live

```
.claude/skills/<skill-name>/SKILL.md       # project-scoped
~/.claude/skills/<skill-name>/SKILL.md     # personal
```

A skill is always a directory containing a `SKILL.md`, plus any extra files the skill needs (templates, reference data, helper scripts).

## `SKILL.md` structure

```markdown
---
name: api-tester
description: Use when the user wants to exercise an HTTP API — sanity-check
  endpoints, generate test cases, or write integration tests against a base
  URL. Produces curl commands and assertions, never makes network calls itself.
---

# API tester

When invoked:

1. Ask for the base URL and one example endpoint if not supplied.
2. Produce a checklist of cases (happy path, auth, 4xx, 5xx, pagination).
3. Output runnable `curl` commands plus expected assertions.
```

The `description` is the most important field. Claude reads it to decide whether to invoke the skill, so write it like a job posting: *what triggers it*, *what it does*, *what it doesn't do*.

## Auto-invocation

Skills are *not* injected into the system prompt. Their names and descriptions are listed; the body loads only when Claude calls the skill. That keeps the context window clean even with dozens of skills installed.

## Bundled assets

Anything next to `SKILL.md` is available to the skill's body via relative paths. A `templates/` folder, a JSON schema, even a small Python helper — all fair game.

## Skill vs sub-agent

Skills run **in the main Claude conversation** — they steer the existing assistant. [Sub-agents](06-subagents.md) spin up a **separate conversation** with its own tool set. Reach for a skill when you want to nudge behaviour; reach for a sub-agent when you want isolation or a different model.

## Examples to study

The repo's skills live under `.claude/skills/`. Open any `SKILL.md` and read the description first — you'll see how triggers are phrased to be specific without being brittle.
