@echo off
if exist "%~dp0RevisionId" rd "%~dp0RevisionId" /Q /S
for /f "delims=" %%a in ('dir /b "%~dp0*.cab" ^| find /V "package.cab"') do (
echo extracting %%a..
7z e "%~dp0%%a" "l\en" -o"%~dp0RevisionId" > nul 2>&1
)
pause
