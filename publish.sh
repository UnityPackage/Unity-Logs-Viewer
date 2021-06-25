MODEL_PATH="Unity-Logs-Viewer"
cat ${MODEL_PATH}/package.json | jq 'del(.version)' | jq '. + { "version": "sdkver" }'>>tmp
mv tmp ${MODEL_PATH}/package.json
sed -i '' 's/sdkver/'"$1"'/'  ${MODEL_PATH}/package.json
git add -A
git commit -m "uv"
git pull
git push
git subtree split --prefix=${MODEL_PATH} --branch upm$1
git tag $1 upm$1
git push origin upm$1 --tags
