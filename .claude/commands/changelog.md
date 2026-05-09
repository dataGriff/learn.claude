---
description: Draft a CHANGELOG entry from recent commits
argument-hint: <version>
allowed-tools: Bash(git log *), Read, Edit, Write
---

Draft a changelog entry for version **$1** based on the commits below.

## Commits since last tag

!`git log $(git describe --tags --abbrev=0 2>/dev/null || git rev-list --max-parents=0 HEAD)..HEAD --pretty=format:'- %s (%h)'`

---

Produce a Markdown section in [Keep a Changelog](https://keepachangelog.com/) format:

```markdown
## [$1] - YYYY-MM-DD

### Added
- ...

### Changed
- ...

### Fixed
- ...
```

Group commits sensibly. Drop trivial commits ("typo", "wip"). Use today's date.

If a `CHANGELOG.md` already exists, prepend the new section. Otherwise create one with a standard header.
