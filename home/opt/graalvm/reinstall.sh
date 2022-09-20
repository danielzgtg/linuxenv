#!/bin/bash
set -e
rm -f current
rm -rf graalvm*
VERSION='22.2.0'
TARGET='graalvm-ce-java17-'"$VERSION"
NAME='graalvm-ce-java17-linux-amd64-'"$VERSION"'.tar.gz'
wget 'https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-'"$VERSION"/"$NAME"
if ! sha256sum "$NAME" | grep -q cd903566d030bf44a8c5c0f50914fc9c9d89cb2954e1f90512b137a0bfedc3ca; then
  echo 'Hash Error'
  exit 1
fi
tar xzvf "$NAME"
exa -l "$TARGET"
unlink "$NAME"
ln -s "$TARGET" current
exec sync
