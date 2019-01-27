start http://localhost:1313 &
hugo server --port 1313 -t "academic" -F -D --i18n-warnings --gc --minify --enableGitInfo --cleanDestinationDir --forceSyncStatic  --noHTTPCache --disableFastRender --navigateToChanged &
pause

# --ignoreCache cause render issues !