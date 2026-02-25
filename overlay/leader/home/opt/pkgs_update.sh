#!/bin/bash
set -e

# PowerShell
dotnet tool install -g powershell

# Lean
elan toolchain install stable

# Node
cd ~/.nvm
rm -rf .cache
git fetch
git reset --hard origin/master
echo node > alias/default
gitcleanup
. ./nvm.sh
nvm install node --reinstall-packages-from=node
current="$(nvm current)"
ln -s ../.nvm/versions/node/"$current" ~/opt/nodecurrent
rm -rf alias
mkdir alias
echo node > alias/default
nvm ls

# Rust
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
nice ~/.cargo/bin/cargo-install-update install-update -af || true
tldr --update

pushd ~/CLionProjects/qsv
git fetch upstream
git reset --hard upstream/master
nice cargo install --path . --force --features=feature_capable
popd
