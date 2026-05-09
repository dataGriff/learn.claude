# Local settings example

Copy this file to `.claude/settings.local.json` to override project-wide settings for your machine only. **`settings.local.json` is gitignored** (or should be — see `.gitignore`).

Use it to:

- Add personal permission rules without committing them
- Toggle environment variables for your dev box
- Disable hooks while debugging

## Example contents

```json
{
  "permissions": {
    "allow": [
      "Bash(npm test)"
    ]
  },
  "env": {
    "DEBUG": "true"
  }
}
```

## Precedence

Settings are merged in this order (later wins):

1. User settings (`~/.claude/settings.json`)
2. Project settings (`.claude/settings.json`)
3. Project local settings (`.claude/settings.local.json`)
4. Enterprise/managed settings (highest precedence)

See [`docs/02-settings.md`](../docs/02-settings.md) for details.
