#!/bin/bash
set -e
rm -f current
rm -rf gradle-*
TARGET='gradle-7.5.1'
NAME='gradle-7.5.1-all.zip'
wget https://services.gradle.org/distributions/"$NAME"
if ! sha256sum "$NAME" | grep -q db9c8211ed63f61f60292c69e80d89196f9eb36665e369e7f00ac4cc841c2219; then
  echo 'Hash Error'
  exit 1
fi
unzip "$NAME"
exa -l "$TARGET"
unlink "$NAME"
ln -s "$TARGET" current
exec sync
