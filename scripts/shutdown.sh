#!/bin/bash

LOG="$HOME/cpu_directory/shutdown.log"
cores=$(nproc)
interval=10
kontrol=0
threshold_v1=70000

cores=$((cores-1))

while true; do
for ((i=0;i<cores;i++)); do
   temp=$(cat "/sys/class/thermal/thermal_zone$i/temp")
   if [ "$temp" -gt "$threshold_v1" ] && [ "$kontrol" -eq 0 ];
   then
   echo "$(date '+%Y-%m-%d %H:%M:%S') - CPU{$i} sıcaklığı: ($temp). 1 dk sonra kapanacak." >> "$LOG" 
   kontrol=1
   fi
done
if [ "$kontrol" -eq 1 ];
then
shutdown -h +1
fi
sleep "$interval"
done
