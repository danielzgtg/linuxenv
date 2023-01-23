#!/bin/bash
set -e
cd ../system
dpkg-divert --local --rename --divert '/etc/apt/apt.conf.d/#50appstream' /etc/apt/apt.conf.d/50appstream
dpkg-divert --local --rename --divert '/usr/share/X11/xkb/symbols/#jp' /usr/share/X11/xkb/symbols/jp
cp -T usr/share/X11/xkb/symbols/jp /usr/share/X11/xkb/symbols/jp
chmod 644 /usr/share/X11/xkb/symbols/jp
echo Done
