#!/bin/bash
scrot /tmp/screenshot.png
convert /tmp/screenshot.png -scale 10% -scale 1000% /tmp/screenshotblur.png
# convert /tmp/screenshotblur.png -blur 0x1 /tmp/screenshotblur.png
i3lock -i /tmp/screenshotblur.png -d -u
