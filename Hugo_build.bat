rmdir /Q /S docs
hugo -t "academic" --i18n-warnings --enableGitInfo --cleanDestinationDir --forceSyncStatic --destination /docs 
git add docs/*
pause