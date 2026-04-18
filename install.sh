#!/bin/bash
# Claude Code Setup — run this once on your Mac
# Usage: bash install.sh           (Claude Code only)
#        bash install.sh --hermes  (Claude Code + Hermes)

set -e

INSTALL_HERMES=false
for arg in "$@"; do
  [[ "$arg" == "--hermes" ]] && INSTALL_HERMES=true
done

CLAUDE_DIR="$HOME/.claude"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo ""
echo "=== Claude Code Setup ==="
echo ""

# 1. Check for Claude Code
if ! command -v claude &>/dev/null; then
  echo "[1/5] Installing Claude Code CLI..."
  if ! command -v npm &>/dev/null; then
    echo "ERROR: npm not found. Install Node.js first: https://nodejs.org"
    exit 1
  fi
  npm install -g @anthropic-ai/claude-code
else
  echo "[1/5] Claude Code already installed: $(claude --version)"
fi

# 2. Create ~/.claude structure
echo "[2/5] Setting up ~/.claude directories..."
mkdir -p "$CLAUDE_DIR"/{rules,agents,skills,hooks}

# 3. Copy config files
echo "[3/5] Copying rules, agents, skills, hooks..."
cp -r "$SCRIPT_DIR/rules/"*   "$CLAUDE_DIR/rules/"
cp -r "$SCRIPT_DIR/agents/"*  "$CLAUDE_DIR/agents/"
cp -r "$SCRIPT_DIR/skills/"*  "$CLAUDE_DIR/skills/"
cp -r "$SCRIPT_DIR/hooks/"*   "$CLAUDE_DIR/hooks/"
cp    "$SCRIPT_DIR/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md"
cp    "$SCRIPT_DIR/AGENTS.md" "$CLAUDE_DIR/AGENTS.md"

# Make hook scripts executable
chmod +x "$CLAUDE_DIR/hooks/"*.sh 2>/dev/null || true

# 4. Install settings.json (skip if one already exists)
if [ -f "$CLAUDE_DIR/settings.json" ]; then
  echo "[4/5] settings.json already exists — skipping (your existing config is preserved)"
else
  echo "[4/5] Installing settings.json..."
  cp "$SCRIPT_DIR/settings.json" "$CLAUDE_DIR/settings.json"
fi

# 5. API key
echo ""
echo "[5/5] API Key setup..."
if [ -z "$ANTHROPIC_API_KEY" ]; then
  echo "  Add your Anthropic API key to ~/.zshrc:"
  echo ""
  echo "    echo 'export ANTHROPIC_API_KEY=\"sk-ant-YOUR-KEY-HERE\"' >> ~/.zshrc"
  echo "    source ~/.zshrc"
  echo ""
  echo "  Get your key at: https://console.anthropic.com/settings/keys"
else
  echo "  ANTHROPIC_API_KEY already set — good to go."
fi

# 6. Hermes (optional)
if [ "$INSTALL_HERMES" = true ]; then
  echo ""
  echo "[6/6] Installing Hermes..."
  if ! command -v pip3 &>/dev/null; then
    echo "  ERROR: pip3 not found. Install Python 3 first: brew install python3"
  else
    pip3 install hermes-agent
    mkdir -p "$HOME/.hermes"
    if [ ! -f "$HOME/.hermes/config.yaml" ]; then
      cat > "$HOME/.hermes/config.yaml" <<EOF
model: claude-sonnet-4-6
max_iterations: 50
timeout: 300
EOF
      echo "  Hermes config written to ~/.hermes/config.yaml"
    else
      echo "  ~/.hermes/config.yaml already exists — skipping"
    fi
    echo "  Hermes installed. Usage: hermes run \"your task here\""
    echo "  See help/06_hermes.md for full guide."
  fi
fi

echo ""
echo "=== Done! ==="
echo ""
echo "Next: open a terminal and run:  claude"
echo "Then ask it anything. Read help/README.md for what's available."
echo ""
