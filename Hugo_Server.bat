rem start http://localhost:1313 &
hugo server --port 1313 -t "academic" -F --i18n-warnings --gc --minify --enableGitInfo --cleanDestinationDir --forceSyncStatic  --noHTTPCache --disableFastRender &

pause

# --ignoreCache cause render issues !