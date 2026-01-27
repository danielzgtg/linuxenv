#!/bin/bash
set -e
[ $# -eq 0 ] || { echo 'Usage: ./extract.sh'; exit 1; }
matching=(violentmonkey_*.zip)
[ "${#matching[@]}" -eq 1 ] && [ -f "$matching" ] || { echo 'Need exactly 1 zip'; exit 1; }
rm -f *.js violentmonkey violentmonkey.zip
7z x "$matching"
for path in *.js violentmonkey; do
  sed -i '$a\' "$path"
done
exec rm violentmonkey*.zip
