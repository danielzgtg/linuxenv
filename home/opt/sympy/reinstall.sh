#!/bin/bash
set -e
eatmydata rm -rf venv
eatmydata python3 -m venv venv
. venv/bin/activate
eatmydata pip3 install ipython numpy sympy
pip freeze
exec sync
