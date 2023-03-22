#!/bin/bash
#exec sshfs -p 2222 daniel-desktop3.local:/home/home/ ./mnt
#exec sshfs -p 2222 -o allow_root daniel-desktop3.local:/var/cache/apt/archives ./mnt
#touch /var/cache/apt/archives/lock; mount -t overlay -o lowerdir=/home/home/mnt,upperdir=/var/cache/apt/archives,workdir=/var/cache/apt/work overlayfs /var/cache/apt/archives; rmdir /var/cache/apt/archives/partial
