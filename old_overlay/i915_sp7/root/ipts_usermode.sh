#!/bin/dash
set -e
service ipts_rust_multitouch stop
chmod a+rwX -R /dev/ipts
echo Done
