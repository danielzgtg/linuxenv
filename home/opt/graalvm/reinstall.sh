#!/bin/bash
set -e
rm -f current
rm -rf graalvm*
VERSION='25.0.2'
TARGET='graalvm-community-openjdk-'"$VERSION"'+10.1'
NAME='graalvm-community-jdk-'"$VERSION"'_linux-x64_bin.tar.gz'
wget 'https://github.com/graalvm/graalvm-ce-builds/releases/download/jdk-'"$VERSION"/"$NAME"
if ! sha256sum "$NAME" | grep -q e0be791c8fda4d03b6b0a0cb824fef3149736170057b3a515252b44419606af0; then
  echo 'Hash Error'
  exit 1
fi
tar xzvf "$NAME"
eza -l "$TARGET"
unlink "$NAME"
ln -s "$TARGET" current

# Android NDK
# mv current/bin/jlink{,.bak}
# ln -s ../../../jdk-22.0.2/bin/jlink current/bin/jlink

exec sync
