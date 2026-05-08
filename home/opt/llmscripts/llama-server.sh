#!/bin/bash
set -e

publish=
if [ $# -eq 2 ] && [ "$1" = '--publish' ]; then
  publish=1
  shift
fi
if [ $# -ne 1 ]; then
  echo 'Usage: ./llama-server.sh [--publish] ./Meta-Llama-3.1-8B-Instruct-Q4_K_M.gguf'
  exit 1
fi
if [ ! -f "$1" ]; then
  echo 'File nonexistent'
  exit 1
fi

exe=~/CLionProjects/llamacpprocm/build/bin/llama-server
# . /opt/intel/oneapi/2025.0/oneapi-vars.sh
# exe=~/CLionProjects/llama-intel/build/bin/llama-server
# "$exe" --version # Cache
echo ----

declare -a args=(-ngl 99 --ctx-size 8192 --jinja)
if [ -n "$publish" ]; then
  args+=(--host 0.0.0.0)
fi
set +e
# nocache "$exe" -ngl 99 --ctx-size 4096 -m "$1"
# nocache "$exe" "${args[@]}" -m "$1"
"$exe" "${args[@]}" -m "$1"

echo ----
# 6% or so is still cached despite nocache
#exec cachedel "$1"
