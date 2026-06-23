#!/bin/bash

# Bluetooth açık mı?
BT_STATUS=$(bluetoothctl show | grep "Powered:" | awk '{print $2}')

# Bağlı cihazı göster
CURRENT=$(bluetoothctl info | grep "Name:" | awk '{print $2}')
[ -n "$CURRENT" ] && HEADER="✅ Bağlı: $CURRENT" || HEADER="❌ Bağlı Cihaz Yok"
[ "$BT_STATUS" = "no" ] && HEADER="🔴 Bluetooth Kapalı"

# Eşleşmiş cihazları listele
PAIRED=$(bluetoothctl paired-devices | awk '{print $3}')

# Yakındaki cihazları tara (eğer BT açıksa)
if [ "$BT_STATUS" = "yes" ]; then
    bluetoothctl scan on &
    SCAN_PID=$!
    sleep 3
    kill $SCAN_PID 2>/dev/null
fi

NEARBY=$(bluetoothctl devices | awk '{for(i=3;i<=NF;i++) printf $i" "; print ""}')

# Menü oluştur
if [ "$BT_STATUS" = "yes" ]; then
    TOGGLE="🔴 Bluetooth Kapat"
else
    TOGGLE="🟢 Bluetooth Aç"
fi

CHOSEN=$(echo -e "$TOGGLE\n🔌 Bağlantıyı Kes\n🔄 Yenile\n---\n$NEARBY" | \
    rofi -dmenu \
         -p "Bluetooth" \
         -mesg "$HEADER" \
         -i \
         -theme-str 'window {width: 500px;}')

[ -z "$CHOSEN" ] && exit 0

case "$CHOSEN" in
    "🟢 Bluetooth Aç")
        bluetoothctl power on
        notify-send "Bluetooth" "🟢 Bluetooth açıldı"
        exec "$0"
        ;;
    "🔴 Bluetooth Kapat")
        bluetoothctl power off
        notify-send "Bluetooth" "🔴 Bluetooth kapatıldı"
        ;;
    "🔌 Bağlantıyı Kes")
        MAC=$(bluetoothctl info | grep "Device" | awk '{print $2}')
        bluetoothctl disconnect "$MAC"
        notify-send "Bluetooth" "Bağlantı kesildi"
        ;;
    "🔄 Yenile")
        exec "$0"
        ;;
    "---") exit 0 ;;
    *)
        # Seçilen cihazın MAC adresini bul
        MAC=$(bluetoothctl devices | grep "$CHOSEN" | awk '{print $2}')
        [ -z "$MAC" ] && exit 0

        # Eşleşmiş mi değil mi?
        if echo "$PAIRED" | grep -q "$CHOSEN"; then
            bluetoothctl connect "$MAC" && \
                notify-send "Bluetooth" "✅ $CHOSEN bağlandı" || \
                notify-send "Bluetooth" "❌ Bağlantı başarısız"
        else
            bluetoothctl pair "$MAC" && \
            bluetoothctl connect "$MAC" && \
                notify-send "Bluetooth" "✅ $CHOSEN eşleşti ve bağlandı" || \
                notify-send "Bluetooth" "❌ Eşleşme başarısız"
        fi
        ;;
esac
