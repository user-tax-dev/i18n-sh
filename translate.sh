#!/usr/bin/env bash

DIR=$(dirname $(realpath "$0"))
cd $DIR

direnv allow

set -ex
transalte(){
bun run i18n -- -d $DIR/$1 en
cd $DIR/$1
cp zh.it zh.it.bak
git checkout zh.it
opencc -i zh.it -c s2t -o zh-TW.it
sd -s ' ."' '"' $(fd -e json)
sd " \.$" "" $(fd -e it)
cd $DIR
}

transalte ..
direnv exec . ./i18n2id.coffee
