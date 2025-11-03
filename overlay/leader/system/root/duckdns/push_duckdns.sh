#!/bin/bash
set -e

DOMAIN='danielzgtg'
TOKEN="$(systemd-creds cat duckdns --newline=no)"
#TOKEN="$(base64 -d token_base64.txt)"
if [[ ! "$TOKEN" =~ [a-z0-9]{8}-[a-z0-9]{4}-[a-z0-9]{4}-[a-z0-9]{4}-[a-z0-9]{12} ]]; then
  echo 'Corrupt token'
  exit 1
fi

curl -sS 'https://www.duckdns.org/update?domains='"$DOMAIN"'&token='"$TOKEN"'&verbose=true'
