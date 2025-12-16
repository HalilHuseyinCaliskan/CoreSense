#!/home/orangepi/CoreSense/scripts/sanal_ortam/bin/python3
import matplotlib.pyplot as plt
import os
home = os.path.expanduser("~")
available_memory_file = f"{home}/memory_directory/available_memory.log"
used_memory_file = f"{home}/memory_directory/used_memory.log"
with open(available_memory_file,"r") as f:
    available_memory_str = f.read().strip()
    if available_memory_str.endswith("Gi"):
        available_memory_str = float(available_memory_str[:-3].replace(",","."))
    else:
        available_memory_str = float(available_memory_str[:-3].replace(",","."))
        available_memory_str = available_memory_str/1024

with open(used_memory_file,"r") as f:
    used_memory_str = f.read().strip()
    if used_memory_str.endswith("Gi"):
        used_memory_str = float(used_memory_str[:-3].replace(",","."))
    else:
        used_memory_str = float(used_memory_str[:-3].replace(",","."))
        used_memory_str = used_memory_str/1024
labels = ["Available Memory","Used Memory"]
sizes = [float(available_memory_str),float(used_memory_str)]
colors = ["#4CAF50","#F44336"]
explode = [0.08,0.12]
plt.figure(figsize=(7,7))
plt.gcf().canvas.manager.set_window_title("Memory Usage Chart")
plt.pie(sizes,labels=labels,colors=colors,explode=explode,autopct="%1.1f%%",startangle=90,shadow=True)
plt.title("Memory Usage (Mib)")
plt.axis("equal")
plt.tight_layout()
plt.show()
