# NSand

liNux nameSpace sANDbox

## Features

* Portable, shell-only

## Usage

```bash
~/opt/nsand/nsand [optional command]
```

## Requirements

* `sysctl -w kernel.unprivileged_userns_clone=1`
* `sysctl -w kernel.apparmor_restrict_unprivileged_unconfined=0`
* `sysctl -w kernel.apparmor_restrict_unprivileged_userns=0`

## License

SPDX-License-Identifier: GPL-2.0-or-later
