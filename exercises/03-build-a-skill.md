# Exercise 03 — Build a skill

**Concept:** [`docs/05-skills.md`](../docs/05-skills.md)

## Goal

Build a `release-notes` skill that Claude invokes automatically when the user asks for release notes, a changelog entry from recent commits, or a summary "since last tag".

The output should be a Markdown block with `### Added`, `### Changed`, `### Fixed`, `### Removed` sections, drawn from `git log` between the most recent tag and `HEAD`.

## Steps

1. Create the directory `.claude/skills/release-notes/`.
2. Inside it, create `SKILL.md` with frontmatter:
   - `name: release-notes`
   - `description:` — phrase it to match the trigger cases above. Be specific about *when* it activates and *what* it produces.
3. In the body, instruct Claude to:
   - Run `git describe --tags --abbrev=0` to find the previous tag (fall back to `git rev-list --max-parents=0 HEAD` if there are no tags).
   - Run `git log <prev>..HEAD --pretty=format:"%s"`.
   - Categorise each commit subject by Conventional Commit prefix (`feat`, `fix`, `refactor`, etc.) into the four sections.
   - Drop commits that are clearly internal (`chore:`, `docs:`, `ci:`).
4. Restart your Claude session (or run `/memory reload` if available) so the new skill is discovered.
5. Test by asking: *"draft release notes for the last release"*. Claude should auto-invoke `release-notes`.

## Acceptance

- The skill activates automatically on natural-language phrasings (you don't have to name it).
- The output has the four `### ` sections and only includes user-facing commits.
- The skill runs read-only — no `git tag`, `git push`, or other state changes.

## Stretch

- Allow an explicit version range: *"release notes from v0.1.0 to v0.2.0"*.
- Detect when there are no commits in the range and produce a friendly empty-state message.
- Add a small `templates/notes.md` next to `SKILL.md` and have the skill render through it.
