#!/bin/dash
set -e
pushd /dev/shm/home-gpg
popd

chmod 0700 "$XDG_RUNTIME_DIR"/gnupg
# Ensure the systemd gpg-agent is used and no other is launched
killall gpg-agent 2>/dev/null || :
setpriv --landlock-access fs:execute --landlock-rule path-beneath:execute:/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2 --landlock-rule path-beneath:execute:/usr/bin/gpg gpg --full-generate-key
chmod 0710 "$XDG_RUNTIME_DIR"/gnupg

rm -rf ~/.gnupg.bak
cp -rT ~/.gnupg ~/.gnupg.bak
chmod 0000 ~/.gnupg.bak

cp -t /dev/shm/home-gpg ~/.gnupg/{pubring.kbx,trustdb.gpg}
chmod 640 /dev/shm/home-gpg/{pubring.kbx,trustdb.gpg}
# continued in ssh_key.sh
