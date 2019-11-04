#!/bin/bash

# Example locker script -- demonstrates how to use the --transfer-sleep-lock
# option with i3lock's forking mode to delay sleep until the screen is locked.

## CONFIGURATION ##############################################################

# Options to pass to i3lock
i3lock_options="-i /tmp/screenshotblur.png $1"

# Run before starting the locker
pre_lock() {
    #mpc pause
    scrot /tmp/screenshot.png
    convert /tmp/screenshot.png -scale 10% -scale 1000% /tmp/screenshotblur.png
    return
}

# Run after the locker exits
post_lock() {
    rm /tmp/screenshot.png
    rm /tmp/screenshotblur.png
    # xinput set-prop "TPPS/2 IBM TrackPoint" "Device Accel Constant Deceleration" 0.2
    # xinput set-prop "SynPS/2 Synaptics TouchPad" "Synaptics Scrolling Distance" -40 -40
    # xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Inertia" 3
    return
}

###############################################################################

pre_lock

# We set a trap to kill the locker if we get killed, then start the locker and
# wait for it to exit. The waiting is not that straightforward when the locker
# forks, so we use this polling only if we have a sleep lock to deal with.
if [[ -e /dev/fd/${XSS_SLEEP_LOCK_FD:--1} ]]; then
    kill_i3lock() {
        pkill -xu $EUID "$@" i3lock
    }

    trap kill_i3lock TERM INT

    # we have to make sure the locker does not inherit a copy of the lock fd
    i3lock $i3lock_options {XSS_SLEEP_LOCK_FD}<&-

    # now close our fd (only remaining copy) to indicate we're ready to sleep
    exec {XSS_SLEEP_LOCK_FD}<&-

    while kill_i3lock -0; do
        sleep 0.5
    done
else
    trap 'kill %%' TERM INT
    i3lock -n $i3lock_options &
    wait
fi

post_lock
