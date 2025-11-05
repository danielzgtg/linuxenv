#!/bin/dash
systemctl disable cups
systemctl enable cups.socket
systemctl disable docker # but still docker.socket-activatable
systemctl disable containerd # but not docker.service-activatable
systemctl disable NetworkManager-wait-online.service
exec systemctl daemon-reload
