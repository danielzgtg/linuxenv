#!/bin/dash
set -e
# Have rustup installed via apt not cURL for security
rustup toolchain install nightly
cargo install cargo-update
exec ~/opt/pkgs_update.sh
