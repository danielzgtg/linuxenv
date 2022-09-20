#!/bin/bash
set -e
rm -rf venv lib
mkdir -p lib
pushd lib
VERSION='1.2022.6'
NAME='plantuml-'"$VERSION"'.jar'
wget 'https://github.com/plantuml/plantuml/releases/download/v'"$VERSION"/"$NAME"
if ! sha256sum "$NAME" | grep -q 204def7102790f55d4adad7756b9c1c19cefcb16e7f7fbc056abb40f8cbe4eae; then
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
