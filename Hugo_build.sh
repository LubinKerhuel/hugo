hugo version

hugo --environment production -F --gc --cleanDestinationDir --minify --enableGitInfo --forceSyncStatic --destination ./docs 
hugo --environment production -F --minify --enableGitInfo --destination ./docs 

git add docs/*

