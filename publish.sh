cat package.json | jq 'del(.version)' | jq '. + { "version": "sdkver" }'>>tmp
mv tmp package.json
sed -i '' 's/sdkver/'"$1"'/'  package.json
git add -A
git commit -m "uv"
git pull
git push
git subtree split --prefix=. --branch upm
git tag $1 upm
git push origin upm --tags