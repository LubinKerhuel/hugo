xdg-open http://localhost:1313
hugo version &
hugo server --port 1313 -F --gc --minify --enableGitInfo --cleanDestinationDir --forceSyncStatic --noHTTPCache --disableFastRender &
