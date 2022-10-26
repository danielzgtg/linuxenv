#!/bin/bash
set -e
rm -f current
rm -rf graalvm*
VERSION='22.3.0'
TARGET='graalvm-ce-java19-'"$VERSION"
NAME='graalvm-ce-java19-linux-amd64-'"$VERSION"'.tar.gz'
wget 'https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-'"$VERSION"/"$NAME"
if ! sha256sum "$NAME" | grep -q ae9cb1afe327d49a8c049ab588090838e622d9d832b9a1c0523821a6f38d6b4d; then
  echo 'Hash Error'
  exit 1
fi
tar xzvf "$NAME"
exa -l "$TARGET"
unlink "$NAME"
ln -s "$TARGET" current
exec sync
