import matplotlib.pyplot as plt
import os
home=os.path.expanduser("~")

cpu_core_list=list()
cpu_temperature_list=list()
length=-1
cpu_core_number_file = f"{home}/cpu_directory/cpu_cores.log"
with open(cpu_core_number_file,"r",newline="") as f:
    for i in f:
      if i!="":
         print(length)
         length=length+1

for i in range(length):
    dosya = f"/sys/class/thermal/thermal_zone{i}/temp"
    cpu_core_list.append(f"cpu{i}")
    with open(dosya,"r") as f:
        cpu_temperature = int(f.read())/1000
        cpu_temperature_list.append(cpu_temperature)

plt.bar(cpu_core_list,cpu_temperature_list,width=0.5,color="skyblue",edgecolor="black")
for i,v in enumerate(cpu_temperature_list):
    plt.text(i,v+0.5,str(v),ha="center")
plt.title("CPU Cores and Temperatures")
plt.xlabel("CPU Cores")
plt.ylabel("CPU Temperatures")
plt.show()
