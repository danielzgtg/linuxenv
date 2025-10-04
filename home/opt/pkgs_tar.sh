#!/bin/dash
set -e
cd ~
ARCHIVE=~/opt/pkgs.tar.xz
rm -f "$ARCHIVE"
exec nice tar -c -v -I 'xz -9 -T12 -M24G' -f "$ARCHIVE" \
    .cargo/.crates.toml \
    .cargo/.crates2.json \
    .cargo/bin \
    .rustup/settings.toml \
    .rustup/toolchains \
    .nvm/.git \
    .nvm/versions \
    opt/nvmstub \
    .cache/tealdeer \
    .dotnet/tools \
    # Use Lean4web for Lean
