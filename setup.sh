#!/bin/sh
# First-run wizard: license, Apify token, Google credentials, profile import.
cd "$(dirname "$0")" || exit 1

if ! command -v node >/dev/null 2>&1; then
  echo "Node.js is not installed or not on PATH. Install Node 22 LTS: https://nodejs.org"
  exit 1
fi

node mcp-jobs.cjs setup
STATUS=$?
printf "\nPress Enter to close..."
read _ignored
exit "$STATUS"
