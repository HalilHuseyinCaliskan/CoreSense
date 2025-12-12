#!/bin/bash

mkdir -p "$HOME/cpu_directory"
LOG_FILE="$HOME/cpu_directory/temperature.log"
dosya="/sys/class/thermal/thermal_zone0/temp" 
while true; do
temp=$(cat "$dosya")
temp=$(( $temp / 1000 ))
if [ "$temp" -gt 80 ]
then
echo "CPU Temperature: $temp - $(date)" >> "$LOG_FILE"
fi
sleep 5
done
