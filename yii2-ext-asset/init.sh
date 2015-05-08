#!/bin/sh

set -e

GITHUB_USER=madand

USER_INPUT=''
get_user_input() {
    echo -n "$1: "
    read USER_INPUT
}

EXTKEY=$(basename "$PWD")
NAMESPACE=$(echo "$EXTKEY" | tr -cd '[:alnum:]' | sed 's/^yii2//')

get_user_input "ClassName"
CLASS_NAME=$USER_INPUT

get_user_input "bower-name"
BOWER_NAME=$USER_INPUT

get_user_input "asset-url"
ASSET_URL=$USER_INPUT

find . -type f -print0 -not -name "init.sh" | xargs -0 sed -i'' \
    -e "s!{ext-key}!$EXTKEY!gI" \
    -e "s!{namespace}!$NAMESPACE!gI" \
    -e "s!{ClassName}!$CLASS_NAME!gI" \
    -e "s!{bower-name}!$BOWER_NAME!gI" \
    -e "s!{asset-url}!$ASSET_URL!gI"


git init
git add .
git reset $0
git commit -m 'initial commit'

# create github repo
DESCRIPTION=$(sed -n '1s/# //p' README.md)
curl -u $GITHUB_USER --data '{"name": "'$EXTKEY'", "description": "'"$DESCRIPTION"'"}' https://api.github.com/user/repos

git remote add origin git@github.com:$GITHUB_USER/$EXTKEY.git
git push --set-upstream origin master

rm $0

exit 0
