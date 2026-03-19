#!/bin/bash

# Dosya yolları
PIN_FILE="$HOME/.config/rofi/cliphist_pins"
mkdir -p "$(dirname "$PIN_FILE")"
touch "$PIN_FILE"

# --- MENÜ OLUŞTURMA ---

PINNED=$(cat "$PIN_FILE" | sed 's/^/󰐃 [PİN] /')
HISTORY=$(cliphist list)

MENU_OPTIONS="󰆴 TÜM GEÇMİŞİ SİL\n$PINNED\n$HISTORY"

# --- ROFI ---

selected=$(echo -e "$MENU_OPTIONS" | rofi -dmenu -i -p "1:En Son, 2:Sonraki..." \
    -kb-custom-1 "1" \
    -kb-custom-2 "2" \
    -kb-custom-3 "3" \
    -kb-custom-4 "4" \
    -kb-custom-5 "5" \
    -kb-custom-6 "6" \
    -kb-custom-7 "7" \
    -kb-custom-8 "8" \
    -kb-custom-9 "9" \
    -config ~/.config/rofi/config.rasi)

EXIT_CODE=$?

# --- NUMARA SEÇİMİ (EN ÖNEMLİ DÜZELTME) ---

if [ $EXIT_CODE -ge 10 ] && [ $EXIT_CODE -le 18 ]; then
    KEY_PRESSED=$((EXIT_CODE - 9))

    # Direkt geçmişten al (PIN ve üst satırları atla)
    selected=$(cliphist list | sed -n "${KEY_PRESSED}p")
fi

# Seçim yoksa çık
[ -z "$selected" ] && exit

# --- İŞLEMLER ---

# Tüm geçmişi sil
if [ "$selected" = "󰆴 TÜM GEÇMİŞİ SİL" ]; then
    cliphist wipe
    > "$PIN_FILE"
    notify-send "Pano" "Her şey temizlendi!"
    exit
fi

# PIN etiketi temizle
clean_item=$(echo "$selected" | sed 's/^󰐃 \[PİN\] //')

# Kopyala + yapıştır
echo "$clean_item" | cliphist decode | wl-copy
sleep 0.1
wtype -M ctrl v -m ctrl
