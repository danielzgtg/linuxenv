#!/bin/bash
set -e
[ $# -eq 0 ] || { echo 'Usage: ./archive.sh'; exit 1; }
[ -f violentmonkey ] || { echo './violentmonkey missing'; exit 1; }
scripts=(*.js)
[ "${#scripts[@]}" -gt 1 ] || { echo 'Missing (multiple) userscripts'; exit 1; }
rm -rf "$XDG_RUNTIME_DIR"/violentmonkey-import
mkdir "$XDG_RUNTIME_DIR"/violentmonkey-import
cp -t "$XDG_RUNTIME_DIR"/violentmonkey-import violentmonkey "${scripts[@]}"
pushd "$XDG_RUNTIME_DIR"/violentmonkey-import
truncate=truncate
touch test
truncate -s -1 test 2>/dev/null || truncate=gnutruncate
unlink test
for path in "${scripts[@]}" violentmonkey; do
  sed -i '$a\' "$path"
  "$truncate" -s -1 "$path"
done
7z a violentmonkey-import.zip violentmonkey "${scripts[@]}"
popd
rm -f violentmonkey-import.zip
cp -T "$XDG_RUNTIME_DIR"/violentmonkey-import/violentmonkey-import.zip violentmonkey-import.zip
rm -rf "$XDG_RUNTIME_DIR"/violentmonkey-import

