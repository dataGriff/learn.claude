---
name: code-quality
description: Use when the user asks for code-quality feedback on a function, module, or PR. Looks for naming, single-responsibility, error-handling, and dead-code issues, and proposes concrete edits.
---

# Skill: code-quality

You have been invoked because a user wants feedback on code quality. Follow this checklist.

## 1. Read before judging

Read the file in full. If it imports siblings, skim those too — never critique a name without seeing how it's used.

## 2. Apply this rubric

| Aspect | Look for |
|--------|----------|
| **Naming** | Names match what the symbol does. No `data`, `info`, `helper`, `util` unless genuinely generic. |
| **Single responsibility** | Each function does one thing. Mixed concerns are flagged. |
| **Error handling** | Errors at boundaries; trust internal calls. No swallowed exceptions. |
| **Dead code** | Unused imports, unreachable branches, commented-out blocks. |
| **Comments** | Only where the *why* is non-obvious. Delete restated logic. |

## 3. Output format

```
### Findings

- **[severity]** `file.py:42` — short description, then proposed fix.
```

Severity is one of `critical`, `major`, `minor`, `nit`. Be honest: most code does not have critical issues.

## 4. Stop conditions

- If the file is under 30 lines and you find nothing actionable, say so plainly. Do not invent feedback.
- If you would propose more than ~7 edits, group them and ask the user which to apply first.
