#!/bin/bash

PIN_FILE="$HOME/.config/rofi/cliphist_pins"
mkdir -p "$(dirname "$PIN_FILE")"
touch "$PIN_FILE"

# --- MENÜ OLUŞTURMA ---
PINNED=$(sed 's/^/󰐃 [PİN] /' "$PIN_FILE")
HISTORY=$(cliphist list | nl -w2 -s'. ')
MENU_OPTIONS="󰆴 TÜM GEÇMİŞİ SİL\n$PINNED\n$HISTORY"

# --- MOUSE'U ORTALA (ROFI AÇILDIKTAN SONRA) ---
(
    sleep 0.2
MONITOR_INFO=$(hyprctl monitors -j | jq -r '.[] | select(.focused==true)')

WIDTH=$(echo "$MONITOR_INFO" | jq '.width')
HEIGHT=$(echo "$MONITOR_INFO" | jq '.height')
X=$(echo "$MONITOR_INFO" | jq '.x')
Y=$(echo "$MONITOR_INFO" | jq '.y')

# ortayı hesapla
CENTER_X=$((X + WIDTH / 2))
CENTER_Y=$((Y + HEIGHT / 2))

# mouse'u doğru monitöre taşı
hyprctl dispatch movecursor $CENTER_X $CENTER_Y
) &

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
    -config ~/.config/rofi/config.rasi \
    -hover-select -me-select-entry '' -me-accept-entry MousePrimary)

EXIT_CODE=$?

# --- HIZLI SEÇİM (1-9) ---
if [ $EXIT_CODE -ge 12 ] && [ $EXIT_CODE -le 20 ]; then
    KEY_PRESSED=$((EXIT_CODE - 11))
    selected=$(cliphist list | sed -n "${KEY_PRESSED}p")
fi

[ -z "$selected" ] && exit

clean_item=$(echo "$selected" | sed 's/^󰐃 \[PİN\] //')

# --- TÜM GEÇMİŞİ SİL ---
if [ "$selected" = "󰆴 TÜM GEÇMİŞİ SİL" ]; then
    cliphist wipe
    > "$PIN_FILE"
    notify-send "Clipboard" "Temizlendi!"
    exit
fi

# --- PIN EKLE / KALDIR ---
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

# --- SİL ---
if [ "$EXIT_CODE" -eq 11 ]; then
    echo "$clean_item" | cliphist delete
    notify-send "Clipboard" "Silindi"
    exit
fi

# --- KOPYALA ---
if echo "$selected" | grep -q "^󰐃 \[PİN\]"; then
    echo -n "$clean_item" | wl-copy
else
    echo "$clean_item" | cliphist decode | wl-copy
fi

# --- OTOMATİK YAPIŞTIR ---
sleep 0.1
wtype -M ctrl v -m ctrl
