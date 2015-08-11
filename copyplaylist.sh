#!/bin/bash
mkdir /run/media/danieln/danieln/Music
cat ~/.config/mpd/playlists/top.m3u | grep -v '#' | \
while read i; do cp "/run/media/danieln/media/Music/${i}" /run/media/danieln/danieln/Music; done
