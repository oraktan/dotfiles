#!/usr/bin/env bash
set -euo pipefail

REPO="$HOME/dotfiles"
PROFILE_MANAGER="$REPO/scripts/select-profile.sh"

profile="${1:-}"

case "$profile" in
    desktop)
        selected="home"
        ;;
    laptop|laptop2)
        echo "Bu makinede laptop monitor profili devre disi."
        exit 1
        ;;
    *)
        echo "Kullanim: $0 desktop"
        exit 1
        ;;
esac

current="$(readlink -f "$REPO/hypr/.config/hypr/monitors.conf")"
expected="$REPO/profiles/home/monitors.conf"

if [[ "$current" != "$expected" ]]; then
    echo "HATA: Bu makinede Home profili aktif degil."
    exit 1
fi

"$PROFILE_MANAGER" "$selected" --apply

if command -v hyprctl >/dev/null 2>&1; then
    hyprctl reload
fi

if command -v notify-send >/dev/null 2>&1; then
    notify-send "Monitor" "Home profili aktif"
fi
