xdg-open http://localhost:1313
hugo version &
hugo server --port 1313 -t "academic/wowchemy" -F --i18n-warnings --gc --minify --enableGitInfo --cleanDestinationDir --forceSyncStatic --noHTTPCache --disableFastRender &
