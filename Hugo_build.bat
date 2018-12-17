rmdir /Q /S docs
hugo --enableGitInfo --cleanDestinationDir --forceSyncStatic --gc --destination /docs 
git add docs/*
pause