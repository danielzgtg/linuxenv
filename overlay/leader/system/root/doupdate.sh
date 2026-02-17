#!/bin/dash
set -e
apt clean
sync
eatmydata apt update
sync
mount -o remount,rw /
mount -o remount,rw /boot
mount -o remount,rw /boot/efi
eatmydata apt upgrade --download-only -y
eatmydata apt dist-upgrade --download-only -y
eatmydata apt upgrade
sync
eatmydata apt autoremove --purge
sync
eatmydata apt dist-upgrade --purge
sync
eatmydata apt autoremove --purge
sync
/root/speed-up-dpkg.sh
sync
