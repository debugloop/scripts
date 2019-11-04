id=$(xinput list | grep TouchPad | grep -oP 'id=\K([[:digit:]]*)')
if xinput list-props $id | grep "Device Enabled ([[:digit:]]*):[[:space:]]*1"; then
    xinput disable $id;
    notify-send -u LOW "Touchpad turned off";
else
    xinput enable $id;
    notify-send -u LOW "Touchpad turned on";
fi
