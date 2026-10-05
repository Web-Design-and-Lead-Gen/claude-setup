# Step 2 — API Key (usually skip this)

**You don't need an API key if you log in to Claude Code with your Claude account** (Pro or Max). That's what the beginner guide does, and it covers everything, including the job search tool, which never uses an API key.

Only follow this page if you specifically want pay-per-use billing instead of a subscription.

## Get your key

1. Go to https://console.anthropic.com/settings/keys
2. Click **Create Key**
3. Copy it — you won't see it again

---

## Add it to your shell

```bash
echo 'export ANTHROPIC_API_KEY="sk-ant-YOUR-KEY-HERE"' >> ~/.zshrc
source ~/.zshrc
```

Verify:
```bash
echo $ANTHROPIC_API_KEY   # should print your key (not empty)
```

---

## Alternative: put it in Claude's settings

If you don't want it in your shell profile, add it to `~/.claude/settings.local.json`:

```json
{
  "env": {
    "ANTHROPIC_API_KEY": "sk-ant-YOUR-KEY-HERE"
  }
}
```

Create that file if it doesn't exist. Never commit this file to git.

---

## Billing

Claude Code uses the API directly — you pay per token. For normal daily coding use, expect $5–20/month. Claude Sonnet 4.6 (the default) is the best cost/quality balance.

Go to https://console.anthropic.com/settings/billing to add a payment method and set a spend limit.
