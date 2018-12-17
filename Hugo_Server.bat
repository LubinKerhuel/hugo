start http://localhost:1313 &
hugo server -D --port 1313 --enableGitInfo --disableFastRender --forceSyncStatic  --gc --noHTTPCache --cleanDestinationDir --ignoreCache &
pause