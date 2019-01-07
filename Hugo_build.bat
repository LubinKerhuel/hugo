rmdir /Q /S docs
hugo -t "academic" --i18n-warnings --gc --minify --enableGitInfo --cleanDestinationDir --forceSyncStatic --destination /docs 
git add docs/*
@echo off
rem  get total number of lines from dir output
FOR /F "delims=" %%i IN ('dir /S docs ^| find "asdfasdfasdf" /C /V') DO set lineCount=%%i
rem  dir summary is always last 3 lines; calculate starting line of summary info
set /a summaryStart="lineCount-3"
rem  now output just the last 3 lines
dir /S docs | more +%summaryStart%
pause