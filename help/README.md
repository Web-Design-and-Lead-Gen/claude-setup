# Claude Code Setup — Start Here

Welcome. This folder gives you the same Claude Code setup your friend uses — same agents, rules, hooks, and slash commands.

## Step-by-step order

| Step | File | What it covers |
|------|------|----------------|
| 1 | [01_install.md](01_install.md) | Install Claude Code + run install.sh |
| 2 | [02_api_key.md](02_api_key.md) | Get your Anthropic API key |
| 3 | [03_first_run.md](03_first_run.md) | Verify everything works |
| 4 | [04_what_you_have.md](04_what_you_have.md) | What agents/skills/rules do |
| 5 | [05_daily_usage.md](05_daily_usage.md) | How to actually use it every day |
| 6 | [06_hermes.md](06_hermes.md) | Optional: Hermes autonomous agent runner |

## What this setup gives you

- **48 specialized agents** — code reviewer, security auditor, planner, TDD guide, and more. Claude automatically routes tasks to the right one.
- **183 skills / slash commands** — type `/code-review`, `/gsd-debug`, `/tdd`, etc. to trigger specific workflows.
- **Smart hooks** — Claude reads files before editing, guards against unsafe commits, monitors context window, and more — all automatically.
- **Coding rules** — behavioral guidelines baked in so Claude writes clean, simple, secure code without you having to remind it every time.

## Quick test after setup

```bash
claude "review this function for security issues: def login(user, pw): return db.query(f'SELECT * FROM users WHERE user={user} AND pw={pw}')"
```

Claude should catch the SQL injection and explain how to fix it — no prompting needed.
