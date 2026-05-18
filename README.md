# learn.claude

A hands-on tutorial repository that demonstrates **all the major capabilities of Claude Code**, with working examples and walkthrough documentation. Open this repo with Claude Code and learn by doing.

> **What is Claude Code?** Anthropic's official CLI/IDE agent. It can read and edit files, run shell commands, search the web, and orchestrate sub-agents — all from a terminal that understands your project.

## How to use this repo

1. **Open this folder in Claude Code** (`claude` in the terminal, or open it in your IDE with the Claude Code extension).
2. **Read the docs in order** — they are numbered: [`docs/00-overview.md`](docs/00-overview.md) onwards.
3. **Run the live examples** — every feature in `docs/` has a matching artifact under `.claude/` you can actually invoke.
4. **Try the exercises** — `exercises/` contains short hands-on tasks to cement each concept.

## What's in here

| Path | What it demonstrates |
|------|----------------------|
| [`CLAUDE.md`](CLAUDE.md) | Project memory — context auto-loaded into every session |
| [`.claude/settings.json`](.claude/settings.json) | Permissions, env vars, hooks, status line |
| [`.claude/commands/`](.claude/commands/) | Custom slash commands you can run with `/<name>` |
| [`.claude/skills/`](.claude/skills/) | Skills Claude invokes automatically when relevant |
| [`.claude/agents/`](.claude/agents/) | Specialised sub-agents Claude can delegate to |
| [`.claude/hooks/`](.claude/hooks/) | Shell scripts triggered by lifecycle events |
| [`.claude/output-styles/`](.claude/output-styles/) | Custom response personas |
| [`.mcp.json`](.mcp.json) | Project-scoped MCP server config |
| [`docs/`](docs/) | Walkthrough — one feature per file |
| [`examples/`](examples/) | Sample source code to experiment on |
| [`exercises/`](exercises/) | Short hands-on tasks |

## Recommended learning path

```
00-overview        ←  start here
01-claude-md       ←  the most important file in any Claude project
02-settings        ←  the .claude/settings.json schema
03-permissions     ←  how Claude asks before doing risky things
04-slash-commands  ←  build your own /commands
05-skills          ←  reusable, auto-invoked instructions
06-subagents       ←  delegate to specialised assistants
07-hooks           ←  run scripts on lifecycle events
08-mcp             ←  plug in external tools via Model Context Protocol
09-output-styles   ←  change Claude's response persona
10-status-line     ←  customise the status bar
11-plan-mode       ←  read-only planning before action
12-tips            ←  shortcuts, gotchas, productivity tips
13-cheat-sheet     ←  quick-reference prompts and shortcuts
```

## A 60-second tour

After cloning, run `claude` in this folder, then try:

```text
/help                    list built-in commands
/explain-file README.md  custom command in this repo (see .claude/commands/)
/git-summary             a command that runs shell and summarises
/changelog 0.1.0         a command that takes arguments
```

Then ask Claude something like *"review the code in `examples/python/todo_cli.py`"* and watch it delegate to the `code-reviewer` sub-agent defined in [`.claude/agents/`](.claude/agents/).

## Prerequisites

- [Claude Code installed](https://docs.claude.com/en/docs/claude-code/quickstart) (CLI, desktop app, or IDE extension)
- A working shell (`bash` or `zsh`)
- Optional: `python3` to run the sample code in `examples/`
- Optional: `node` / `npx` if you want to enable the example MCP server in [`.mcp.json`](.mcp.json)

## License

[MIT](LICENSE).
