#!/bin/bash
set -e
rm -f ttf
rm -f *.zip
VERSION='2.242'
NAME='JetBrainsMono-'"$VERSION"'.zip'
wget 'https://github.com/JetBrains/JetBrainsMono/releases/download/v'"$VERSION"/"$NAME"
if ! sha256sum "$NAME" | grep -q 4e315b4ef176ce7ffc971b14997bdc8f646e3d1e5b913d1ecba3a3b10b4a1a9f; then
  echo 'Hash Error'
  exit 1
fi
unzip -ojd ttf "$NAME" 'fonts/ttf/*'
unlink "$NAME"
exa -l ttf
exec sync
