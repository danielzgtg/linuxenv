#!/bin/bash
set -e
cd ../system
dpkg-divert --local --rename --divert '/etc/apt/apt.conf.d/#50appstream' /etc/apt/apt.conf.d/50appstream
echo Done
