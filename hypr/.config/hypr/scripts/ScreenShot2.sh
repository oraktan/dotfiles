

#!/usr/bin/env bash

# Taner Orak - Hyprland Screenshot Script (Instant Clipboard & Swappy)

# Değişkenler
dir="$(xdg-user-dir PICTURES)/Screenshots"
iDIR="$HOME/.config/swaync/icons"
sDIR="$HOME/.config/hypr/scripts"

# Klasör yoksa oluştur
mkdir -p "$dir"

# Bildirim ve Ses Fonksiyonu
notify_and_sound() {
    local file_path=$1

    if [[ -f "$file_path" && -s "$file_path" ]]; then
        # Clipboard'a kopyala
        wl-copy -t image/png < "$file_path"

        # Ses çal
        if [[ -f "${sDIR}/Sounds.sh" ]]; then
            "${sDIR}/Sounds.sh" --screenshot
        fi

        # Bildirim
        resp=$(notify-send -t 10000 -A action1="Aç" -A action2="Sil" \
            -i "$iDIR/picture.png" "Ekran Görüntüsü" "Kaydedildi ve Panoya Kopyalandı.")

        case "$resp" in
            action1) xdg-open "$file_path" ;;
            action2) rm "$file_path" ;;
        esac
    else
        [[ -f "$file_path" ]] && rm "$file_path"
        notify-send -u low -i "$iDIR/error.png" \
            "İptal Edildi" "Ekran görüntüsü alınmadı."
    fi
}

# Modlar
case "$1" in
    --now)
        file="${dir}/screenshot_$(date +%Y%m%d_%H%M%S).png"
        hyprshot -m output -o "$dir" -f "$(basename "$file")" --silent
        notify_and_sound "$file"
        ;;

    --area)
        file="${dir}/screenshot_$(date +%Y%m%d_%H%M%S).png"
        hyprshot -m region -o "$dir" -f "$(basename "$file")" --silent
        notify_and_sound "$file"
        ;;

    --win)
        file="${dir}/screenshot_$(date +%Y%m%d_%H%M%S).png"
        hyprshot -m window -o "$dir" -f "$(basename "$file")" --silent
        notify_and_sound "$file"
        ;;

    --swappy)
        tmp_file="$(mktemp --suffix=.png)" || exit 1
        trap 'rm -f "$tmp_file"' EXIT

        # Ekran alanını seç
        geometry="$(slurp)" || exit 0

        if [[ -n "$geometry" ]] && grim -g "$geometry" "$tmp_file"; then

            # İlk görüntüyü anında panoya kopyala
            wl-copy -t image/png < "$tmp_file"

            # Swappy'yi aç
            # Ctrl+C ile düzenlenmiş görüntüyü kopyala
            swappy -f "$tmp_file"

        else
            notify-send -u low "İptal" "Seçim yapılmadı."
        fi
        ;;

    *)
        echo "Kullanım: --now | --area | --win | --swappy"
        ;;
esac
