#!/bin/bash
set -e
# Encrypts and wraps the token to prevent newline is removed

if [ "$#" -ne 0 -or "$EUID" -ne 0 ]; then
  echo 'Usage: sudo ./set_duckdns_token.sh'
  exit 1
  usage
fi

read -rsp 'New DuckDNS token: ' TOKEN
if [[ ! "$TOKEN" =~ [a-z0-9]{8}-[a-z0-9]{4}-[a-z0-9]{4}-[a-z0-9]{4}-[a-z0-9]{12} ]]; then
  echo 'Wrong format'
  exit 1
fi
echo

mkdir -m 700 -p /etc/credstore.encrypted
umask 177
printf "$TOKEN" | systemd-creds encrypt -H - /etc/credstore.encrypted/duckdns
echo Updated
