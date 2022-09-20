#!/bin/bash
echo ondemand | tee /sys/devices/system/cpu/cpufreq/policy*/scaling_governor

