#!/bin/dash
modprobe ashmem_linux
modprobe binder_linux
mount -o remount,dev,suid /var
/home/home/Downloads/anbox/scripts/anbox-bridge.sh start
export ANBOX_LOG_LEVEL=debug
export LD_DEBUG=libs
exec anbox container-manager --daemon --privileged --data-path=/var/lib/anbox
