#!/bin/bash
set -e
rm -rf venv lib
mkdir -p lib
pushd lib
VERSION='1.2023.0'
NAME='plantuml-'"$VERSION"'.jar'
wget 'https://github.com/plantuml/plantuml/releases/download/v'"$VERSION"/"$NAME"
if ! sha256sum "$NAME" | grep -q 0404edcf0af28e5b409bc17aa59ad8b05051f47347377749c46c8018135d0dec; then
  echo 'Hash Error'
  #exit 1
fi
popd
python3 -m venv venv
. venv/bin/activate
pip3 install markdown markdown-checklist plantuml_markdown PyYAML six Pygments
pygmentize -S default -f html -a .codehilite > lib/styles.css
pip freeze
exa -l lib
exec sync
