#!/bin/bash

cores=$(nproc)
interval=10
freq_threshold=800000
threshold_v1=40000
cores=$((cores-1))
for((i=0;i<cores;i++)); do
   echo userspace > "/sys/devices/system/cpu/cpu$i/cpufreq/scaling_governor" 
done
echo "$cores"
while true; do
for ((i=0;i<cores;i++)); do
   temp=$(cat "/sys/class/thermal/thermal_zone$i/temp")
   current_frequency=$(cat "/sys/devices/system/cpu/cpu$i/cpufreq/scaling_cur_freq")
   echo "Merhaba2"
   if [ "$temp" -gt "$threshold_v1" ];
   then
   formula=$((current_frequency*(100-5*(temp-threshold_v1)/threshold_v1)/100))
   echo "$formula" > "/sys/devices/system/cpu/cpu$i/cpufreq/scaling_max_freq"
   fi
   
done
sleep "$interval"
done
