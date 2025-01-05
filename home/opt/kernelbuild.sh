#!/bin/bash
set -e

rm -f linux*.deb linux-upstream*

pushd kernel
nice make clean
rm -rf debian
nice make -j24 bindeb-pkg # bindeb is faster and allows dirty rebuilds
nice make -C tools/perf # The Ubuntu not Debian scripts are overcomplicated, so just use Make
popd

rm linux-libc-dev*.deb # Avoid risking conflicts with Ubuntu versions
rm linux*-dbg_*.deb # I don't use dbg, so delete to prevent installing when using glob
cp -T kernel/tools/perf/perf ./perf

debs=(*.deb)
echo -n 'Done

Suggested:
- sudo dpkg -i '"${debs[@]}"'
- cp -T ./perf ~/bin/perf
'
