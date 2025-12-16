#!/bin/dash
set -e
nmcli connection modify 'Wired Connection 1' 802-3-ethernet.mtu 1492 # PPPoE
nmcli connection modify 'Wired Connection 1' ipv6.method disabled # Please hurry up, O–Bell Canada
