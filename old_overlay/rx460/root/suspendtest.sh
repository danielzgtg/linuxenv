#!/bin/dash
sync
echo Setup
echo 9 > /proc/sys/kernel/printk
echo 1 > /sys/power/pm_debug_messages
echo 1 > /sys/power/pm_trace
#echo freezer > /sys/power/pm_test
#echo devices > /sys/power/pm_test
#echo platform > /sys/power/pm_test
#echo processors > /sys/power/pm_test
#echo core > /sys/power/pm_test
echo none > /sys/power/pm_test
echo N > /sys/module/printk/parameters/console_suspend
echo 0 > /sys/power/pm_async
echo Set up
while :; do
  echo Before
  sleep 5
  echo Start
  echo mem > /sys/power/state
  echo After, yay!
  sleep 10
  echo Looped
done
