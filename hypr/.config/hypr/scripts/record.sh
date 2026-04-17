#!/bin/bash

VIDEO_DIR="$HOME/Videos"
mkdir -p "$VIDEO_DIR"

if pgrep -x wf-recorder > /dev/null; then
    pkill -INT wf-recorder
    notify-send "Kayıt Durduruldu" "Video işleniyor..."

    # Son kaydı bul
    LAST_VIDEO=$(ls -t $VIDEO_DIR/*.mkv 2>/dev/null | head -n1)

    if [ -n "$LAST_VIDEO" ]; then
        OUTPUT="${LAST_VIDEO%.mkv}_wa.mp4"

        ffmpeg -i "$LAST_VIDEO" \
            -c:v libx264 -pix_fmt yuv420p -preset veryfast -crf 23 \
            -c:a aac -b:a 128k \
            "$OUTPUT"

        notify-send "Hazır 🎉" "WhatsApp uyumlu video oluşturuldu"
    fi
else
    AREA=$(slurp)
    [ -z "$AREA" ] && exit 1

    FILE="$VIDEO_DIR/$(date +%Y%m%d_%H%M%S).mkv"

    notify-send "Kayıt Başladı" "Seçilen bölge kaydediliyor..."

    wf-recorder -g "$AREA" -f "$FILE"
fi
