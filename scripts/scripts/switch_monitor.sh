#!/bin/bash
if [ "$1" = "laptop" ]; then
    cat ~/.config/hypr/monitors_laptop.conf > ~/.config/hypr/monitors_active.conf
    notify-send "Monitor" "laptop.conf aktif edildi" --icon=display
    sleep 1
    for i in 1 2 3 4 5; do hyprctl dispatch moveworkspacetomonitor $i eDP-1; done

elif [ "$1" = "laptop2" ]; then
    cat ~/.config/hypr/monitors_laptop2.conf > ~/.config/hypr/monitors_active.conf
    notify-send "Monitor" "laptop2.conf aktif edildi" --icon=display
    sleep 1
    for i in 1 2 3 4 5; do hyprctl dispatch moveworkspacetomonitor $i DP-5; done
    for i in 6 7 8 9 10; do hyprctl dispatch moveworkspacetomonitor $i DP-2; done

elif [ "$1" = "desktop" ]; then
    cat ~/.config/hypr/monitors_desktop.conf > ~/.config/hypr/monitors_active.conf
    notify-send "Monitor" "desktop.conf aktif edildi" --icon=display
    sleep 1
    for i in 1 2 3 4 5; do hyprctl dispatch moveworkspacetomonitor $i DP-5; done
    for i in 6 7 8 9 10; do hyprctl dispatch moveworkspacetomonitor $i DP-2; done

else
    notify-send "Monitor" "Argüman verilmedi! (laptop, laptop2, desktop)" --icon=error
fi

if hyprctl reload; then
    notify-send "Hyprland" "Config reload başarılı ✓" --icon=display
else
    notify-send "Hyprland" "Config reload BAŞARISIZ ✗" --icon=error
fi
