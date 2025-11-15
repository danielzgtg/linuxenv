#!/bin/dash
set -e
chmod 0700 "$XDG_RUNTIME_DIR"/gnupg
# Ensure the systemd gpg-agent is used and no other is launched
killall gpg-agent 2>/dev/null || :
setpriv --landlock-access fs:execute --landlock-rule path-beneath:execute:/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2 --landlock-rule path-beneath:execute:/usr/bin/gpg gpg --full-generate-key
chmod 0710 "$XDG_RUNTIME_DIR"/gnupg

rm -rf ~/.gnupg.bak
cp -rT ~/.gnupg ~/.gnupg.bak
chmod 0000 ~/.gnupg.bak
echo 'Please run:
  cp -t /home/home/.gnupg /home/home-gpg/{pubring.kbx,trustdb.gpg}'
