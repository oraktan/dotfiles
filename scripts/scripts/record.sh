#!/bin/bash

VIDEO_DIR="$HOME/Videos"
mkdir -p "$VIDEO_DIR"

if pgrep -x wf-recorder >/dev/null; then

    notify-send "Kayıt Durduruluyor" "Video dosyası kapatılıyor..."

    # wf-recorder'ı Ctrl+C gibi düzgün şekilde durdur
    pkill -INT -x wf-recorder

    # Sabit sleep yerine gerçekten kapanmasını bekle
    while pgrep -x wf-recorder >/dev/null; do
        sleep 0.2
    done

    # En yeni MKV dosyasını bul
    LAST_VIDEO=$(
        find "$VIDEO_DIR" \
            -maxdepth 1 \
            -type f \
            -name '*.mkv' \
            -printf '%T@ %p\n' |
        sort -nr |
        head -n1 |
        cut -d' ' -f2-
    )

    if [ -z "$LAST_VIDEO" ] || [ ! -f "$LAST_VIDEO" ]; then
        notify-send "Hata" "Kaydedilmiş MKV dosyası bulunamadı."
        exit 1
    fi

    OUTPUT="${LAST_VIDEO%.mkv}_wa.mp4"

    notify-send "Video İşleniyor" "WhatsApp uyumlu MP4 hazırlanıyor..."

    if ffmpeg -y \
        -i "$LAST_VIDEO" \
        -map 0:v:0 \
        -map "0:a?" \
        -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" \
        -c:v libx264 \
        -pix_fmt yuv420p \
        -preset veryfast \
        -crf 23 \
        -c:a aac \
        -b:a 128k \
        -movflags +faststart \
        "$OUTPUT"
    then
        notify-send "Hazır 🎉" "WhatsApp uyumlu video oluşturuldu:
$OUTPUT"
    else
        notify-send "FFmpeg Hatası" "Video dönüştürülemedi."
        exit 1
    fi

else

    AREA=$(slurp)

    # Kullanıcı seçimi iptal ettiyse çık
    [ -z "$AREA" ] && exit 1

    #
    # slurp çıktısı:
    #
    # 100,200 1081x721
    #
    # Genişlik/yüksekliği kayıt başlamadan çift sayıya çevir.
    #
    if [[ "$AREA" =~ ^(-?[0-9]+),(-?[0-9]+)[[:space:]]+([0-9]+)x([0-9]+)$ ]]; then

        X="${BASH_REMATCH[1]}"
        Y="${BASH_REMATCH[2]}"
        W="${BASH_REMATCH[3]}"
        H="${BASH_REMATCH[4]}"

        W=$(( W / 2 * 2 ))
        H=$(( H / 2 * 2 ))

        AREA="$X,$Y ${W}x${H}"
    else
        notify-send "Hata" "slurp çıktısı okunamadı: $AREA"
        exit 1
    fi

    FILE="$VIDEO_DIR/$(date +%Y%m%d_%H%M%S).mkv"

    notify-send "Kayıt Başladı" "Alan: $AREA"

    wf-recorder \
        -g "$AREA" \
        -f "$FILE"

fi
