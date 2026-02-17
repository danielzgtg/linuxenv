#!/bin/dash
cd /sys/class/drm/card1
echo "$1" > gt_max_freq_mhz
echo "$1" > gt_boost_freq_mhz
