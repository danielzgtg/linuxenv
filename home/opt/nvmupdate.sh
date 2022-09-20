#!/bin/bash
set -e
cd ~/.nvm
rm -rf .cache
git fetch
git reset --hard origin/master
echo node > alias/default
gitcleanup
. ./nvm.sh
nvm install node --reinstall-packages-from=node
echo 'export PATH="$NVM_DIR/versions/node/'"$(nvm current)"'/bin:$PATH"' > ~/opt/nvmstub
rm -rf alias
mkdir alias
echo node > alias/default
nvm ls
