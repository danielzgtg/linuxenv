#!/bin/dash
set -e
cd ~
ARCHIVE=~/opt/rust_nvm.7z
rm -f "$ARCHIVE"
exec 7z a "$ARCHIVE" .cargo/.crates.toml .cargo/.crates2.json .cargo/bin .rustup/settings.toml .rustup/toolchains .nvm/.git .nvm/versions opt/nvmstub .cache/tealdeer
