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

egress() {
  ufw allow out to 0.0.0.0/0 "$@"
}

egress_ethernet() {
  ufw allow out on "$ethernet" to 0.0.0.0/0 "$@"
}

ingress proto udp port 137 comment 'winbind'
ingress proto tcp port 1714:1764 comment 'kdeconnect'
ingress_log proto tcp port 2222 comment 'ssh'
ingress proto tcp port 4200 comment 'angular'
ingress proto tcp port 4713 comment 'pulseaudio'
ingress port 6881 comment 'ktorrent'
ingress proto udp port 7881,8881 comment 'ktorrent'
ingress proto tcp port 8000,8080 comment 'web'

egress proto tcp port 22,2222 comment 'ssh'
egress proto tcp port 43 comment 'whois'
egress proto tcp port 80,8000,8080 comment 'web'
egress proto udp port 123 comment 'ntp'
egress proto udp port 137 comment 'winbind'
egress port 443 comment 'web'
[ -f /etc/linuxenv-leader ] && egress proto tcp port 465,993 comment 'email' || :
egress proto tcp port 853 comment 'dnsovertls'
egress_ethernet proto tcp port 4713 comment 'pulseaudio'
egress port 6881 comment 'ktorrent'
egress proto udp port 7881,8881 comment 'ktorrent'

ufw default deny incoming
ufw default deny outgoing
ufw default deny forward # TODO KDE hotspot
