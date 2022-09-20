#!/bin/dash
echo powersave | tee /sys/devices/system/cpu/cpufreq/policy*/scaling_governor
echo $1 | tee /sys/devices/system/cpu/cpufreq/policy*/scaling_setspeed
