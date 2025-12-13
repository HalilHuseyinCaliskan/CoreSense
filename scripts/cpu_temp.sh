#!/bin/bash

mkdir -p "$HOME/cpu_directory"
LOG_FILE="$HOME/cpu_directory/temperature.log"
LOG_FILE_COLLECTOR="$HOME/cpu_directory/collector.log"
LOG_FILE_CPU_CORES="$HOME/cpu_directory/cpu_cores.log"
dosya="/sys/class/thermal/thermal_zone0/temp"
number_cores=$(cat /proc/cpuinfo | grep "processor" | awk '{print $3}')
echo "$number_cores" > "$LOG_FILE_CPU_CORES"
while true; do
temp=$(cat "$dosya")
temp=$(( $temp / 1000 ))
echo "$temp" >> "$LOG_FILE_COLLECTOR"
if [ "$temp" -gt 80 ]
then
echo "CPU Temperature: $temp - $(date)" >> "$LOG_FILE"
fi
sleep 5
done
