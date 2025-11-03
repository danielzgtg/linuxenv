#!/bin/bash
set -e
umask 177

if [ $UID -ne 0 -o $# -ne 2 ]; then
  echo 'Usage: sudo ./luksformat.sh /dev/sda1 label'
  exit 1
fi

if ! [[ "$2" =~ ^[a-z]{3,15}$ ]]; then
  echo 'Invalid label'
  exit 1
fi

if ! [ -b "$1" -o -f "$1" ]; then
  echo 'Invalid device '"$1"
  exit 1
fi

read -rsp 'Password to overwrite '"$1"' with? ' password
echo

if [[ ! "$password" =~ ^[0-9A-Za-z]{8,100}$ ]]; then
  echo 'Invalid password'
  exit 1
fi

declare -a args=(
  --batch-mode
  --cipher=aes-xts-plain64
  --force-password
  --hash=sha256
  --key-size=512
  --key-slot=0
  --keyslot-cipher=aes-xts-plain64
  --keyslot-key-size=512
  --label="$2"
  --pbkdf-force-iterations=10
  --pbkdf-memory=4194304
  --pbkdf-parallel=4
  --pbkdf=argon2id
  --sector-size=4096
  --type=luks2
  # Hopefully digest iterations=1000 impairsn't security: https://unix.stackexchange.com/a/619299/524752
)

# # NVM, this prevents only bitrot not replay
#read -n1 -rp 'Integrity [yN]?' integrity
#[ "$integrity" = y ] && args+=(
#  --integrity='hmac-sha256'
#  --integrity-key-size=256
#  --integrity-no-wipe
#)

<<<"$password" cryptsetup luksFormat "$1" "${args[@]}"

args=(
  --allow-discards
  --batch-mode
  --disable-external-tokens
  --integrity-no-journal
  --key-slot=0
  --perf-high_priority
  --perf-no_read_workqueue
  --perf-no_write_workqueue
  --perf-same_cpu_crypt
  --perf-submit_from_crypt_cpus
  --persistent
  --readonly
  --type=luks2
)

<<<"$password" cryptsetup luksOpen "$1" "$2" "${args[@]}"
exec cryptsetup close "$2"
