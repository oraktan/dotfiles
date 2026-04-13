#!/usr/bin/env bash

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
        # Ekran görüntüsü başarılıysa ses çal
        if [[ -f "${sDIR}/Sounds.sh" ]]; then
            "${sDIR}/Sounds.sh" --screenshot
        fi
        
        # Bildirim gönder (Aç ve Sil butonlarıyla)
        resp=$(notify-send -t 10000 -A action1="Aç" -A action2="Sil" \
            -i "$iDIR/picture.png" "Ekran Görüntüsü" "Kaydedildi: $(basename "$file_path")")
        
        case "$resp" in
            action1) xdg-open "$file_path" ;;
            action2) rm "$file_path" ;;
        esac
    else
        # Eğer dosya boşsa veya oluşmadıysa (ESC'ye basıldıysa)
        if [[ -f "$file_path" ]]; then rm "$file_path"; fi
        notify-send -u low -i "$iDIR/error.png" "İptal Edildi" "Ekran görüntüsü alınmadı."
    fi
}

# Modlar
case "$1" in
    --now)
        # Tüm ekranı çek
        file="${dir}/screenshot_$(date +%Y%m%d_%H%M%S).png"
        hyprshot -m output -o "$dir" -f "$(basename "$file")" --silent
        notify_and_sound "$file"
        ;;
    --area)
        # Bölge seçerek çek
        file="${dir}/screenshot_$(date +%Y%m%d_%H%M%S).png"
        hyprshot -m region -o "$dir" -f "$(basename "$file")" --silent
        notify_and_sound "$file"
        ;;
    --win)
        # Pencere seçerek çek
        file="${dir}/screenshot_$(date +%Y%m%d_%H%M%S).png"
        hyprshot -m window -o "$dir" -f "$(basename "$file")" --silent
        notify_and_sound "$file"
        ;;
    --swappy)
        # Önce geçici dosya oluşturarak garantili yöntemle swappy aç
        tmp_file="/tmp/swappy_buffer.png"
        rm -f "$tmp_file"
        
        # grim ve slurp kullanarak bölgeyi seç ve geçici dosyaya yaz
        # Hyprshot'ın pipe hatasını bu şekilde bypass ediyoruz
        if grim -g "$(slurp)" "$tmp_file"; then
            swappy -f "$tmp_file"
            # Swappy kapandıktan sonra dosyayı kalıcı klasöre de kopyalamak istersen burayı kullanabilirsin
            # cp "$tmp_file" "${dir}/swappy_$(date +%s).png"
            rm "$tmp_file"
        else
            notify-send "İptal" "Seçim yapılmadı."
        fi
        ;;
    *)
        echo "Kullanım: --now | --area | --win | --swappy"
        ;;
esac
