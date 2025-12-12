#!/bin/bash

mkdir -p "$HOME/cpu_directory"
LOG_FILE="$HOME/cpu_directory/temperature.log"
LOG_FILE_COLLECTOR="$HOME/cpu_directory/collector.log"
dosya="/sys/class/thermal/thermal_zone0/temp" 
while true; do
temp=$(cat "$dosya")
temp=$(( $temp / 1000 ))
echo "$temp" > "$LOG_FILE_COLLECTOR"
if [ "$temp" -gt 80 ]
then
echo "CPU Temperature: $temp - $(date)" >> "$LOG_FILE"
fi
sleep 5
done
