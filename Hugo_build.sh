hugo version

hugo -t "academic/wowchemy" --environment production -F --i18n-warnings --gc --cleanDestinationDir --minify --enableGitInfo --forceSyncStatic --destination ./docs 
hugo -t "academic/wowchemy" --environment production -F --i18n-warnings --minify --enableGitInfo --destination ./docs 

git add docs/*

