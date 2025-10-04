#!/bin/bash
set -e
cd ~
ARCHIVE="$XDG_RUNTIME_DIR"'/pkgs.tar.xz'
mkdir -p .cargo .dotnet
rm -f .cargo/.crates.toml .cargo/.crates2.json .cargo/.rustc_info.json opt/nvmstub "$ARCHIVE"
rm -rf .cargo/bin .rustup .nvm .cache/tealdeer .dotnet/tools
scp -P 2222 home@daniel-desktop3.local:opt/pkgs.tar.xz "$ARCHIVE"
tar xJvf "$ARCHIVE"
pushd .nvm
git reset --hard
. ./nvm.sh
mkdir alias
echo node > alias/default
nvm ls
popd
exec unlink "$ARCHIVE"
