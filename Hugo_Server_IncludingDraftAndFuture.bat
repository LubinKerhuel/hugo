start http://localhost:1313

hugo version

hugo server --port 1313 -F -D --gc --minify --enableGitInfo --cleanDestinationDir --forceSyncStatic  --noHTTPCache --disableFastRender &
pause

# --ignoreCache cause render issues !