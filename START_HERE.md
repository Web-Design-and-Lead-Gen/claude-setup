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
- Keep a short checklist of the 7 parts and show progress after each one ("Part 3 of 7 done").

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

The job skills below use the job search tool that Part 6 installs. How to run it is in `~/claude-work/job-search/CLAUDE.md`; the skills point there instead of repeating it.

**`~/.claude/skills/find-jobs/SKILL.md`**

```markdown
---
name: find-jobs
description: Find new jobs that fit me with the job search tool and walk me through the best ones. Use when I ask for new jobs, what's out there, or anything good today.
---

How to run the job search tool is in ~/claude-work/job-search/CLAUDE.md.

1. Run `discover`, then `match`, then `list --fresh 14 --min-score 0.2 --hide-flagged`.
2. Show me the top 5 in plain words: role, company, location, salary if listed, how old the posting is, and one line on why it fits or doesn't.
3. Ask which ones I want to look at. For each pick, run /job-match on it.
4. If nothing scores well, say so. Offer to find more companies like the ones I already watch: search the web, find each careers page link, and after I say yes, add it with `companies add <link>`.
```

**`~/.claude/skills/job-match/SKILL.md`**

```markdown
---
name: job-match
description: Compare a job posting to my resume, show what the posting cares about and what I'm missing, and rewrite my resume to match. Use when I pick a job from /find-jobs or paste or link a posting.
---

How to run the job search tool is in ~/claude-work/job-search/CLAUDE.md. My master resume is ~/claude-work/job-search/resume.md. Never edit it; work on the copy.

1. Get the job into the tool:
   - From /find-jobs: you already have its id.
   - Pasted text: save it to a .txt file and run `add --file <file> --title "<title>" --company "<company>"`.
   - A link: `add --url <link>`. LinkedIn and Indeed links can't be read; ask me to paste the text instead.
2. Run `prepare <id>`. It creates applications/<company>-<role>/ with posting.md, analysis.md and a copy of my resume reordered for this job.
3. Read posting.md and analysis.md. analysis.md counts how often and where (requirements vs nice-to-have) each skill appears and where it shows on my resume. Use those counts; add your own read of the posting.
4. Tell me: fit score 1-10 with one sentence why, the must-haves and how I stack up, and any dealbreakers (seniority, years, location).
5. Rewrite the resume copy in that folder: use their wording where it's honestly true, lead with what they weigh most, and move skills that are only in my skills list into real bullets. Never invent experience. If something is missing, leave it out and tell me.
6. Run `check <id>`. Fix every red warning: remove the claim, or ask me if it's true. Repeat until it's clean, then run `export <id>` for the Word version.
7. Save notes.md in the folder (fit score, gaps, keywords used) and ask if I want a cover letter (/cover-letter).
8. It stays "drafted" in the tracker until I tell you I've applied. Never apply for me.
```

**`~/.claude/skills/cover-letter/SKILL.md`**

```markdown
---
name: cover-letter
description: Write a short, specific cover letter for a job I'm applying to. Use after /job-match or when I ask for a cover letter.
---

1. Use posting.md and my tailored resume from the job's applications/<company>-<role>/ folder. If there isn't one, run /job-match first.
2. Under 250 words. Three short paragraphs: why this company specifically, the 2 most relevant things I've done with concrete results, a simple close.
3. Sound like a person. No "I am writing to express my interest", no "passionate", no "synergy".
4. Only use facts from my resume or that I tell you. Ask if you need something.
5. Save as cover-letter.md in the job's folder.
6. I send it myself. Never submit applications or send emails for me.
```

**`~/.claude/skills/job-tracker/SKILL.md`**

```markdown
---
name: job-tracker
description: Show and update my job applications and tell me who to follow up with. Use when I ask about my applications, follow-ups, or say I applied or heard back.
---

My applications are tracked in the job search tool's database. How to run it is in ~/claude-work/job-search/CLAUDE.md. Don't keep a separate tracker file.

Statuses: drafted (not sent yet), applied, interviewing, offer, rejected, withdrawn.

1. If I told you something changed, find the job's id with `applications` (or `list --min-score 0` if it isn't tracked yet) and run `track <id> --status <status>`. Add `--notes "..."` for anything worth remembering and `--contact-email <email>` if I mention a recruiter. For an interview with a date: `interview add <id> --when "YYYY-MM-DD HH:MM" --with "<name>"`.
2. Run `applications` and show it to me as a short plain table.
3. Run `followup` and tell me who's due (applied with no reply after 7 days, interviewing with no reply after 5).
4. Offer to write each follow-up email and save it as followup.md in that job's folder. I send it myself.
```

**`~/.claude/skills/interview-prep/SKILL.md`**

```markdown
---
name: interview-prep
description: Get me ready for an interview with company research, likely questions, my best stories, questions to ask, and a mock interview. Use when I have an interview coming up.
---

1. Find the job's folder in ~/claude-work/job-search/applications/ (posting.md, tailored resume, notes.md). If there isn't one, run /job-match first.
2. Research the company on the web: what they do, recent news, and the interviewer if I give a name. Cite your sources.
3. Write interview-prep.md in that folder:
   - The 5-6 things they'll probe (from the posting) and the line on my resume that proves each
   - Likely questions: behavioral, plus technical ones on the tools they list
   - 2-3 of my stories in Situation, Task, Action, Result form, using only my real experience. Ask me for details you don't have. Save good stories to ~/claude-work/job-search/stories.md so I can reuse them.
   - 5 questions to ask them
   - The posted salary range if there is one, and what to say if they ask my expectations
4. Offer a mock interview: one question at a time, wait for my answer, give a short honest grade and a tighter version, then the next question.
5. If I give a date and time, log it with `interview add` (see /job-tracker). Afterwards, offer to write a thank-you email. I send it myself.
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
    applications/
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
Applications are tracked by the job search tool in tool/ (see "Job search tool" below).
Useful commands: /find-jobs, /job-match, /cover-letter, /job-tracker, /interview-prep, /save-progress, /backup.
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

Create the empty `applications/` folder with an empty `.gitkeep` file inside so git keeps it.

Then for each of the three folders: `git init`, add the default .gitignore from the backup skill, commit "first commit", and create a private GitHub repo with `gh repo create claude-<folder> --private --source=. --push`. Show them the three links.

### Part 6: Job search tool

Explain: this is a free program that does the busywork of a job search. Every time it runs, it checks the job boards of companies they pick, scores each opening against their resume, and keeps track of every application and follow-up. Claude runs it for them and does the writing (resume, cover letters, emails) in the conversation. There are no accounts, API keys or costs, it runs only on their computer, and it never applies to anything. They always send applications themselves.

It needs Python (a programming language the tool is written in). Ask "ready?" before each step below.

1. **Check for Python 3.10 or newer.**
   - Mac: `python3 --version`
   - Windows: `py --version` (if that isn't found, try `python --version`)

   If it's 3.10 or higher, skip to step 2. If it's missing or older:
   - Mac: if `brew` exists, run `brew install python@3.12` and use `python3.12` from now on. If there's no brew, the Mac's built-in Python is usually too old: have them download the macOS installer from https://www.python.org/downloads/, open it and click through. Then check again with `python3 --version`.
   - Windows: `winget install --id Python.Python.3.12 -e`. When it finishes they must close the terminal, open a new one, run `claude`, paste the same START_HERE line and say "continue from Part 6". Then check again with `py --version`. A message about the Microsoft Store means Python still isn't installed.

2. **Download the tool into the job-search folder.** It goes in a `tool` folder there so everything job-related lives together.
   - Mac:
     ```
     cd ~/claude-work/job-search
     git clone https://github.com/jakeeranackal/jobsearch-cli.git tool
     ```
   - Windows (PowerShell):
     ```
     cd $HOME\claude-work\job-search
     git clone https://github.com/jakeeranackal/jobsearch-cli.git tool
     ```
   Add a line `tool/` to `job-search/.gitignore` so the tool's code isn't saved into their own backup (it has its own home on GitHub). Commit that change.

3. **Create a virtual environment and install.** Explain: a virtual environment is a private box for the tool's parts so it can't interfere with anything else on the computer.
   - Mac (use `python3.12` instead of `python3` if that's what step 1 used):
     ```
     cd ~/claude-work/job-search/tool
     python3 -m venv .venv
     .venv/bin/pip install -e .
     ```
   - Windows:
     ```
     cd $HOME\claude-work\job-search\tool
     py -m venv .venv
     .venv\Scripts\pip install -e .
     ```
   It takes a minute or two. If pip says "No such file or directory" on Windows, that's the Windows path-length limit: have them open PowerShell as administrator, run `New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem" -Name LongPathsEnabled -Value 1 -PropertyType DWORD -Force`, reopen the terminal and retry. Confirm it worked with `.venv/bin/jobsearch --help` (Windows: `.venv\Scripts\jobsearch.exe --help`).

4. **Set it up.** The tool has its own question-by-question setup, but it needs a real keyboard, so do the same thing here in chat instead:
   - Use `../resume.md` (their master resume from Part 5) as the resume. The tool reads markdown directly, so there's nothing to convert. If resume.md is still the placeholder, ask them to paste their resume first and save it there.
   - Ask, one at a time: what job titles they want (a few words each, like "data analyst"); title words to skip (suggest senior, staff, principal, director, vp, head of); where (cities, or remote); and which companies they'd love to work at.
   - Read resume.md and pick 6-10 skills from it as boost keywords (tools and hard skills, not soft skills). Show them the list and let them edit it.
   - Write `tool/config.yaml`:
     ```yaml
     user:
       name: <name from Part 1>
       email: <email from Part 1>
       location: <their city>
     resume_tracks:
       main:
         path: ../resume.md
         keywords: [<skills you picked>]
     applications_dir: ../applications
     search:
       roles: [<their job titles>]
     filters:
       exclude_title_terms: [<words to skip>]
       include_locations: [<their places, plus "remote" if they said so>]
     sources: {}
     followup_days: {applied: 7, interviewing: 5, drafted: 3}
     notify: {channel: none}
     ```
     `applications_dir: ../applications` makes the tool use the same applications/ folder as the skills from Part 4.
   - Run `init` to create the database.
   - Companies: explain that the tool reads jobs straight from company job boards (Greenhouse, Lever, Ashby, Workday, Workable, SmartRecruiters), not LinkedIn or Indeed. For each company they named, search the web for its careers page, find the job-board link (e.g. `boards.greenhouse.io/...`, `jobs.lever.co/...`, `jobs.ashbyhq.com/...`, `...myworkdayjobs.com/...`), and run `companies add <link>`. It prints how many jobs are open. If a company uses a board the tool can't read, tell them they can still paste any posting later with /job-match. Aim for at least 5 companies; suggest similar ones if their list is short.

   Here and below, run commands from the tool folder as `.venv/bin/jobsearch <command>` on Mac or `.venv\Scripts\jobsearch.exe <command>` on Windows.

5. **Test run.** Run `discover`, then `match`, then `list --min-score 0.25`. Show them the top results in plain words: role, company, location, salary if shown, and how old the posting is. If nothing scores 0.25 or higher, run `list --min-score 0.15`, explain that the score is a rough word overlap with their resume (0.3+ is a strong match, so low scores are normal for a short resume), and suggest adding more companies. If discover reports an error for a company, fix the link or remove that company; don't skip it silently.

6. **Teach Claude the tool.** Add this section to the end of `~/claude-work/job-search/CLAUDE.md`, filling in the run command for their OS, then commit it:

   ```markdown
   ## Job search tool

   The tool lives in tool/ and keeps its own database there. It finds and scores jobs,
   compares postings to my resume, and tracks applications and follow-ups. You (Claude)
   do all the writing. It never applies or sends anything.

   Run it from tool/: `cd tool` then `<.venv/bin/jobsearch or .venv\Scripts\jobsearch.exe> <command>`.
   No need to activate anything; that path already uses the tool's private Python.
   If it says it's missing, reinstall with `<python> -m venv .venv` then `<pip path> install -e .`

   Commands:
   - discover / match / list --fresh 14: pull new jobs, score them, show the best
   - add --file job.txt --title "..." --company "..." (or add --url <link>): add one posting
   - analyze <id>: what the job asks for vs my resume
   - prepare <id>: job folder in ../applications with posting.md, analysis.md, resume copy
   - check <id>: after editing the resume copy, flags anything not in my real resume
   - export <id>: Word version of the edited resume
   - track <id> --status applied|interviewing|offer|rejected|withdrawn
   - applications / followup: everything tracked / who's due a follow-up
   - interview add <id> --when "YYYY-MM-DD HH:MM" --with "<name>"
   - companies add <careers link>: watch another company
   - keywords --cloud cloud.html: most-wanted skills across all postings
   - stats / report: what's getting responses

   Rules: never invent experience; fix everything `check` flags. Never submit applications
   or send emails. I always send them.
   ```

Show them what it found, and tell them they can just say "find me jobs" any time from the job-search folder (or type /find-jobs).

### Part 7: How to use it

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
  /find-jobs       new jobs from your companies, best ones first
  /job-match       pick or paste a job, get gaps and a tailored resume
  /cover-letter    write a cover letter for that job
  /job-tracker     see applications and who to follow up with
  /interview-prep  research, likely questions, your stories, mock interview
  /idea-check      pressure-test a business idea
  /save-progress   save where you are before /clear
  /backup          back up this folder to GitHub

JOB SEARCH TOOL  (start Claude in ~/claude-work/job-search, then just ask)
  "find me jobs"                  discover + match + list
  "what does this job want"       analyze <id>
  "tailor my resume for it"       prepare <id>, Claude edits, check <id>, export <id>
  "I applied to X" / "I heard back"   track <id> --status ...
  "who do I follow up with"       followup
  "show my applications"          applications
  "add Stripe to my companies"    companies add <careers link>
  "what skills keep coming up"    keywords --cloud cloud.html
  "how am I doing"                stats / report
  The tool finds, scores and tracks. Claude writes. You send.

GOOD HABITS
  One topic per conversation. /save-progress then /clear when switching.
  Say "remember that ..." for anything Claude should always know.
  Read what Claude writes before you send it to anyone.
  Claude drafts, you send. It never applies or emails for you.
```

Finish by suggesting a first real task, run from the job-search folder: "Type /find-jobs, pick one that looks good, and Claude will run /job-match on it." Remind them to `cd` into that folder before starting `claude`. Skills work anywhere, but each folder's CLAUDE.md and saved files only load when Claude starts in that folder.
