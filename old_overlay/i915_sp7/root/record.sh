#!/bin/dash
exec ffmpeg -device /dev/dri/card0 -hwaccel vaapi -f kmsgrab -i - -an -vf 'hwmap=derive_device=vaapi,crop=1920:1080:0:0,scale_vaapi=1920:1080:format=nv12' -c:v h264_vaapi output.mp4
