#!/bin/false
# https://unix.stackexchange.com/a/125138/524752
if [ -z "$1" ]; then
  echo 'Usage: . ~/bin/procenviron.sh PID'
else
  while IFS= read -rd '' var; do export "$var"; done </proc/$1/environ
fi
