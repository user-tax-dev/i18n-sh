#!/usr/bin/env bash

DIR=$(dirname $(realpath "$0"))
cd $DIR
set -ex

./translate.sh
direnv exec . ./tag.coffee && ./push.sh || true
