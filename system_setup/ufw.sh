#!/bin/bash
set -eu

ethernet=(/sys/class/net/en*)
if [ ! -d "$ethernet" ]; then
  echo 'No ethernet interface, skipping'
  exit 0
fi
ethernet="${ethernet##*/}"

ingress() {
  ufw allow in on "$ethernet" to 0.0.0.0/0 "$@"
}

ingress_log() {
  ufw allow in on "$ethernet" log to 0.0.0.0/0 "$@"
}

ingress proto tcp port 1714:1764 comment 'kdeconnect'
ingress_log proto tcp port 2222 comment 'ssh'
ingress proto tcp port 4200 comment 'angular'
ingress proto tcp port 4713 comment 'pulseaudio'
ingress port 6881 comment 'ktorrent'
ingress proto udp port 7881,8881 comment 'ktorrent'
ingress proto tcp port 8000,8080 comment 'weblocal'

#egress proto tcp port 22,2222 comment 'ssh'
#egress port 443 comment 'web'
#egress proto tcp port 465,993 comment 'email'
#egress proto tcp port 4713 comment 'pulseaudio'
