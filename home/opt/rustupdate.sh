#!/bin/bash
set -e
cd ~/.rustup
rm -rf downloads tmp
if ! sha256sum settings.toml | grep -q 47dd8d63991c4b85dd223d77672d7ee3fe0ac0d808d082fe03edf3c7bc5ea9cd; then
  echo 'settings.toml Hash Error'
  exit 1
fi
if ! ls -1 toolchains/ | wc -l | grep -q '^1$'; then
  echo 'Too many toolchains'
  exit 1
exit
~/.cargo/bin/rustup update
tldr --update
~/.cargo/bin/cargo-install-update install-update -af || true
