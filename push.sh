#!/usr/bin/env bash

DIR=$(dirname $(dirname $(realpath "$0")))
cd $DIR
set -ex

cd $DIR/static
tag=$(git describe --tags --abbrev=0)
git push
git push origin $tag

cd $DIR
git add -A
git commit -m$tag
git push

echo $tag
