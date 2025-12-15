#!/bin/bash

LOG="$HOME/cpu_directory/shutdown.log"
cores=$(nproc)
interval=10
kontrol=0
freq_threshold=800000
threshold_v1=40000
threshold_v2=50000
threshold_v3=60000
threshold_v4=70000
threshold_v5=80000
cores=$((cores-1))
for((i=0;i<cores;i++)); do
   echo userspace > "/sys/devices/system/cpu/cpu$i/cpufreq/scaling_governor" 
done
echo "$cores"
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
   formula=$((current_frequency*(100-15*(temp-threshold_v3)/threshold_v3)/100))
   echo "$formula" > "/sys/devices/system/cpu/cpu$i/cpufreq/scaling_max_freq"
   elif [ "$temp" -gt "$threshold_v2" ];
   then
   formula=$((current_frequency*(100-10*(temp-threshold_v2)/threshold_v2)/100))
   echo "$formula" > "/sys/devices/system/cpu/cpu$i/cpufreq/scaling_max_freq"
   elif [ "$temp" -gt "$threshold_v1" ];
   then
   formula=$((current_frequency*(100-5*(temp-threshold_v1)/threshold_v1)/100))
   if [ "$formula" -gt "$freq_threshold" ];
   then
   echo "$formula" > "/sys/devices/system/cpu/cpu$i/cpufreq/scaling_max_freq"
   echo " cpu$i $current_frequency ve $formula"
   fi
   fi
   if [ "$temp" -gt "$threshold_v5" ] && [ "$kontrol" -eq 0 ];
   then
   echo "$(date '+%Y-%m-%d %H:%M:%S') - CPU sıcaklığı: ($temp). 1 dk sonra kapanacak." >> "$LOG" 
   kontrol=1
   shutdown -h +1
   fi
done
sleep "$interval"
done
