#!/bin/dash
set -e
export SYNC_HOST=0.0.0.0
export SYNC_PORT=8000
if [ ! -d ~/.syncserver ]; then
mkdir ~/.syncserver
fi
if [ ! -f ~/.syncserver/home_password ]; then
echo 'Regenerating password'
python3 -c '
import secrets
import string
print("".join(secrets.choice(
string.ascii_letters + string.digits
) for _ in range(99)))' | tee ~/.syncserver/home_password
fi
export SYNC_USER1=home:$(cat ~/.syncserver/home_password)
exec ./anki --syncserver
