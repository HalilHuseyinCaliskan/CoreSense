# CoreSense

CoreSense, Linux tabanlı sistemler için geliştirilmiş özel bir systemd servisidir. 

## 🚀 Özellikler
- Gerçek zamanlı CPU sıcaklık takibi 
- RAM ve CPU kullanımının loglanması
- PyTorch'dan ONNX'a formatına çevirilmiş LSTM modeli ile CPU'daki sıcaklık anomalisi tespiti ve anomalilerin loglanması
- CPU ve portlara zarar verecek şekilde yüksek sıcaklıkarda sistemin koruma moduna alınması ve loglanması
- Systemd servisi olarak arka planda çalışma
- Özel olarak geliştirilmiş CLI komutlar ile :
      - Anlık RAM kullanımının görselleştirilmesi
      - Zaman içerisindeki CPU sıcaklığının değişiminin görselleştirilmesi
      - CPU'daki tüm çekirdeklerin anlık sıcaklıklarının görselleştirilmesi
- Sanal ortam desteği

 
