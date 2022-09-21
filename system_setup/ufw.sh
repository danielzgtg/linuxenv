#!/bin/dash
set -e
ufw allow in on enp4s0 log proto tcp to any port 2222
ufw allow 1714:1764/tcp
ufw allow 1714:1764/udp
