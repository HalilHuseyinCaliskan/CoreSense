import time
import os
home=os.path.expanduser("~")
cpu_temperature_file = "/sys/class/thermal/thermal_zone0/temp"
data_csv = f"{home}/cpu_directory/cpu_temperature.csv"

sayac = 0
with open(data_csv,"w") as f:
    f.write("Time,Temperature\n")

while 1:
    with open(cpu_temperature_file,"r") as f:
        temp = float(f.read())
        temp = temp / 1000
        sayac = sayac+10
    with open(data_csv,"a") as f:
        f.write(f"{sayac},{temp}\n")
    time.sleep(10)
