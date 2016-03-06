#!/bin/sh
while true
do
    rrdtool update /home/danieln/scripts/temperature_logging/temperature.rrd N:`cat /sys/class/hwmon/hwmon2/temp1_input`:`cat /sys/class/hwmon/hwmon2/temp2_input`:`cat /sys/class/hwmon/hwmon2/temp3_input`:`cat /sys/class/hwmon/hwmon2/temp4_input`:`cat /sys/class/hwmon/hwmon2/temp5_input`:`cat /sys/class/hwmon/hwmon1/device/fan1_input`
    sleep 5
done
