#!/bin/sh
# Connect the Google account (Gmail + Calendar) used by mcp-jobs.
# Google expires refresh tokens for apps still in "Testing" after a few days,
# so re-running this when mail/calendar tools start failing is expected.
cd "$(dirname "$0")" || exit 1

if ! command -v node >/dev/null 2>&1; then
  echo "Node.js is not installed or not on PATH. Install Node 22 LTS: https://nodejs.org"
  exit 1
fi

echo "Connecting your Google account (Gmail + Calendar)..."
echo "A browser window will open. If it does not, copy the URL printed below."
echo ""
node mcp-jobs.cjs auth
STATUS=$?
if [ "$STATUS" -ne 0 ]; then
  echo ""
  echo "Auth FAILED. Run ./setup.sh first, and check that data/oauth-client.json exists."
fi
printf "\nPress Enter to close..."
read _ignored
exit "$STATUS"
