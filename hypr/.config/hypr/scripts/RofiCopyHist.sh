#!/bin/bash

PIN_FILE="$HOME/.config/rofi/cliphist_pins"
mkdir -p "$(dirname "$PIN_FILE")"
touch "$PIN_FILE"

# --- MENÜ OLUŞTURMA ---

PINNED=$(sed 's/^/󰐃 [PİN] /' "$PIN_FILE")
HISTORY=$(cliphist list)

MENU_OPTIONS="󰆴 TÜM GEÇMİŞİ SİL\n$PINNED\n$HISTORY"

# --- ROFI ---

selected=$(echo -e "$MENU_OPTIONS" | rofi -dmenu -i \
    -p "📋 Clipboard" \
    -kb-custom-1 "Alt+p" \
    -kb-custom-2 "Alt+d" \
    -kb-custom-3 "1" \
    -kb-custom-4 "2" \
    -kb-custom-5 "3" \
    -kb-custom-6 "4" \
    -kb-custom-7 "5" \
    -kb-custom-8 "6" \
    -kb-custom-9 "7" \
    -kb-custom-10 "8" \
    -kb-custom-11 "9" \
    -mesg "Alt+p: Pin | Alt+d: Sil | 1-9: Hızlı seç" \
    -config ~/.config/rofi/config.rasi)

EXIT_CODE=$?

# --- NUMARA SEÇİMİ ---
if [ $EXIT_CODE -ge 12 ] && [ $EXIT_CODE -le 20 ]; then
    KEY_PRESSED=$((EXIT_CODE - 11))
    selected=$(cliphist list | sed -n "${KEY_PRESSED}p")
fi

# boşsa çık
[ -z "$selected" ] && exit

# PIN etiketi temizle
clean_item=$(echo "$selected" | sed 's/^󰐃 \[PİN\] //')

# --- AKSİYONLAR ---

# 🔥 TÜM GEÇMİŞİ SİL
if [ "$selected" = "󰆴 TÜM GEÇMİŞİ SİL" ]; then
    cliphist wipe
    > "$PIN_FILE"
    notify-send "Clipboard" "Temizlendi!"
    exit
fi

# 🔥 ALT+P → PIN / UNPIN
if [ "$EXIT_CODE" -eq 10 ]; then
    if grep -Fxq "$clean_item" "$PIN_FILE"; then
        grep -Fxv "$clean_item" "$PIN_FILE" > "$PIN_FILE.tmp"
        mv "$PIN_FILE.tmp" "$PIN_FILE"
        notify-send "Clipboard" "Pin kaldırıldı"
    else
        echo "$clean_item" >> "$PIN_FILE"
        notify-send "Clipboard" "Pin eklendi"
    fi
    exit
fi

# 🔥 ALT+D → geçmişten sil (sadece history için mantıklı)
if [ "$EXIT_CODE" -eq 11 ]; then
    echo "$clean_item" | cliphist delete
    notify-send "Clipboard" "Silindi"
    exit
fi

# --- NORMAL SEÇİM (FIX BURADA) ---

if echo "$selected" | grep -q "^󰐃 \[PİN\]"; then
    # PIN ise direkt kopyala
    echo -n "$clean_item" | wl-copy
else
    # history ise decode et
    echo "$clean_item" | cliphist decode | wl-copy
fi

sleep 0.1
wtype -M ctrl v -m ctrl
