#!/bin/bash
set -e
eatmydata rm -rf venv
eatmydata python3 -m venv venv --system-site-packages
. venv/bin/activate
eatmydata pip3 install mitmproxy
pip freeze
exec sync
