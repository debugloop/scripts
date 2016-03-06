#!/bin/sh
rrdtool create temperature.rrd --start now --step 5s \
DS:temp_proc:GAUGE:30s:0:120000     \
DS:temp_core1:GAUGE:30s:0:120000    \
DS:temp_core2:GAUGE:30s:0:120000    \
DS:temp_core3:GAUGE:30s:0:120000    \
DS:temp_core4:GAUGE:30s:0:120000    \
DS:fan_speed:GAUGE:30s:0:20000      \
RRA:AVERAGE:0.5:5s:1w               \
RRA:AVERAGE:0.5:1m:1M               \
RRA:AVERAGE:0.5:10m:6M              \
RRA:AVERAGE:0.5:1h:1y
