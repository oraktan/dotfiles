#!/bin/bash

if pkill -INT wf-recorder; then
    notify-send "Kayıt Durduruldu" "Video ~/Videos klasörüne kaydedildi."
else
    AREA=$(slurp)
    if [ -z "$AREA" ]; then
        exit 1 # Seçim yapılmadıysa çık
    fi
    notify-send "Kayıt Başladı" "Ekran seçilen bölge için kaydediliyor..."
    wf-recorder -g "$AREA" -f ~/Videos/$(date +%Y%m%d_%H%M%S).mp4
fi
