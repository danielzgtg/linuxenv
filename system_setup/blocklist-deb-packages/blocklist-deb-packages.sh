#!/bin/dash
set -e
equivs-build blacklist-deb-packages
dpkg -i blacklist-deb-packages_1.0_all.deb
exec rm blacklist-deb-packages_*
