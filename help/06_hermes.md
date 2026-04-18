# Step 6 — Hermes (Optional)

Hermes is an autonomous agent runner that lets Claude work on tasks in the background — without you sitting at the terminal. Your friend uses it for things like picking up tickets automatically and running scheduled jobs.

**You probably don't need this on day 1.** Get comfortable with Claude Code first, then come back here.

---

## Install

```bash
pip3 install hermes-agent
```

## Configure

Create `~/.hermes/config.yaml`:

```yaml
model: claude-sonnet-4-6
max_iterations: 50
timeout: 300
```

**Important:** Use `claude-sonnet-4-6` exactly — other model names may not exist and will cause silent failures.

## Basic usage

Run a one-off autonomous task:
```bash
hermes run "review all Python files in src/ and fix any type annotation issues"
```

Run on a schedule (cron syntax):
```bash
hermes schedule "0 9 * * *" "check for new tickets and summarize overnight activity"
```

List running jobs:
```bash
hermes list
```

## When it's useful

- Morning briefings — auto-summarize overnight PRs, tickets, or emails
- Background refactors — run a cleanup task while you're in meetings
- Scheduled reports — generate daily status on a cron
- Ticket automation — pick up and work tickets autonomously (with your review before prod)

## Caution

Hermes operates autonomously — it can read/write files and run shell commands without asking. Only point it at work you're comfortable having automated. Always review its output before pushing to production.
