#!/bin/bash

"$HOME/CoreSense/scripts/memory_usage.sh" & "$HOME/CoreSense/scripts/cpu_controller.sh" & "$HOME/CoreSense/scripts/cpu_temp.sh" & wait

