#!/bin/bash
set -e
eatmydata rm -rf venv
eatmydata python3 -m venv venv
. venv/bin/activate
eatmydata pip3 install wheel
eatmydata pip3 install oathtool
pip freeze
exec sync
