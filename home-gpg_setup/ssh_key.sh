#!/bin/dash
set -e
#https://medium.com/risan/upgrade-your-ssh-key-to-ed25519-c6e8d60d3c54
ssh-keygen -oa 100 -t ed25519 -f "$XDG_RUNTIME_DIR"/id_ed25519 -C "$USER"@"$(hostname)"
SSH_AUTH_SOCK="$XDG_RUNTIME_DIR"/gnupg/S.gpg-agent.ssh ssh-add "$XDG_RUNTIME_DIR"/id_ed25519
exec rm "$XDG_RUNTIME_DIR"/id_ed25519*
