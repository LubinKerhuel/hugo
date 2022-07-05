@rem rmdir /Q /S docs
@rem hugo -t "academic/modules/wowchemy" -F --minify --enableGitInfo --cleanDestinationDir  --destination /docs 
hugo version
@rem hugo list drafts 

hugo -t "academic/modules/wowchemy" --environment production -F --gc --cleanDestinationDir --minify --enableGitInfo --forceSyncStatic --destination /docs 
hugo -t "academic/modules/wowchemy" --environment production -F --minify --enableGitInfo --destination /docs 
@rem hugo -t "academic/modules/wowchemy" -F --gc --cleanDestinationDir --minify --enableGitInfo --forceSyncStatic --destination /docs 

git add docs/*
@echo off
@rem  get total number of lines from dir output
FOR /F "delims=" %%i IN ('dir /S docs ^| find "asdfasdfasdf" /C /V') DO set lineCount=%%i
@rem  dir summary is always last 3 lines; calculate starting line of summary info
set /a summaryStart="lineCount-3"
@rem  now output just the last 3 lines
dir /S docs | more +%summaryStart%
pause