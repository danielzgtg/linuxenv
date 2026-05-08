#!/bin/bash
set -x
exec >>download.txt
get() {
sleep 5
echo "\\\\ $1"
curl 'https://en.wikipedia.org/w/api.php?action=compare&format=json&torelative=prev&fromrev='"$1"
echo
}
# get [mediawiki diff number]
