@echo off
set b=http://download.windowsupdate.com
set f=microsoftupdate/v6/wsusscan/wsusscn2.cab
set w=%temp%
set i=%w%\wsusscn2.cab
set path=%path%;%~dp0
if not exist "%i%" wget %b%/%f% -P%t%
echo Extracting..
if exist "%w%\u" rd "%w%\u" /Q /S
7z x "%i%" -o"%w%\u" > nul 2>&1
7z x "%w%\u\package.cab" -o"%w%\u" > nul 2>&1
sed "s/<Update /\n\n<Update /g" "%w%\u\package.xml" |^
grep "SupersededBy" |^
sed "s/^.* UpdateId=/UpdateId=/g" |^
sed "s/RevisionNumber.*RevisionId/RevisionId/g" |^
sed "s/IsLeaf.*<SupersededBy></SupersededBy /g" |^
sed "s/ \/><\/SupersededBy>.*$//g" |^
sed "s/ \/><Revision//g" > "%userprofile%\desktop\supersededby.log"
notepad "%userprofile%\desktop\supersededby.log"
pause




