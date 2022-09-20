#!/bin/dash
set -e
curl https://pypi.org/rss/project/anki/releases.xml 2>&- | rg pubDate | tac
