#!/bin/dash
systemctl stop ipts_rust_multitouch
./ipts-reset
rmmod ipts
modprobe ipts
exec systemctl start ipts_rust_multitouch
