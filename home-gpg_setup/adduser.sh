#!/bin/dash
set -eu
[ -d /home/home ] || { echo 'Install /home/home first'; exit 1; }
[ -d ../home-gpg ] || { echo 'Must chdir to script directory'; exit 1; }
oldkeys="$(echo /home/home-gpg/.gnupg/private-keys-v1.d/*)"
if [ "$oldkeys" != '/home/home-gpg/.gnupg/private-keys-v1.d/*' ]; then
  echo 'Refusing to delete existing keys'
  exit 1
fi

loginctl kill-user home-gpg 2>/dev/null && loginctl terminate-user home-gpg 2>/dev/null || :
deluser --remove-home home-gpg 2>/dev/null || :
adduser home-gpg --ingroup home --disabled-password --comment ''
cp -rT ../home-gpg /home/home-gpg
chmod -R a-rwx,u+rX /home/home-gpg
chown -R home-gpg:home /home/home-gpg
chmod 700 /home/home-gpg/.gnupg
chmod 500 /home/home-gpg/pinentry
loginctl enable-linger home-gpg

echo Done
