#!/bin/dash
set -e
rm -rf backup
mkdir backup
cp -T ~/'.local/share/Anki2/User 1/collection.anki2' backup/collection.anki2
exec exa -l backup
