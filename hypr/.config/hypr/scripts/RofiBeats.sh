#!/usr/bin/env bash
# /* ---- 💫 MPlayer Integrated - Fedora & Hyprland 💫 ---- */ ##

mDIR="$HOME/Music/"
iDIR="$HOME/.config/swaync/icons"
rofi_theme="$HOME/.config/rofi/config-rofi-Beats.rasi"
rofi_theme_menu="$HOME/.config/rofi/config-rofi-Beats-menu.rasi"
music_list="$HOME/.config/rofi/online_music.list"

notification() {
    notify-send -u normal -i "$iDIR/music.png" "MPlayer" "$@"
}

# Çalışan mplayer süreçlerini durdurur
stop_music() {
    if pgrep -x "mplayer" > /dev/null; then
        pkill -x "mplayer"
        notification "Müzik Durduruldu"
    else
        notification "Zaten hiçbir şey çalmıyor."
    fi
}

play_local_music() {
    # Müzik dosyalarını tara
    mapfile -t local_music < <(find -L "$mDIR" -type f \( -iname "*.mp3" -o -iname "*.flac" -o -iname "*.wav" -o -iname "*.ogg" -o -iname "*.m4a" \))
    
    filenames=()
    for file in "${local_music[@]}"; do filenames+=("$(basename "$file")"); done

    choice=$(printf "%s\n" "${filenames[@]}" | rofi -i -dmenu -config "$rofi_theme" -theme-str 'entry { placeholder: "🎵 MPlayer: Yerel Müzik Seç"; }')

    [[ -z "$choice" ]] && exit 1

    for ((i = 0; i < "${#filenames[@]}"; ++i)); do
        if [ "${filenames[$i]}" = "$choice" ]; then
            stop_music
            # MPlayer'ı arka planda (really-quiet modunda) başlat
            mplayer -really-quiet "${local_music[$i]}" > /dev/null 2>&1 &
            notification "Şu an çalıyor:" "$choice"
            break
        fi
    done
}

play_online_music() {
    if [ ! -s "$music_list" ]; then
        notification "Hata" "Müzik listesi boş!"
        exit 0
    fi

    choice=$(awk -F'|' '{print $1}' "$music_list" | sort | rofi -i -dmenu -config "$rofi_theme" -theme-str 'entry { placeholder: "🌐 MPlayer: Radyo Seç"; }')
    [[ -z "$choice" ]] && exit 1
    link=$(awk -F'|' -v name="$choice" '$1 == name {print $2; exit}' "$music_list")

    stop_music
    notification "URL Yükleniyor:" "$choice"
    
    # MPlayer ile stream/URL çalma
    mplayer -really-quiet "$link" > /dev/null 2>&1 &
}

shuffle_music() {
    stop_music
    notification "Karışık Çalma Başladı"
    # Tüm müzikleri bul, karıştır (shuf) ve mplayer playlist'ine at
    find -L "$mDIR" -type f \( -iname "*.mp3" -o -iname "*.flac" -o -iname "*.wav" -o -iname "*.ogg" -o -iname "*.m4a" \)| shuf > /tmp/mplayer_playlist.txt
    mplayer -really-quiet -playlist /tmp/mplayer_playlist.txt > /dev/null 2>&1 &
}

user_choice=$(printf "%s\n" "Play from Online Stations" "Play from Music directory" "Shuffle Play from Music directory" "Stop MPlayer" | rofi -dmenu -config "$rofi_theme_menu" -theme-str 'entry { placeholder: "🎧 MPlayer Menu"; }')

case "$user_choice" in
    "Play from Online Stations") play_online_music ;;
    "Play from Music directory") play_local_music ;;
    "Shuffle Play from Music directory") shuffle_music ;;
    "Stop MPlayer") stop_music ;;
esac
