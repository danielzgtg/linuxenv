#!/bin/bash
set -e
rm -f current
rm -rf graalvm*
VERSION='22.3.1'
TARGET='graalvm-ce-java19-'"$VERSION"
NAME='graalvm-ce-java19-linux-amd64-'"$VERSION"'.tar.gz'
wget 'https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-'"$VERSION"/"$NAME"
if ! sha256sum "$NAME" | grep -q 7cd99d805e7a8b7d4c4576802fb107fb862944e47ce5f2e4f37c0f469a70dd2f; then
  echo 'Hash Error'
  exit 1
fi
tar xzvf "$NAME"
exa -l "$TARGET"
unlink "$NAME"
ln -s "$TARGET" current
exec sync
