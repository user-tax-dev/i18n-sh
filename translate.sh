#!/usr/bin/env bash

DIR=$(dirname $(realpath "$0"))
cd $DIR

direnv allow . && eval "$(direnv export bash)"

set -ex
transalte() {
  ./node_modules/@u7/i18n/lib/i18n.js -d $DIR/$1 en
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

cd ..
OUT=../api/pkg/user
if [ -d "$OUT" ]; then
  cp gen/i18n.js $OUT/ERR.js
fi
