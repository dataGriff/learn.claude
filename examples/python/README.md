# `examples/python`

Self-contained Python samples used by the tutorial docs.

| File           | Used by                          | What it is                              |
| -------------- | -------------------------------- | --------------------------------------- |
| `todo_cli.py`  | `docs/06-subagents.md`, `README.md` | A 100-line JSON-backed todo CLI.        |

Try the `code-reviewer` sub-agent on it:

```text
review the code in examples/python/todo_cli.py
```

Or run it directly:

```bash
python3 examples/python/todo_cli.py add "try the code-reviewer agent"
python3 examples/python/todo_cli.py list
```

State is stored at `~/.local/state/learn-claude/todos.json`.
