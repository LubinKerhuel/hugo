start http://localhost:1313 &
hugo server -t "academic" --i18n-warnings --disableFastRender -D --port 1313 --enableGitInfo --forceSyncStatic  --gc --noHTTPCache --cleanDestinationDir --ignoreCache &
pause