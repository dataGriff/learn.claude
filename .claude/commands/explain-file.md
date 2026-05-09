---
description: Summarise a file in 4-6 bullet points
argument-hint: <path>
allowed-tools: Read, Glob
---

You are summarising a file for a developer who has not read it before.

Read the file at `$ARGUMENTS` and produce:

1. **Purpose** — one sentence on what the file is for.
2. **Key exports / public surface** — functions, classes, or sections a caller would care about.
3. **Notable dependencies** — imports or external things it touches.
4. **Gotchas** — anything subtle a reader might miss (side effects, hidden state, magic numbers).
5. **One-line TL;DR** suitable for a code review summary.

Keep the whole response under 200 words. Use bullet points, not prose paragraphs.
