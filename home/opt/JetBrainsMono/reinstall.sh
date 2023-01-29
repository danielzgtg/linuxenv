#!/bin/bash
set -e
rm -rf ttf
rm -f *.zip
VERSION='2.304'
NAME='JetBrainsMono-'"$VERSION"'.zip'
wget 'https://github.com/JetBrains/JetBrainsMono/releases/download/v'"$VERSION"/"$NAME"
if ! sha256sum "$NAME" | grep -q 6f6376c6ed2960ea8a963cd7387ec9d76e3f629125bc33d1fdcd7eb7012f7bbf; then
  echo 'Hash Error'
  exit 1
fi
unzip -ojd ttf "$NAME" 'fonts/ttf/*'
unlink "$NAME"
fc-cache -fv
exa -l ttf
exec sync
