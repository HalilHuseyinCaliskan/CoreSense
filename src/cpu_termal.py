#!/usr/bin/env python3
import matplotlib.pyplot as plt
import pandas as pd
import os
home=os.path.expanduser("~")
data=f"{home}/cpu_directory/collector.log"
temp_list=list()
with open(data,"r") as f:
    for line in f:
        temp = float(line.strip())
        temp_list.append(temp)
        if len(temp_list)>=500:
            temp_list.pop()
    
plt.figure(figsize=(6,6))
plt.plot(range(len(temp_list)),temp_list,color="red",linewidth=2)
plt.title("CPU Temperature During Time")
plt.xlabel("Time (s)")
plt.ylabel("Temperature")
plt.grid(True)
plt.show()
