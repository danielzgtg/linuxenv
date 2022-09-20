#!/bin/bash
set -e
eatmydata rm -rf venv
eatmydata python3 -m venv venv --system-site-packages
. venv/bin/activate
eatmydata pip3 install wheel
eatmydata pip3 install anki matplotlib
eatmydata pip3 install aqt
pip freeze
exec sync
