import time
import os
home=os.path.expanduser("~")
cpu_temperature_file = "/sys/class/thermal/thermal_zone0/temp"
data_csv = f"{home}/cpu_directory/collector.log"

sayac = 0

while 1:
    with open(cpu_temperature_file,"r") as f:
        temp = float(f.read())
        temp = temp / 1000
        sayac = sayac+10
    with open(data_csv,"a") as f:
        f.write(f"{sayac},{temp}\n")
    time.sleep(10)



import matplotlib.pyplot as plt
import pandas as pd
import os
home=os.path.expanduser("~")
data_csv = f"{home}/cpu_directory/collector.log"

data = pd.read_csv(data_csv)

time_list = data["Time"].tolist()
temp_list = data["Temperature"].tolist()

plt.figure(figsize=(6,6))
plt.plot(range(len(time_list)),temp_list,color="red",linewidth=2)
plt.title("CPU Temperature During Time")
plt.xlabel("Time (s)")
plt.ylabel("Temperature")
plt.grid(True)
plt.show()
