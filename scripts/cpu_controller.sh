#!/bin/bash

cores=$(nproc)
interval=10
threshold_v1=40000
threshold_v2=50000
threshold_v3=60000
threshold_v4=70000
for((i=0;i<cores;i++)); do
   echo userspace > "/sys/devices/system/cpu/cpu$i/cpufreq/scaling_governor" 

while true; do
for ((i=0;i<cores;i++)); do
   temp=$(cat "/sys/class/thermal/thermal_zone$i/temp")
   current_frequency=$(cat "/sys/devices/system/cpu/cpu$i/cpufreq/scaling_cur_freq")
   if [ "$temp" -gt "$threshold_v4" ];
   then
   formula=$((current_frequency*(100-20*(temp-threshold_v4)/threshold_v4)/100))
   echo "$formula" > "/sys/devices/system/cpu/cpu$i/cpufreq/scaling_max_freq"
   elif [ "$temp" -gt "$threshold_v3" ];
   then
   formula=$((current_frequency*(100-40*(temp-threshold_v3)/threshold_v3)/100))
   echo "$formula" > "/sys/devices/system/cpu/cpu$i/cpufreq/scaling_max_freq"
   elif [ "$temp" -gt "$threshold_v2" ];
   then
   formula=$((current_frequency*(100-60*(temp-threshold_v2)/threshold_v2)/100))
   echo "$formula" > "/sys/devices/system/cpu/cpu$i/cpufreq/scaling_max_freq"
   elif [ "$temp" -gt "$threshold_v1" ];
   then
   formula=$((current_frequency*(100-80*(temp-threshold_v1)/threshold_v1)/100))
   echo "$formula" > "/sys/devices/system/cpu/cpu$i/cpufreq/scaling_max_freq"
   fi
done
sleep "$interval"
done
