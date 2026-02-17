#!/bin/dash
set -e
# https://unix.stackexchange.com/a/474378
echo 1 > /sys/bus/pci/devices/0000:01:00.0/remove
echo 1 > /sys/bus/pci/devices/0000:01:00.1/remove
echo removed
sleep 1
setpci -s 0000:00:02.1 BRIDGE_CONTROL=0x005a
sleep 0.01
setpci -s 0000:00:02.1 BRIDGE_CONTROL=0x004a
sleep 0.5
echo 1 > /sys/bus/pci/devices/0000:00:02.1/rescan
