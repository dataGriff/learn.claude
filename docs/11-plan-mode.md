# 11 — Plan mode

Plan mode is a read-only Claude Code mode. Claude can investigate the codebase — read files, run searches, ask clarifying questions — but cannot edit, write, or run state-changing commands until you approve a concrete plan.

## When to use it

- Risky or large-scale changes where you want a written plan before execution.
- Unfamiliar codebases — let Claude map the territory before touching it.
- Refactors that span many files: review the plan once, then accept.
- Any time you'd otherwise say "describe what you'd do, but don't do it yet".

## Entering plan mode

- Launch with `claude --permission-mode plan`.
- Or, mid-session, press the dedicated keybinding (default **Shift+Tab** cycles modes) until the mode indicator says `plan`.

While in plan mode, the Edit, Write, and most Bash variants are blocked at the harness layer. Read, Grep, Glob, and read-only Bash still work.

## Exiting with a plan

Plan mode introduces one extra tool: `ExitPlanMode`. Claude calls it when it's ready to switch from planning to doing. The tool surfaces the plan to you and asks for approval. If you accept, the session continues in normal mode and Claude executes the plan. If you reject, you stay in plan mode — give feedback and Claude will revise.

## Writing a good plan

A useful plan in this repo's style includes:

1. **Goal** — one sentence on the user-facing outcome.
2. **Files to change** — with the role of each change.
3. **Risks / unknowns** — what could go wrong, what assumptions you're making.
4. **Test plan** — how you'll know it worked.

You don't have to ask Claude for this format — it's what the `Plan` sub-agent already produces.

## Plan mode vs the `Plan` sub-agent

- **Plan mode** is a session-wide mode toggled by you.
- The **`Plan` sub-agent** is a one-shot delegate the main Claude can spawn for a planning task while staying in normal mode itself.

Use the mode when you want a hard guarantee nothing will be edited. Use the sub-agent when the main session can keep doing other work in parallel.
