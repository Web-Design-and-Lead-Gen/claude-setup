# Step 4 — What You Have

## Agents (auto-used by Claude)

Claude automatically routes tasks to specialized agents. You don't need to invoke them manually — Claude decides. Key ones:

| Agent | Triggers automatically when... |
|-------|-------------------------------|
| `planner` | You ask for a complex feature |
| `code-reviewer` | You write or modify code |
| `tdd-guide` | You fix a bug or build a new feature |
| `security-reviewer` | Code touches auth, user input, or APIs |
| `build-error-resolver` | A build or type-check fails |
| `architect` | You make a system design decision |
| `python-reviewer` | You write Python code |
| `typescript-reviewer` | You write TypeScript/JavaScript |
| `go-reviewer` | You write Go |
| `database-reviewer` | You write SQL or design a schema |
| `performance-optimizer` | You're profiling or optimizing |
| `e2e-runner` | You need end-to-end tests |

## Slash Commands (Skills)

Type these directly in Claude Code:

```
/tdd              → test-driven development workflow
/code-review      → review current code for issues
/gsd-debug        → structured debugging session
/gsd-plan-phase   → plan a feature before coding
/gsd-new-project  → scaffold a new project with roadmap
/security-review  → full security audit
/update-docs      → regenerate documentation
/graphify         → turn anything into a knowledge graph
```

There are 183 total — type `/` and browse, or just describe what you want and Claude will suggest the right one.

## Rules (always active)

Rules live in `~/.claude/rules/` and shape Claude's behavior globally:

- **coding-style** — immutability, KISS, DRY, YAGNI, file size limits
- **testing** — TDD mandatory, 80% coverage minimum
- **security** — mandatory pre-commit checklist, no hardcoded secrets
- **git-workflow** — conventional commits, PR format
- **agents** — when/how to use each agent, parallel execution
- **performance** — which Claude model to use for which task

Language-specific rules (`python/`, `typescript/`, `golang/`, etc.) extend the common rules.

## Hooks (run automatically)

Hooks fire in the background without you doing anything:

| Hook | What it does |
|------|-------------|
| `gsd-read-guard` | Blocks edits to files you haven't read — prevents blind overwrites |
| `gsd-prompt-guard` | Catches prompt injection attempts in file content |
| `gsd-context-monitor` | Warns when context window is getting full |
| `gsd-validate-commit` | Checks commit messages follow conventional format |
| `gsd-statusline` | Shows context %, model, and session info in the status bar |
| `gsd-session-state` | Saves session context on start for continuity |
| `gsd-phase-boundary` | Tracks when you cross phase boundaries in a project |
