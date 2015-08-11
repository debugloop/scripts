status=$(synclient | grep TouchpadOff)
if [[ $status =~ "0" ]]; then
    synclient TouchpadOff=1;
    if [[ -z $1 ]]; then
        notify-send -u LOW "Touchpad turned off";
    fi
else
    synclient TouchpadOff=0;
    if [[ -z $1 ]]; then
        notify-send -u LOW "Touchpad turned on";
    fi
fi
