#!/bin/bash

mkdir -p "$HOME/memory_directory"
LOG_FILE="$HOME/memory_directory/memory.log"
Used_LOG_FILE="$HOME/memory_directory/used_memory.log"
Available_LOG_FILE="$HOME/memory_directory/available_memory.log"

while true; do
ram=$(free -h | grep Mem | awk '{print $3}')
ram2=$(free -h | grep Mem | awk '{print $7}')
echo "$ram" | tee "$Used_LOG_FILE" > /dev/null
echo "$ram2" | tee "$Available_LOG_FILE" > /dev/null
echo "Used memory: $ram - Available memory: $ram2 - $(date)" >> "$LOG_FILE"
sleep 5
done

