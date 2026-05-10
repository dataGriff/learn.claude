# Exercise 00 — Write a slash command

**Concept:** [`docs/04-slash-commands.md`](../docs/04-slash-commands.md)

## Goal

Create a `/word-count` slash command that takes a file path and reports the word, line, and character count.

```text
/word-count README.md
```

should produce something like:

```text
README.md
  64 lines
 412 words
2789 characters
```

## Steps

1. Create `.claude/commands/word-count.md`.
2. Add YAML frontmatter with at least `description` and `argument-hint`.
3. In the body, instruct Claude to read the file at `$ARGUMENTS`, count its lines / words / characters, and print them in the format above.
4. Restrict `allowed-tools` to just `Read` — the command shouldn't need anything else.
5. Save, then in your Claude session run `/word-count README.md`.

## Acceptance

- Typing `/` shows `word-count` in the picker with your description.
- Running `/word-count <path>` produces the three counts in the format above.
- Running `/word-count` with no argument prints a usage message instead of erroring.

## Stretch

- Add a `--by-section` flag that breaks the counts down by Markdown heading.
- Make the command usable on multiple files at once (`/word-count a.md b.md`).
