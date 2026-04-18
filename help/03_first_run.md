# Step 3 — First Run & Verification

## Launch Claude Code

```bash
claude
```

First launch will ask you to log in via browser — follow the prompt.

---

## Verify the setup

### Check agents loaded
In the Claude Code prompt, type:
```
/help
```
You should see a list of available slash commands.

### Check rules are active
Ask Claude:
```
what coding rules are you following?
```
It should describe the guidelines from CLAUDE.md — think before coding, simplicity first, surgical changes, goal-driven execution.

### Check hooks work
Try editing any file. The read-guard hook will warn you if you try to edit without reading first. That's working correctly.

### Quick smoke test
```bash
claude "write a python function that adds two numbers"
```
Claude should write a clean, minimal function with no unnecessary extras — no docstrings, no type hints unless asked, no edge case handling that wasn't requested. That's the simplicity rule working.

---

## If something's wrong

**`claude` command not found:**
```bash
npm install -g @anthropic-ai/claude-code
```

**API key error:**
```bash
echo $ANTHROPIC_API_KEY   # check it's set
```

**Hooks not firing:**
```bash
ls ~/.claude/hooks/   # should list 8+ files
chmod +x ~/.claude/hooks/*.sh
```
