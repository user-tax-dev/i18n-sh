#!/usr/bin/env bash

DIR=$(dirname $(realpath "$0"))
cd $DIR

direnv allow

set -ex
transalte(){
cd $DIR/$1
i18n en
git checkout zh.it
opencc -i zh.it -c s2t -o zh-TW.it
sd " \.$" "" $(fd -e it)
cd $DIR
}

transalte ..
direnv exec . ./i18n2id.coffee
