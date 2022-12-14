#!/usr/bin/env bash

DIR=$(dirname $(realpath "$0"))
cd $DIR

direnv allow

set -ex
transalte() {
  ./node_modules/@iuser/i18n/lib/i18n.js -d $DIR/$1 zh
  cd $DIR/$1
  #cp zh.it zh.it.bak
  #git checkout zh.it
  #opencc -i zh.it -c s2t -o zh-TW.it
  #sd -s ' ."' '"' $(fd -e json)
  #sd " \.$" "" $(fd -e it)
  cd $DIR
}

transalte ..

cd $DIR/..
for lang in zh ja km lo th; do
  sd -s '？' '?' $lang.it
  sd -s ' ?' '?' $lang.it
  sd -s '?  ' '? ' $lang.it
done

cd $DIR
direnv exec . ./i18n2id.coffee
cp ../gen/i18n.js ../../api/src/ERR.js
