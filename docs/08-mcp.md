# 08 — MCP (Model Context Protocol)

MCP is the open protocol Claude Code uses to talk to *external* tool servers. An MCP server exposes a set of tools (and sometimes resources or prompts) over JSON-RPC; Claude Code lists them alongside its built-in tools and can call them just like `Read` or `Bash`.

If you've ever wanted Claude to talk to GitHub, your database, a Jira board, or a custom internal API — MCP is how.

## How tools appear

MCP tool names are namespaced with the server name: `mcp__<server>__<tool>`. For example, in this session the GitHub MCP server provides `mcp__github__create_pull_request`, `mcp__github__list_issues`, and so on.

## Configuring servers

Servers are declared in `.claude/settings.json` (project) or `~/.claude/settings.json` (personal):

```json
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": { "GITHUB_TOKEN": "${env:GITHUB_TOKEN}" }
    },
    "postgres": {
      "command": "uvx",
      "args": ["mcp-server-postgres", "postgresql://localhost/mydb"]
    }
  }
}
```

Each entry launches a subprocess that speaks MCP over stdio. The harness manages the lifecycle.

## Permissions for MCP tools

MCP tools obey the same permission rules as built-in ones. In your `permissions` block:

```json
{
  "allow": ["mcp__github__list_issues", "mcp__github__pull_request_read"],
  "ask":   ["mcp__github__create_pull_request"],
  "deny":  ["mcp__postgres__execute_sql"]
}
```

Pre-allow read-only tools, prompt for writes, deny anything destructive.

## This repo's `.mcp.json`

The file [`.mcp.json`](../.mcp.json) at the repo root configures one server:

```json
{
  "mcpServers": {
    "fs-examples": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "./examples"]
    }
  }
}
```

`fs-examples` runs the official filesystem MCP server scoped to the `examples/` directory. Once approved, Claude gains tools like `mcp__fs-examples__read_file` and `mcp__fs-examples__list_directory` — but only over `examples/`. It's a deliberately bounded demo: anything outside that path is invisible to the server.

When you start a Claude Code session here for the first time, the harness will ask whether to enable the server. Approve it, then ask Claude *"what `mcp__fs-examples__*` tools are available?"* to see what landed.

`.mcp.json` is project-scoped and committed. Personal MCP servers belong in `~/.claude/settings.json` instead.

## Discovering what's available

Ask Claude "what MCP tools are available?" It will read the configured servers and list them. The `/mcp` built-in slash command opens an interactive picker.

## Building your own server

The MCP spec is small. Reference implementations exist in TypeScript, Python, and Go (see <https://modelcontextprotocol.io>). A custom server is the right call when:

- You want Claude to talk to an internal system (your wiki, your monitoring stack, ...).
- You need transactional or stateful tools that don't fit shell commands.
- You want to share the integration with your team — one config entry beats N hand-rolled `Bash` invocations.

## Scope and security

An MCP server runs as your user. Treat each one as you would any third-party CLI: read what it does before installing, pin versions, and lock down credentials with `env` interpolation rather than hard-coding tokens in `settings.json`.
