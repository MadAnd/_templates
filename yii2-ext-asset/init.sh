#!/bin/env bash

# predefined variables
GITHUB_USER=madand

###############################################################################

# stop script on error
set -e

# USAGE: get_user_input VAR-NAME [PROMPT-TEXT]
# DESCRIPTION: Prompt the user for input, with optional PROMPT-TEXT and sore it in the variable named VAR-NAME.
get_user_input() {
    PROMPT_TEXT=${2:-''}
    if [ "$PROMPT_TEXT" != "" ]; then
        echo -n "$PROMPT_TEXT: "
    fi

    eval read $1
}

EXTKEY=$(basename "$PWD")
NAMESPACE=$(echo "$EXTKEY" | tr -cd '[:alnum:]' | sed 's/^yii2//')

# prompt user for needed values
get_user_input CLASS_NAME "ClassName"
get_user_input BOWER_NAME "bower-name"
get_user_input ASSET_URL "asset-url"

mv src/Asset.php src/${CLASS_NAME}Asset.php

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
git tag 0.1.0

# create github repo
DESCRIPTION=$(sed -n '1s/# //p' README.md)
curl -u $GITHUB_USER --data '{"name": "'$EXTKEY'", "description": "'"$DESCRIPTION"'"}' https://api.github.com/user/repos

git remote add origin git@github.com:$GITHUB_USER/$EXTKEY.git
git push --all --set-upstream origin master

rm $0

exit 0
