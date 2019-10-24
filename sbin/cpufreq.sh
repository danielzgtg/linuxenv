#!/bin/bash
echo userspace | tee /sys/devices/system/cpu/cpufreq/policy*/scaling_governor
echo $1 | tee /sys/devices/system/cpu/cpufreq/policy*/scaling_setspeed

