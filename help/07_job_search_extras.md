# Job search tool: optional extras

The beginner guide (START_HERE.md, Part 6) sets up the job search tool without any of these. Everything works without them. Add them later if you want the tool to do more on its own.

> **Status:** these extras are built, but they haven't been tested with real accounts yet. If one doesn't work, tell Claude what happened; it can read the error and fix the setup with you.

To set any of them up, start Claude in `~/claude-work/job-search` and ask, e.g. "set up the Gmail sync for the job search tool". Claude runs the commands from the tool folder as described in your `job-search/CLAUDE.md`.

## Gmail sync

**What it does:** reads replies from recruiters and updates your applications automatically. A rejection marks the job rejected, an interview request marks it interviewing, an offer marks it offer. It also lets Claude put emails it wrote for you into your Gmail Drafts, so you can review and send them from Gmail. It never sends anything.

**What's involved (about 5 minutes, one time):**
1. Install the Google add-on in the tool folder: `.venv/bin/pip install -e ".[google]"` (Windows: `.venv\Scripts\pip install -e ".[google]"`).
2. Create a free Google Cloud project, turn on the Gmail API and Google Calendar API, and download a sign-in file. `jobsearch email connect --help` lists the exact clicks.
3. Save that file as `tool/.secrets/google_credentials.json`, then run `jobsearch email connect` and approve access in your browser.

**Then:** `jobsearch email sync` checks for replies. Interviews you log with `interview add` also go on your Google Calendar.

Your sign-in token stays in `tool/.secrets/` on your computer and is never uploaded.

## Telegram (updates on your phone)

**What it does:** sends you the daily digest (new matches, follow-ups due, thank-yous to send) as a Telegram message, and lets you check things from your phone with `/today`, `/list`, `/analyze <id>`, `/status <id> applied`, `/followups` and `/stats`.

**What's involved (about 2 minutes):**
1. In Telegram, message **@BotFather**, send `/newbot`, pick a name, and copy the token it gives you.
2. Save the token as an environment variable called `TELEGRAM_BOT_TOKEN` (Claude can do this for you).
3. Run `jobsearch bot`, send `/start` to your new bot, and it replies with your chat id. Claude puts that id in `tool/config.yaml` under `telegram: chat_id:` and sets `notify: channel: telegram`.

The bot only answers you. Messages from anyone else are ignored.

## Daily automatic run

**What it does:** every morning, without you opening anything, the tool pulls new jobs, scores them, checks Gmail (if connected), and sends you the digest (via Telegram or email, if set up). Optional hourly alerts ping you only when a strong new match appears.

**What's involved:** one command from the tool folder, for example `jobsearch schedule install --at 07:30` (add `--hourly-alerts` for the pings). On Windows this creates a Task Scheduler task; on Mac it adds a cron entry. Remove it any time with `jobsearch schedule remove`.

The computer has to be on (and awake) at that time for it to run. Logs go to `tool/logs/`.

## LinkedIn connections (referrals)

**What it does:** shows which of your current matches are at companies where you know someone.

**What's involved:** in LinkedIn, go to Settings > Data privacy > Get a copy of your data > Connections, and wait for the email (about 10 minutes). Then give Claude the `Connections.csv` file and ask it to import it (`jobsearch network import Connections.csv`). After that, `jobsearch referrals` lists jobs where you have a way in.
