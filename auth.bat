@echo off
cd /d "%~dp0"
echo Connecting your Google account (Gmail + Calendar)...
echo A browser window will open. Approve access, then come back here.
echo.
node mcp-jobs.cjs auth
if errorlevel 1 (
  echo.
  echo Auth FAILED. Check that setup.bat has been run and that data\oauth-client.json exists.
)
pause
