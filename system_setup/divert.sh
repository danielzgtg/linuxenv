#!/bin/bash
set -e
dpkg-divert --local --rename --divert '/etc/apt/apt.conf.d/#50appstream' /etc/apt/apt.conf.d/50appstream
dpkg-divert --local --rename --divert '/usr/share/X11/xkb/symbols/#level3' /usr/share/X11/xkb/symbols/level3
cp -T '/usr/share/X11/xkb/symbols/#level3' /usr/share/X11/xkb/symbols/level3
chmod 644 /usr/share/X11/xkb/symbols/level3
echo Done
