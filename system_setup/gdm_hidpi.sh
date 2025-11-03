#!/bin/dash
exec runuser -u gdm -- dbus-launch --exit-with-session gsettings set org.gnome.desktop.interface scaling-factor 2
