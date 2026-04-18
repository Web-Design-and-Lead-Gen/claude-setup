# Step 5 — Daily Usage

## Starting a session

Just open a terminal in your project folder and run:
```bash
claude
```

Claude knows your project from the files in the directory. No setup per session.

---

## Common workflows

### Fix a bug
```
there's a bug where X happens when Y — fix it
```
Claude will: reproduce it mentally → write a failing test → fix the code → verify.

### Add a feature
```
add a login endpoint that validates email + password against the users table
```
Claude will: plan it → write tests first → implement → review for security.

### Review code before committing
```
/code-review
```
Or just: `review the changes I just made`

### Debug something broken
```
/gsd-debug
```
Kicks off a structured scientific debugging session with checkpoints.

### Start a new project from scratch
```
/gsd-new-project
```
Claude will ask questions, build a roadmap, and scaffold the architecture.

---

## Tips that make a big difference

**Work in your project directory.** Claude reads your files — the more context it has, the better. Always `cd` into your project before running `claude`.

**Be specific about what you want verified.** Instead of "does this work?", say "run the tests and show me coverage." Claude will loop until green.

**Let Claude ask clarifying questions.** The rules tell it to surface confusion before coding, not after. Answer its questions — it saves rewrites.

**Don't over-prompt.** You don't need to say "please" or explain AI limitations. Just describe what you need like you're talking to a senior engineer.

**Use `!` to run shell commands without leaving Claude:**
```
! git status
! npm test
! python run_nrfi.py
```

---

## Keyboard shortcuts

| Key | Action |
|-----|--------|
| `Ctrl+C` | Cancel current response |
| `Ctrl+L` | Clear screen |
| `↑` | Previous message |
| `Shift+Enter` | New line without submitting |
