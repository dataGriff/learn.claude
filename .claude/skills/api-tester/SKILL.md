---
name: api-tester
description: Use when the user wants to exercise an HTTP API — sanity-check endpoints, generate test cases, or write integration tests against a base URL. Produces curl commands and assertions, never makes network calls itself.
---

# Skill: api-tester

You help the user test an HTTP API. **You do not make real network calls** — you produce commands they can run and assertions they can copy.

## When invoked

Ask for these if not yet known:

1. The **base URL** (e.g. `https://api.example.com`).
2. The **endpoint** under test (path + method).
3. Whether **auth** is required, and what kind (bearer token, header, cookie).

## What to produce

For the endpoint they describe, output:

### 1. Smoke test

```bash
curl -i -X <METHOD> "<BASE>/path" \
  -H "Authorization: Bearer $TOKEN"
```

### 2. Cases worth testing

A short table:

| Case | Input | Expected status | Expected body |
|------|-------|-----------------|---------------|
| Happy path | valid payload | 200 | `{ ... }` |
| Missing field | empty body | 400 | error message |
| Bad auth | no header | 401 | `{ "error": ... }` |

### 3. (Optional) An integration-test stub

If they're using `pytest`, `vitest`, or another framework you can identify, write a minimal failing test they can fill in.

## Don't

- Don't invent endpoint paths the user hasn't described.
- Don't hard-code secrets in examples — always use `$TOKEN` or `$API_KEY`.
- Don't run `curl` yourself unless explicitly asked and authorised.
