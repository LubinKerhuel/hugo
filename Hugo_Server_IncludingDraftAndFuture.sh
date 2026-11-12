hugo version &
xdg-open http://localhost:1313
xdg-open http://localhost:1313/slides/motor-param-identification/
hugo server --port 1313 -F -D --gc --minify --enableGitInfo --cleanDestinationDir --forceSyncStatic  --noHTTPCache --disableFastRender &
