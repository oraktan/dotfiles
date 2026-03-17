#!/bin/bash

# Dosya yolları
PIN_FILE="$HOME/.config/rofi/cliphist_pins"
mkdir -p "$(dirname "$PIN_FILE")"
touch "$PIN_FILE"

# 1. Ana Menü: Geçmişi Göster
PINNED=$(cat "$PIN_FILE" | sed 's/^/󰐃 [PİN] /')
HISTORY=$(cliphist list)
MENU_OPTIONS="󰆴 TÜM GEÇMİŞİ SİL\n$PINNED\n$HISTORY"

selected=$(echo -e "$MENU_OPTIONS" | rofi -dmenu -i -p "Pano" -config ~/.config/rofi/config.rasi)

# Seçim yapılmadıysa çık
if [ -z "$selected" ]; then exit; fi

# "Tümünü Sil" kontrolü
if [ "$selected" = "󰆴 TÜM GEÇMİŞİ SİL" ]; then
    cliphist wipe && > "$PIN_FILE"
    notify-send "Pano" "Her şey temizlendi!"
    exit
fi

# İçeriği temizle
clean_item=$(echo "$selected" | sed 's/^󰐃 \[PİN\] //')

# 2. İşlem Menüsü: Ne yapmak istersin?
# Buradaki ilk seçenek "YAPIŞTIR" olduğu için Enter'a hızlıca basarsan direkt yapıştırır.
action=$(echo -e "󰏪 YAPIŞTIR\n󰐃 PİNLE / KALDIR\n󰆴 SİL" | rofi -dmenu -i -p "İşlem?" -config ~/.config/rofi/config.rasi)

case "$action" in
    "󰏪 YAPIŞTIR")
        echo "$clean_item" | cliphist decode | wl-copy
        sleep 0.1 && wtype -M ctrl v -m ctrl
        ;;
    "󰐃 PİNLE / KALDIR")
        if grep -qF "$clean_item" "$PIN_FILE"; then
            grep -vF "$clean_item" "$PIN_FILE" > "$PIN_FILE.tmp" && mv "$PIN_FILE.tmp" "$PIN_FILE"
            notify-send "Pano" "Pin kaldırıldı."
        else
            echo "$clean_item" >> "$PIN_FILE"
            notify-send "Pano" "Öğe pinlendi!"
        fi
        # Listeyi tazelemek için scripti tekrar aç
        $0 &
        ;;
    "󰆴 SİL")
        echo "$clean_item" | cliphist delete
        grep -vF "$clean_item" "$PIN_FILE" > "$PIN_FILE.tmp" && mv "$PIN_FILE.tmp" "$PIN_FILE"
        notify-send "Pano" "Silindi."
        $0 &
        ;;
esac
