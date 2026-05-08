#!/bin/bash
set -e
rm -f current
rm -rf gradle-*
TARGET='gradle-9.4.1'
NAME='gradle-9.4.1-all.zip'
wget https://services.gradle.org/distributions/"$NAME"
if ! sha256sum "$NAME" | grep -q 708d2c6ecc97ca9a11838ef64a6c2301151b8dd10387e22dc1a12c30557cab5b; then
  echo 'Hash Error'
  exit 1
fi
unzip "$NAME"
eza -l "$TARGET"
unlink "$NAME"
ln -s "$TARGET" current
exec sync
