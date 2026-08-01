# mcp-jobs — your AI job-search copilot

**Version 0.1.9**

mcp-jobs turns Claude Desktop into a job-search assistant: it finds openings,
scores how well you fit, tailors your CV and cover letter per job (as PDFs),
opens the posting in Chrome for you to apply, tracks everything in a local
database, scans your Gmail for recruiter mail, and preps you for interviews
from your calendar.

**You always apply manually. It never submits anything for you, and it never
invents experience you don't have.**

## Requirements

| Requirement | Why |
|---|---|
| Windows 10/11 (64-bit) | This build is Windows-only |
| [Node.js 22 LTS](https://nodejs.org) | Runs mcp-jobs (the included database module is built for Node 22 — other versions won't work) |
| [Claude Desktop](https://claude.ai/download) | The chat interface you'll use |
| [Claude Code CLI](https://claude.com/claude-code) logged in, with a Claude **Pro or Max** subscription | mcp-jobs uses YOUR Claude subscription for all AI work — no API keys, no extra AI costs |
| Google Chrome | Job postings open here; also used to render PDFs |
| [Apify](https://apify.com) account (free) | Job-board search engine (~free tier is enough; spend is capped at $4.50/month by default) |
| Google account (optional) | Recruiter-mail scanning + interview calendar prep |

## Install (5 steps)

1. **Unzip** this package into a permanent folder, e.g. `C:\mcp-jobs\`
   (everything it creates — your profile, database, generated PDFs — lives in
   this folder; don't put it somewhere temporary).
2. **Install Node.js 22 LTS** from nodejs.org, and **Claude Code CLI** if you
   don't have it — open a terminal, run `claude`, and follow the login.
   You need Claude Pro or Max.
3. **Run the wizard**: double-click `setup.bat` (macOS/Linux: `./setup.sh`), or
   run `node mcp-jobs.cjs setup` in a terminal. It walks you through: Apify
   token → Google (optional) → your profile (drop your LinkedIn data export PDF
   and your CV PDF into the `CV\` folder when asked).
4. **Connect Claude Desktop**: the wizard prints a JSON block at the end —
   paste it into Claude Desktop → Settings → Developer → Edit Config, then
   restart Claude Desktop.
5. **Try it**: in Claude Desktop, type *"search for jobs"* or *"buscá trabajo"*.

## Daily use

| Say to Claude | What happens |
|---|---|
| "search for jobs" | Searches job boards, scores each against your profile |
| "prepare the 8+ ones" | One at a time: opens the job in Chrome, shows you the tailored CV + cover letter for review |
| "I applied to Acme" | Marks it applied |
| "check my mail" | Finds genuine recruiter outreach, drafts replies (as Gmail drafts) |
| "prep me for my interview" | Builds a prep brief from your calendar, saved as PDF |
| "how am I doing" | Application pipeline status |

Generated CVs/covers land in `data\generated\<job>\` as PDFs. Interview prep
docs in `data\generated\<job>\prep\`.

## Optional: automatic cycles

Run a search→score→tailor cycle on a schedule (results wait for you in Chrome):

```
node mcp-jobs.cjs run-cycle     # one cycle now
node mcp-jobs.cjs daemon        # keep running, one cycle per hour
```

## Troubleshooting

- **"Failed to spawn Claude CLI"** — install Claude Code and run `claude`
  once to log in. If it's installed somewhere unusual, set `CLAUDE_BIN` in `.env`.
- **Error mentioning `better_sqlite3.node` or NODE_MODULE_VERSION** — your
  Node version isn't 22 LTS. Install Node 22 from nodejs.org.
- **Gmail/Calendar tools say "not configured"** — they're optional; run setup
  again and complete the Google step to enable them.
- **Mail or calendar stopped working after a few days** (errors mentioning
  `invalid_grant`, "token expired or revoked") — **double-click `auth.bat`**
  (macOS/Linux: `./auth.sh`) and approve access again. This is normal: while
  your Google OAuth app is in *Testing* status, Google expires its access after
  about a week. To stop it recurring, open Google Cloud Console → *OAuth consent
  screen* → **Publish app**. It stays your own private app; publishing only
  removes the testing-mode expiry.
- **search_jobs returns nothing** — check `APIFY_TOKEN` in `.env`, or your
  monthly Apify budget may be spent (`APIFY_BUDGET_USD`, default $4.50).
  Claude will fall back to web search automatically.
- **Claude Desktop doesn't show the tools** — verify the config JSON path to
  `mcp-jobs.cjs` is correct and restart Claude Desktop completely (tray icon → Quit).

## Privacy

Everything stays on your machine: profile, CVs, database, generated documents.
The only network calls are to services you configured with your own accounts
(Apify, Google, your Claude subscription).
