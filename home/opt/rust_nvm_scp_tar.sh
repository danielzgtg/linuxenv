#!/bin/dash
set -e
cd ~
ARCHIVE=~/opt/rust_nvm.tar.gz
rm -f "$ARCHIVE"
exec tar czvf "$ARCHIVE" .cargo/.crates.toml .cargo/.crates2.json .cargo/bin .rustup/settings.toml .rustup/toolchains .nvm/.git .nvm/versions opt/nvmstub .cache/tealdeer
