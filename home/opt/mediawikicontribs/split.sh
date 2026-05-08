#!/bin/bash
set -e
mkdir -p work
<download.txt awk 'BEGIN{I=0}/\\\\/{I=$2}!/\\\\/{print $0 >"work/" I}'
