import numpy as np
import pandas as pd
import onnxruntime as ort
import joblib
from datetime import datetime
import os
import time
threshold = 2.836
home = os.path.expanduser("~")
ss = joblib.load("standard_scaler.pkl")
model = ort.InferenceSession("lstm_cpu_temperature_predictor.onnx")
temperature_file = "/sys/class/thermal/thermal_zone0/temp"
anomali_file = f"{home}/cpu_directory/anomali.log"
temp_list = []
while 1:
    with open(temperature_file,"r") as f:
        temp = float(f.read().strip())
        temp_list.append(temp)
    if len(temp_list)==4:
        temp_array = np.array(temp_list).reshape(-1,1)
        temp_scaled = ss.transform(temp_array).reshape(1,4,1)
        outputs = model.run(None,{"input":temp_scaled})[0]
        predictions = ss.inverse_transform(outputs)[0][0]
        if np.abs(predictions - temp) > threshold:
            with open(anomali_file,"a",newline="",encoding="utf-8") as f:
                metin = f"Anomali algilandi: CPU Temperature (cpu0): {temp} - {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n"
                f.write(metin)
        temp_list.pop(0)
    time.sleep(10)
        
