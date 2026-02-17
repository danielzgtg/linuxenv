#!/bin/dash
set -e
./cpufreq.sh 2000000
#intel_gpu_frequency -c 'min=300 max=400'
echo 400 | tee /sys/devices/pci0000:00/0000:00:02.0/drm/card0/gt_boost_freq_mhz
echo 300 | tee /sys/devices/pci0000:00/0000:00:02.0/drm/card0/gt_min_freq_mhz
echo 400 | tee /sys/devices/pci0000:00/0000:00:02.0/drm/card0/gt_max_freq_mhz
