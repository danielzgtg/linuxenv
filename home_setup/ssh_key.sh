#!/bin/dash
set -e

if [ -f /dev/shm/home-gpg/pubring.kbx ]; then
  cp -t ~/.gnupg /dev/shm/home-gpg/{pubring.kbx,trustdb.gpg}
  chmod go-rwx -R ~/.gnupg
fi

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR"/gnupg/S.gpg-agent.ssh

#https://medium.com/risan/upgrade-your-ssh-key-to-ed25519-c6e8d60d3c54
ssh-keygen -oa 100 -t ed25519 -f "$XDG_RUNTIME_DIR"/id_ed25519 -C "$USER"@"$(hostname)"
ssh-add "$XDG_RUNTIME_DIR"/id_ed25519
rm "$XDG_RUNTIME_DIR"/id_ed25519*

ssh-add -L > ~/.ssh/id_edd25519.pub
