# Step 1 — Install

## Prerequisites (do these first)

### Homebrew
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Node.js
```bash
brew install node
```

### Python 3
```bash
brew install python3
```

Verify:
```bash
node --version   # should print v18 or higher
python3 --version
```

---

## Run the installer

Open Terminal, navigate to this folder, then run:

```bash
cd ~/Downloads/claude-setup   # or wherever you unzipped it
bash install.sh
```

The script will:
- Install the Claude Code CLI (`claude` command)
- Copy all rules, agents, skills, and hooks to `~/.claude/`
- Install `settings.json` with pre-configured hooks
- Tell you where to add your API key

---

## After install.sh finishes

Go to [02_api_key.md](02_api_key.md) to set up your Anthropic API key.
