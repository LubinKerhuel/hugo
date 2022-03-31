hugo version

hugo -t "academic/wowchemy" --environment production -F --gc --cleanDestinationDir --minify --enableGitInfo --forceSyncStatic --destination ./docs 
hugo -t "academic/wowchemy" --environment production -F --minify --enableGitInfo --destination ./docs 

git add docs/*

