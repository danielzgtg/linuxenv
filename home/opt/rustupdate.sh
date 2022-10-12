#!/bin/bash
set -e
cd ~/.rustup
rm -rf downloads tmp
if ! sha256sum settings.toml | grep -q 3b34694c78cf6aaa4b1c998892e03a65a766b4db6a54417063ff18910682b9d9; then
  echo 'settings.toml Hash Error'
  exit 1
fi
if ! ls -1 toolchains/ | wc -l | grep -q '^1$'; then
  echo 'Too many toolchains'
  exit 1
fi
~/.cargo/bin/rustup update
tldr --update
~/.cargo/bin/cargo-install-update install-update -af || true
