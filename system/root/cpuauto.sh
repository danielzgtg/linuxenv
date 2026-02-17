#!/bin/dash
echo performance | tee /sys/devices/system/cpu/cpufreq/policy*/scaling_governor
echo 5000000 | tee /sys/devices/system/cpu/cpufreq/policy*/scaling_max_freq
