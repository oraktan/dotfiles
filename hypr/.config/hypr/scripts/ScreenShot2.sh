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
        # Clipboard'a kopyala (Garantilemek için)
        wl-copy < "$file_path"
        
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
        if [[ -f "$file_path" ]]; then rm "$file_path"; fi
        notify-send -u low -i "$iDIR/error.png" "İptal Edildi" "Ekran görüntüsü alınmadı."
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
        tmp_file="/tmp/swappy_buffer.png"
        rm -f "$tmp_file"
        
        # 1. Seçimi yap ve geçici dosyaya kaydet
        if grim -g "$(slurp)" "$tmp_file"; then
            # 2. ANINDA PANAYA KOPYALA (Swappy beklenmeden)
            wl-copy < "$tmp_file"
            
            # 3. Swappy'yi aç (Düzenleme biterse güncel hali tekrar kopyalar)
            # -o - ifadesi çıktıyı wl-copy'ye yönlendirir.
            swappy -f "$tmp_file" -o - | wl-copy
            
            rm "$tmp_file"
        else
            notify-send -u low "İptal" "Seçim yapılmadı."
        fi
        ;;
    *)
        echo "Kullanım: --now | --area | --win | --swappy"
        ;;
esac
