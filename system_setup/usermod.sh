#!/bin/dash
set -e
usermod -aG systemd-journal home
usermod -aG wireshark home
usermod -aG docker home
usermod -aG lpadmin home
