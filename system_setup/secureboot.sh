#!/bin/bash
set -e
mokutil --password
mokutil --import /var/lib/shim-signed/mok/MOK.der
mokutil -N
mokutil --sb-state
