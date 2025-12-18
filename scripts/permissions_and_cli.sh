#!/bin/bash
sudo apt install python3-venv
python3 -m venv sanal_ortam
source $HOME/CoreSense/scripts/sanal_ortam/bin/activate
pip install numpy pandas onnxruntime scikit-learn joblib matplotlib
chmod +x $HOME/CoreSense/src/memory_pie.py
sudo mv $HOME/CoreSense/src/memory_pie.py /usr/local/bin/memory_pie
chmod +x $HOME/CoreSense/src/cpu_termal.py
sudo mv $HOME/CoreSense/src/cpu_termal.py /usr/local/bin/cpu_thermal
chmod +x $HOME/CoreSense/src/cpu_cores_thermal.py
chmod +x $HOME/CoreSense/src/lstm_anomali_predictor.py
sudo mv $HOME/CoreSense/src/cpu_cores_thermal.py /usr/local/bin/cpu_cores_thermal
chmod +x $HOME/CoreSense/scripts/shutdown.sh
chmod +x $HOME/CoreSense/scripts/memory_usage.sh
chmod +x $HOME/CoreSense/scripts/cpu_temp.sh
chmod +x $HOME/CoreSense/scripts/commends.sh
chmod +x $HOME/CoreSense/scripts/cpu_frequency.sh
sudo mv $HOME/CoreSense/scripts/core_sense.service /etc/systemd/system/core_sense.service
sudo mv $HOME/CoreSense/scripts/anomali_detection.service /etc/systemd/system/anomali_detection.service
sudo mv $HOME/CoreSense/scripts/frequency.service /etc/systemd/system/frequency.service
sudo systemctl daemon-reload
sudo systemctl start core_sense.service
sudo systemctl enable core_sense.service
sudo systemctl restart core_sense.service
sudo systemctl start anomali_detection.service
sudo systemctl enable anomali_detection.service
sudo systemctl restart anomali_detection.service
sudo systemctl start frequency.service
sudo systemctl enable frequency.service
sudo systemctl restart frequency.service
