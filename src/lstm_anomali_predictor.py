#!/home/orangepi/CoreSense/scripts/sanal_ortam/bin/python3
import numpy as np
import pandas as pd
import onnxruntime as ort
import joblib
from datetime import datetime
import os
import time
threshold = 2.836
home = os.path.expanduser("~")
ss = joblib.load(f"{home}/CoreSense/models/scaler.pkl")
model = ort.InferenceSession(f"{home}/CoreSense/models/lstm_cpu_temperature_predicter.onnx")
temperature_file = "/sys/class/thermal/thermal_zone0/temp"
anomali_file = f"{home}/cpu_directory/anomali.log"
kontrol_file = f"{home}/cpu_directory/kontrol.log"
temp_list = []
global temp,predictions
while 1:
    with open(temperature_file,"r") as f:
        temp = float(f.read().strip())/1000.0
        temp_list.append(temp)
    if len(temp_list)==4:
        temp_array = np.array(temp_list).reshape(-1,1)
        temp_scaled = ss.transform(temp_array).reshape(1,4,1).astype(np.float32)
        outputs = model.run(None,{"input":temp_scaled})[0]
        predictions = ss.inverse_transform(outputs)[0][0]
        with open(kontrol_file,"a",newline="",encoding="utf-8") as f:
                metin = f"Anomali bulunamadi: CPU Temperature (cpu0): {temp} CPU Predicter (cpu0): {predictions} - {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n"
                f.write(metin)
        
    if  len(temp_list)==5:
        if np.abs(predictions - temp) > threshold:
            with open(anomali_file,"a",newline="",encoding="utf-8") as f:
                metin = f"Anomali algilandi: CPU Temperature (cpu0): {temp} - {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n"
                f.write(metin)
        temp_list.pop(0)
        temp_list.pop(0)
    time.sleep(10)
        
