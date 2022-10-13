#!/bin/bash
set -e
cd ~
ARCHIVE="$XDG_RUNTIME_DIR"'/rust_nvm.tar.gz'
rm -f .cargo/.crates.toml .cargo/.crates2.json .cargo/.rustc_info.json opt/nvmstub "$ARCHIVE"
rm -rf .cargo/bin .rustup .nvm .cache/tealdeer
scp -P 2222 home@daniel-desktop2.local:opt/rust_nvm.tar.gz "$ARCHIVE"
tar xzvf "$ARCHIVE"
pushd .nvm
git reset --hard
. ./nvm.sh
mkdir alias
echo node > alias/default
nvm ls
popd
exec unlink "$ARCHIVE"
