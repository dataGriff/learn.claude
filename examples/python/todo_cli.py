"""A tiny todo-list CLI backed by a JSON file.

Self-contained example for the `learn.claude` tutorial repo. Used by
`docs/06-subagents.md` and the `code-reviewer` sub-agent demo.

Usage:
    python3 todo_cli.py add "buy milk"
    python3 todo_cli.py list
    python3 todo_cli.py done 1
    python3 todo_cli.py remove 1
"""
from __future__ import annotations

import json
import sys
from dataclasses import dataclass, asdict
from pathlib import Path

STORE = Path.home() / ".local" / "state" / "learn-claude" / "todos.json"


@dataclass
class Todo:
    id: int
    text: str
    done: bool = False


def load() -> list[Todo]:
    if not STORE.exists():
        return []
    raw = json.loads(STORE.read_text())
    return [Todo(**item) for item in raw]


def save(todos: list[Todo]) -> None:
    STORE.parent.mkdir(parents=True, exist_ok=True)
    STORE.write_text(json.dumps([asdict(t) for t in todos], indent=2))


def next_id(todos: list[Todo]) -> int:
    return max((t.id for t in todos), default=0) + 1


def cmd_add(args: list[str]) -> int:
    if not args:
        print("usage: todo_cli.py add <text>", file=sys.stderr)
        return 2
    todos = load()
    todos.append(Todo(id=next_id(todos), text=" ".join(args)))
    save(todos)
    print(f"added #{todos[-1].id}: {todos[-1].text}")
    return 0


def cmd_list(_: list[str]) -> int:
    todos = load()
    if not todos:
        print("no todos")
        return 0
    for t in todos:
        marker = "x" if t.done else " "
        print(f"[{marker}] {t.id:>3}  {t.text}")
    return 0


def cmd_done(args: list[str]) -> int:
    if not args:
        print("usage: todo_cli.py done <id>", file=sys.stderr)
        return 2
    target = int(args[0])
    todos = load()
    for t in todos:
        if t.id == target:
            t.done = True
            save(todos)
            print(f"done #{t.id}")
            return 0
    print(f"no todo with id {target}", file=sys.stderr)
    return 1


def cmd_remove(args: list[str]) -> int:
    if not args:
        print("usage: todo_cli.py remove <id>", file=sys.stderr)
        return 2
    target = int(args[0])
    todos = load()
    kept = [t for t in todos if t.id != target]
    if len(kept) == len(todos):
        print(f"no todo with id {target}", file=sys.stderr)
        return 1
    save(kept)
    print(f"removed #{target}")
    return 0


COMMANDS = {
    "add": cmd_add,
    "list": cmd_list,
    "done": cmd_done,
    "remove": cmd_remove,
}


def main(argv: list[str]) -> int:
    if len(argv) < 2 or argv[1] not in COMMANDS:
        print(f"usage: todo_cli.py [{' | '.join(COMMANDS)}] ...", file=sys.stderr)
        return 2
    return COMMANDS[argv[1]](argv[2:])


if __name__ == "__main__":
    raise SystemExit(main(sys.argv))
