#!/bin/bash
echo userspace | tee /sys/devices/system/cpu/cpufreq/policy*/scaling_governor
echo 3000000 | tee /sys/devices/system/cpu/cpufreq/policy*/scaling_setspeed

