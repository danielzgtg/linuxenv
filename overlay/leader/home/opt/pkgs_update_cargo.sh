#!/bin/dash
set +e
rm -rf ~/cargo_install_update_tmp
mkdir ~/cargo_install_update_tmp
mount --bind ~/cargo_install_update_tmp /tmp
nice cargo install --path . --force --features=feature_capable
rm -rf ~/cargo_install_update_tmp
:
