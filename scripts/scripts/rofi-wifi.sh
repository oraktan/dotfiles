#!/bin/bash

# Wi-Fi listesini al
WIFI_LIST=$(nmcli -f SSID,SECURITY,SIGNAL dev wifi list 2>/dev/null | tail -n +2 | \
    awk 'NF' | sort -t' ' -k3 -rn | \
    awk '{printf "%-35s %s\n", $1, ($2=="--" ? "🔓 Açık" : "🔒 Şifreli")}')

# Bağlı ağı göster
CURRENT=$(nmcli -t -f NAME,TYPE con show --active | grep wifi | cut -d: -f1)
[ -n "$CURRENT" ] && HEADER="✅ Bağlı: $CURRENT" || HEADER="❌ Bağlantı Yok"

# Rofi menüsü
CHOSEN=$(echo -e "🔄 Yenile\n🔌 Bağlantıyı Kes\n---\n$WIFI_LIST" | \
    rofi -dmenu \
         -p "Wi-Fi" \
         -mesg "$HEADER" \
         -i \
         -theme-str 'window {width: 500px;}')

[ -z "$CHOSEN" ] && exit 0

SSID=$(echo "$CHOSEN" | awk '{print $1}')

case "$CHOSEN" in
    "🔄 Yenile")
        nmcli dev wifi rescan
        exec "$0"
        ;;
    "🔌 Bağlantıyı Kes")
        nmcli con down "$CURRENT"
        notify-send "Wi-Fi" "Bağlantı kesildi"
        ;;
    "---") exit 0 ;;
    *)
        if nmcli con show "$SSID" &>/dev/null; then
            # Kayıtlı ağ - direkt bağlan
            nmcli con up "$SSID" && \
                notify-send "Wi-Fi" "✅ $SSID bağlandı" || \
                notify-send "Wi-Fi" "❌ Bağlantı başarısız"
        else
            # Yeni ağ - şifre sor
            PASS=$(rofi -dmenu -p "🔑 $SSID şifresi:" \
                -theme-str 'entry {placeholder: "Şifre girin...";}')
            [ -z "$PASS" ] && exit 0
            nmcli dev wifi connect "$SSID" password "$PASS" && \
                notify-send "Wi-Fi" "✅ $SSID bağlandı" || \
                notify-send "Wi-Fi" "❌ Yanlış şifre veya bağlantı hatası"
        fi
        ;;
esac
