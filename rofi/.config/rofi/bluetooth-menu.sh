#!/usr/bin/env bash

# Bluetooth durumunu kontrol et
status=$(bluetoothctl show | grep "Powered: yes" | wc -l)
if [ $status -eq 1 ]; then
    power="Gücü Kapat"
else
    power="Gücü Aç"
fi

# Seçenekleri oluştur
options="$power\nCihaz Tara\nBağlan\nBağlantıyı Kes\nEşleşmiş Cihazlar"

# Rofi menüsünü aç
chosen=$(echo -e "$options" | rofi -dmenu -i -p "Bluetooth" -theme-str 'window {width: 30%;}')

case "$chosen" in
    "Gücü Aç") bluetoothctl power on ;;
    "Gücü Kapat") bluetoothctl power off ;;
    "Cihaz Tara") bluetoothctl scan on ;;
    "Bağlan") # Burada basitçe bluetoothctl cihaz listesini de dökebilirsin
        rofi-bluetooth ;; # Eğer yüklüyse diğer scripti çağırır
esac
