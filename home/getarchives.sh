#!/bin/bash
set -e
mkdir -p archives
cd archives
exec rsync -avP --stats -e "ssh -p 2222" 'home@daniel-desktop3.local:/var/cache/apt/archives/*' .
