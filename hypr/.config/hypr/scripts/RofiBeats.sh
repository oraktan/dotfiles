#!/usr/bin/env bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */ ##
# Optimized for Fedora & HyprWave - CPU Friendly

mDIR="$HOME/Music/"
iDIR="$HOME/.config/swaync/icons"
rofi_theme="$HOME/.config/rofi/config-rofi-Beats.rasi"
rofi_theme_menu="$HOME/.config/rofi/config-rofi-Beats-menu.rasi"
music_list="$HOME/.config/rofi/online_music.list"

# HyprWave ve kontrol için IPC soketi
MPV_SOCKET="/tmp/mpv-rofi-beats.sock"

mkdir -p "$(dirname "$music_list")"
[[ -f "$music_list" ]] || touch "$music_list"

notification() {
    notify-send -u normal -i "$iDIR/music.png" "$@"
}

music_playing() { pgrep -x "mpv" >/dev/null; }

stop_music() {
    pkill -x mpv 2>/dev/null
    rm -f "$MPV_SOCKET"
    notification "Müzik Durduruldu"
}

# Ortak MPV Ayarları (Stabilite için)
# ao=pulse veya ao=pipewire Fedora'da ses çakışmasını önler
MPV_OPTS="--no-video --ao=pulse --input-ipc-server=$MPV_SOCKET --script-opts=mpris-enable=yes"

play_local_music() {
    mapfile -t local_music < <(find -L "$mDIR" -type f \( -iname "*.mp3" -o -iname "*.flac" -o -iname "*.wav" -o -iname "*.ogg" -o -iname "*.m4a" \))
    filenames=()
    for file in "${local_music[@]}"; do filenames+=("$(basename "$file")"); done

    choice=$(printf "%s\n" "${filenames[@]}" | rofi -i -dmenu -config "$rofi_theme" -theme-str 'entry { placeholder: "🎵 Yerel Müzik Seç"; }')

    [[ -z "$choice" ]] && exit 1

    for ((i = 0; i < "${#filenames[@]}"; ++i)); do
        if [ "${filenames[$i]}" = "$choice" ]; then
            music_playing && stop_music
            notification "Şu an çalıyor:" "$choice"
            mpv $MPV_OPTS --loop-playlist --playlist-start="$i" "${local_music[@]}" &
            break
        fi
    done
}

play_online_music() {
    if [ ! -s "$music_list" ]; then
        notification "Hata" "Müzik listesi boş!"
        exit 0
    fi

    choice=$(awk -F'|' '{print $1}' "$music_list" | sort | rofi -i -dmenu -config "$rofi_theme" -theme-str 'entry { placeholder: "🌐 Radyo/Online Seç"; }')
    [[ -z "$choice" ]] && exit 1
    link=$(awk -F'|' -v name="$choice" '$1 == name {print $2; exit}' "$music_list")

    music_playing && stop_music
    notification "Başlatılıyor:" "$choice"

    # Online akış için ekstra tampon (buffer) ayarları
    mpv $MPV_OPTS \
        --ytdl-format=bestaudio \
        --cache=yes \
        --demuxer-max-bytes=100MiB \
        --force-window=no \
        "$link" &
}

# Diğer fonksiyonlar (manage_music vb.) aynı kalabilir...
# (Scriptin geri kalan case yapısını bozmadan buraya ekleyebilirsin)

user_choice=$(printf "%s\n" "Play from Online Stations" "Play from Music directory" "Shuffle Play from Music directory" "Stop RofiBeats" | rofi -dmenu -config "$rofi_theme_menu" -theme-str 'entry { placeholder: "🎧 RofiBeats Menu"; }')

case "$user_choice" in
    "Play from Online Stations") play_online_music ;;
    "Play from Music directory") play_local_music ;;
    "Shuffle Play from Music directory") music_playing && stop_music; mpv $MPV_OPTS --shuffle --loop-playlist "$mDIR" & ;;
    "Stop RofiBeats") stop_music ;;
esac
