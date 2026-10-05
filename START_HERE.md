# Start Here

## For the person reading this

1. Install Claude Code (pick one):
   - **Mac:** open Terminal and run `curl -fsSL https://claude.ai/install.sh | bash`
   - **Windows:** install Git first from https://git-scm.com/download/win (click Next through everything), then open PowerShell and run `irm https://claude.ai/install.ps1 | iex`
   - If either command fails, follow the current steps at https://claude.ai/code
2. Open a new terminal window, type `claude`, and log in with your Claude account when it asks.
3. Paste this in and hit enter:

   > Read START_HERE.md from https://raw.githubusercontent.com/Web-Design-and-Lead-Gen/claude-setup/beginner/START_HERE.md and walk me through it.

   (If someone sent you the file directly, drag it into the terminal instead and say "read this file and walk me through it".)

That's it. Claude does the rest and asks you before changing anything.

---

## Instructions for Claude

You are setting up Claude Code for a beginner who is not a developer. They want to use it for job searching, business ideas and everyday help. They do not have a GitHub account yet.

How to run this:

- Go one part at a time. Say in a sentence or two what the part does and why, then ask "ready?" before doing it.
- Use plain language. No jargon without a one-line explanation.
- Detect their OS first (Mac or Windows) and only show commands for that OS.
- Never delete or overwrite an existing file in `~/.claude/` without backing it up to `<name>.backup` first and telling them.
- If a step fails, explain the error simply, fix it, and continue. Don't skip silently.
- Anything that needs them to type a password or click in a browser, tell them exactly what to click and wait for them to say done.
- Keep a short checklist of the 6 parts and show progress after each one ("Part 3 of 6 done").

### Part 1: Git and GitHub

Explain: Git keeps a history of your files so nothing gets lost. GitHub is a free online backup of that history. Claude will handle the commands; they just need an account.

1. Check git: `git --version`. If missing:
   - Mac: run `xcode-select --install` and have them click Install in the popup. Wait until done.
   - Windows: `winget install --id Git.Git -e`, then they must close and reopen the terminal and run `claude` again. Tell them to paste the same START_HERE line and say "continue from Part 1".
2. Ask for their name and the email they'll use for GitHub, then set them:
   `git config --global user.name "<name>"`
   `git config --global user.email "<email>"`
   `git config --global init.defaultBranch main`
3. GitHub account: have them go to https://github.com/signup, use the same email, and pick a username. Wait until they've verified their email.
4. Install the GitHub CLI:
   - Mac: if `brew` exists, `brew install gh`. If not, download the installer from https://cli.github.com and have them run it.
   - Windows: `winget install --id GitHub.cli -e`
5. Log in. This is interactive, so they must run it themselves in Claude Code by typing:
   `! gh auth login --web --git-protocol https`
   Tell them: it shows a one-time code, opens the browser, paste the code, click Authorize. If it asks to authenticate Git with GitHub credentials, say yes. If the `!` version hangs, have them run the same command (without the `!`) in a separate terminal window.
6. Verify with `gh auth status` and run `gh auth setup-git`.

### Part 2: Global instructions (`~/.claude/CLAUDE.md`)

Explain: this file is read at the start of every conversation, so Claude always knows who they are and how they like to work.

Back up any existing file, then write this. Use the name from Part 1; leave the rest as-is. Tell them they can add more about themselves anytime by saying "remember that...".

```markdown
# About me

- Name: <name>
- Using Claude for: job searching, business ideas, everyday help

# How to work with me

- I'm not a developer. Explain things in plain language and say what a command does before running it.
- Ask before deleting, overwriting or sending anything.
- If my request is unclear, ask one question instead of guessing.
- Keep it simple. Don't add things I didn't ask for.
- When you write something for me (resume bullets, emails, plans), give me the finished version, not a template.
- Never put passwords, API keys or my ID numbers in files.
- When I say "remember that...", save it to memory.
- When a conversation gets long or we finish a chunk of work, suggest /save-progress.
```

### Part 3: Settings

Explain: these settings let Claude do safe, read-only things without asking every time.

Read `~/.claude/settings.json` if it exists. Merge in the keys below without removing anything already there (back up first). If it doesn't exist, create it.

```json
{
  "permissions": {
    "allow": [
      "Bash(git status)",
      "Bash(git diff:*)",
      "Bash(git log:*)",
      "Bash(gh auth status)",
      "WebSearch",
      "WebFetch"
    ]
  }
}
```

Validate the JSON after writing it.

### Part 4: Skills

Explain: skills are saved playbooks. Typing `/job-match` (for example) makes Claude follow that playbook every time, so they don't have to explain it again.

Create each file below under `~/.claude/skills/<name>/SKILL.md`, exactly as written.

**`~/.claude/skills/save-progress/SKILL.md`**

```markdown
---
name: save-progress
description: Save where we are to PROGRESS.md in the current folder so the next conversation can pick up. Use before /clear, when context is getting full, or at the end of a session.
---

1. Write or update PROGRESS.md in the current folder with:
   - What we're working on (one line)
   - What's done
   - What's next
   - Decisions made and why
   - Open questions
   Keep it under 40 lines. Replace stale content instead of appending forever.
2. If this folder is a git repo, commit with a short plain message like "progress: <topic>" and push if a remote exists.
3. Tell me: "Saved. You can /clear now. Next time, open this folder and say 'read PROGRESS.md and continue'."
```

**`~/.claude/skills/job-match/SKILL.md`**

```markdown
---
name: job-match
description: Compare a job posting to my resume. Pull out the key skills and words the posting cares about, show what I'm missing, and rewrite my resume bullets to match. Use when I paste or link a job posting.
---

Inputs: a job posting (pasted text or link) and my resume (resume.md in the current folder, or ask me for it).

1. Extract from the posting:
   - Must-have skills and tools (e.g. Tableau, SQL, Salesforce)
   - Nice-to-haves
   - Repeated words and phrases, ranked by how often they appear (this is what applicant tracking systems scan for)
   - Seniority and anything that's a dealbreaker
2. Score my fit 1-10 with one sentence of why.
3. Gap table: requirement | do I have it | where it shows on my resume | how to close the gap.
4. Rewrite my resume bullets to use their wording where it's honestly true. Never invent experience. Flag anything I should only claim if I can back it up.
5. Save to `applications/<company>-<role>/`:
   - posting.md (the original posting)
   - resume-tailored.md
   - notes.md (fit score, gaps, keywords)
6. Ask if I want a cover letter (/cover-letter) and add a row to applications/tracker.md.
```

**`~/.claude/skills/cover-letter/SKILL.md`**

```markdown
---
name: cover-letter
description: Write a short, specific cover letter for a job I'm applying to. Use after /job-match or when I ask for a cover letter.
---

1. Use the posting and tailored resume from the job's applications/ folder if they exist. Otherwise ask for them.
2. Under 250 words. Three short paragraphs: why this company specifically, the 2 most relevant things I've done with concrete results, a simple close.
3. Sound like a person. No "I am writing to express my interest", no "passionate", no "synergy".
4. Save as cover-letter.md in the job's folder.
5. I send it myself. Never submit applications or send emails for me.
```

**`~/.claude/skills/job-tracker/SKILL.md`**

```markdown
---
name: job-tracker
description: Show and update my job applications tracker, and tell me who to follow up with. Use when I ask about my applications, follow-ups, or say I applied/heard back.
---

Tracker lives at applications/tracker.md as a table:
| Company | Role | Status | Applied | Last contact | Next step | Link |

Statuses: interested, applied, interviewing, offer, rejected, withdrawn.

1. If I told you something changed, update that row and today's date.
2. Show the table sorted by next step.
3. List follow-ups due: applied with no reply after 7 days, interviewing with no reply after 5 days.
4. Offer to draft each follow-up email (I send it myself).
```

**`~/.claude/skills/idea-check/SKILL.md`**

```markdown
---
name: idea-check
description: Pressure-test a business idea. Who it's for, what exists already, what it costs to try, and the cheapest way to test it this week. Use when I describe a business or side-hustle idea.
---

1. Restate the idea in one sentence and ask me to confirm.
2. Search the web for competitors and similar products. List 3-5 with price and what they do well.
3. Answer plainly:
   - Who exactly pays, and why would they switch to this?
   - How would the first 10 customers find it?
   - Rough startup cost and monthly cost
   - Biggest risk
4. Give the cheapest test I can run in 7 days (a landing page, 10 conversations, a pre-sale post) and what result means go vs stop.
5. Be honest. If it's a weak idea, say why and suggest a sharper version.
6. Save to ideas/<idea-name>.md.
```

**`~/.claude/skills/backup/SKILL.md`**

```markdown
---
name: backup
description: Back up the current folder to a private GitHub repo. Use when I say save to GitHub, back this up, or push.
---

1. If this isn't a git repo, run `git init`.
2. Make sure .gitignore exists and excludes: .env, *.key, anything with "password" or "secret" in the name, .DS_Store.
3. Show me `git status` in plain words (what's new, what changed). Stop and warn me if anything looks like a password, ID scan or bank info.
4. Commit with a short plain message describing the change.
5. If there's no GitHub remote yet: `gh repo create <folder-name> --private --source=. --push`. Always private unless I say otherwise.
6. Otherwise `git push`.
7. Give me the GitHub link.
```

After writing them, list the skills and confirm each file has the frontmatter.

### Part 5: Workspace folders

Explain: one folder per topic keeps conversations focused. Each folder gets its own CLAUDE.md so Claude knows what that folder is for, and each is backed up to a private GitHub repo.

Create in their home folder:

```
claude-work/
  job-search/
    CLAUDE.md
    resume.md
    applications/tracker.md
  business-ideas/
    CLAUDE.md
    ideas/
  general/
    CLAUDE.md
```

`job-search/CLAUDE.md`:

```markdown
# Job search

My master resume is resume.md. Never edit it without asking; tailored versions go in applications/.
Each application gets its own folder in applications/ named <company>-<role>.
Tracker is applications/tracker.md.
Useful commands: /job-match, /cover-letter, /job-tracker, /save-progress, /backup.
```

`business-ideas/CLAUDE.md`:

```markdown
# Business ideas

One file per idea in ideas/. Use /idea-check for new ideas.
Be honest about weak ideas. Cite sources when using web research.
```

`general/CLAUDE.md`:

```markdown
# General

Anything that doesn't fit elsewhere: emails, planning, research, learning.
If a topic grows, suggest giving it its own folder.
```

For `resume.md`: ask them to paste their resume (or drag the file in). Convert it to clean markdown and save. If they don't have it handy, leave a placeholder that says "paste your resume here" and tell them.

Write `applications/tracker.md` with just the empty table header from the job-tracker skill.

Then for each of the three folders: `git init`, add the default .gitignore from the backup skill, commit "first commit", and create a private GitHub repo with `gh repo create claude-<folder> --private --source=. --push`. Show them the three links.

### Part 6: How to use it

Print this cheat sheet, then save a copy to `claude-work/CHEATSHEET.md`:

```
STARTING
  Open a terminal, go to a folder, start Claude:
    cd ~/claude-work/job-search
    claude
  Pick up the last conversation:   claude --continue
  Pick from older ones:            claude --resume

INSIDE CLAUDE
  /clear           fresh start (do this between unrelated tasks)
  /compact         shrink a long conversation without losing the thread
  /context         see how full the conversation is
  /memory          see or edit what Claude remembers about you
  /model           switch models
  Esc              stop Claude mid-answer
  Esc Esc          go back and edit your last message
  ! <command>      run a command yourself

YOUR SKILLS
  /job-match       paste a job posting, get gaps and tailored resume
  /cover-letter    write a cover letter for that job
  /job-tracker     see applications and who to follow up with
  /idea-check      pressure-test a business idea
  /save-progress   save where you are before /clear
  /backup          back up this folder to GitHub

GOOD HABITS
  One topic per conversation. /save-progress then /clear when switching.
  Say "remember that ..." for anything Claude should always know.
  Read what Claude writes before you send it to anyone.
  Claude drafts, you send. It never applies or emails for you.
```

Finish by suggesting a first real task: "Paste a job posting you're interested in and type /job-match", run from the job-search folder. Remind them to `cd` into that folder before starting `claude`. Skills work anywhere, but each folder's CLAUDE.md and saved files only load when Claude starts in that folder.
