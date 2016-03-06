#!/bin/sh
RRDPATH="/home/danieln/scripts/temperature_logging"
IMGPATH="/tmp"
RRDFILE="temperature.rrd"

echo "Generating graph for interval ${1}:"
rrdtool graph $IMGPATH/${1}.png --start -${1} \
--full-size-mode \
--title "Laptop Stats over ${1}" \
--y-grid=0.5:2 \
--width=1920 --height=1080 \
--color=BACK#1d2021 \
--color=SHADEA#1d2021 \
--color=SHADEB#1d2021 \
--color=CANVAS#1d2021 \
--color=FRAME#1d2021 \
--color=ARROW#ebdbb2 \
--color=FONT#ebdbb2 \
--color=AXIS#ebdbb2 \
--color=MGRID#928374 \
--color=GRID#303030 \
--vertical-label "°C" \
--right-axis 1000:-20000 \
--right-axis-label "RPM" \
DEF:temp_proc=$RRDPATH/$RRDFILE:temp_proc:AVERAGE \
DEF:temp_core1=$RRDPATH/$RRDFILE:temp_core1:AVERAGE \
DEF:temp_core2=$RRDPATH/$RRDFILE:temp_core2:AVERAGE \
DEF:temp_core3=$RRDPATH/$RRDFILE:temp_core3:AVERAGE \
DEF:temp_core4=$RRDPATH/$RRDFILE:temp_core4:AVERAGE \
DEF:fan_speed=$RRDPATH/$RRDFILE:fan_speed:AVERAGE \
"CDEF:realtemp_proc=temp_proc,1000,/" \
"CDEF:realtemp_core1=temp_core1,1000,/" \
"CDEF:realtemp_core2=temp_core2,1000,/" \
"CDEF:realtemp_core3=temp_core3,1000,/" \
"CDEF:realtemp_core4=temp_core4,1000,/" \
"CDEF:fake_fan_speed_1=fan_speed,100,/" \
"CDEF:fake_fan_speed=fake_fan_speed_1,20,+" \
LINE2:realtemp_proc#cc241d:"Overall Temperature" \
LINE2:realtemp_core1#98971a:"Temperature Core 1" \
LINE2:realtemp_core2#d79921:"Temperature Core 2" \
LINE2:realtemp_core3#458588:"Temperature Core 3" \
LINE2:realtemp_core4#689d6a:"Temperature Core 4" \
LINE2:fake_fan_speed#FFFFFF:"Fan Speed"
echo ""
imv -f $IMGPATH/${1}.png
