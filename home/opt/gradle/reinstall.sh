#!/bin/bash
set -e
rm -f current
rm -rf gradle-*
TARGET='gradle-7.6'
NAME='gradle-7.6-all.zip'
wget https://services.gradle.org/distributions/"$NAME"
if ! sha256sum "$NAME" | grep -q 312eb12875e1747e05c2f81a4789902d7e4ec5defbd1eefeaccc08acf096505d; then
  echo 'Hash Error'
  exit 1
fi
unzip "$NAME"
exa -l "$TARGET"
unlink "$NAME"
ln -s "$TARGET" current
exec sync
