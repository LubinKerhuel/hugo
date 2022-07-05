d:
cd D:\M91449\MCHP_Blockset\Projects\hugo

start http://localhost:1313
hugo version
hugo server --port 1313 -t "academic/modules/wowchemy" -F --gc --minify --enableGitInfo --cleanDestinationDir --forceSyncStatic --noHTTPCache --disableFastRender &

pause

# --ignoreCache cause render issues !
# --disableFastRender