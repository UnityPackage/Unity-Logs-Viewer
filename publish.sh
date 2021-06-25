MODEL_PATH="Unity-Logs-Viewer"
cat ${MODEL_PATH}/package.json | jq 'del(.version)' | jq '. + { "version": "sdkver" }'>>tmp
mv tmp ${MODEL_PATH}/package.json
sed -i '' 's/sdkver/'"$1"'/'  ${MODEL_PATH}/package.json
git add -A
git commit -m "uv"
git pull
git push

# git push origin --delete upm
# git branch -D upm
# git push origin :refs/tags/$1

git subtree split --prefix=${MODEL_PATH} --branch upm
git tag $1 upm
git push origin upm --tags
