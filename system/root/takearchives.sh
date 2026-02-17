#!/bin/bash
set -e
eatmydata apt update
sync
cd /var/cache/apt/archives
rm -rf *
mv -t . /home/home/archives/*
mount -o remount,rw /
mount -o remount,rw /boot
mount -o remount,rw /boot/efi
eatmydata apt upgrade
sync
eatmydata apt autoremove --purge
sync
rm -rf *
sync
cd ~
eatmydata apt dist-upgrade --purge
sync
./speed-up-dpkg.sh
sync
