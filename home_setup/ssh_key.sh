#!/bin/dash
#https://medium.com/risan/upgrade-your-ssh-key-to-ed25519-c6e8d60d3c54
exec ssh-keygen -oa 100 -t ed25519 -f ./id_ed25519 -C 'username@hostname'
