#!/bin/dash
set -e
modprobe msr
exec wrmsr --all 0x601 0x408
