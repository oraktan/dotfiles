#!/usr/bin/env bash
set -euo pipefail

REPO="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
HYPR="$REPO/hypr/.config/hypr"

MONITOR_TARGET="$HYPR/monitors.conf"
STARTUP_TARGET="$HYPR/UserConfigs/Startup_Local.conf"

PROFILE="${1:-}"
MODE="${2:-}"

case "$PROFILE" in
    home)
        MONITOR_SOURCE="$REPO/profiles/home/monitors.conf"
        STARTUP_SOURCE="$REPO/profiles/home/Startup_Local.conf"
        ;;
    laptop)
        MONITOR_SOURCE="$REPO/profiles/laptop/monitors.conf"
        STARTUP_SOURCE="$REPO/profiles/laptop/Startup_Local.conf"
        ;;
    laptop-external)
        MONITOR_SOURCE="$REPO/profiles/laptop/monitors-external.conf"
        STARTUP_SOURCE="$REPO/profiles/laptop/Startup_Local.conf"
        ;;
    work)
        MONITOR_SOURCE="$REPO/profiles/work/monitors.conf"
        STARTUP_SOURCE="$REPO/profiles/work/Startup_Local.conf"
        ;;
    *)
        echo "Kullanim: $0 {home|laptop|laptop-external|work} [--apply]"
        exit 1
        ;;
esac

if [[ -n "$MODE" && "$MODE" != "--apply" ]] || (( $# > 2 )); then
    echo "HATA: Gecersiz parametre."
    exit 1
fi

for source in "$MONITOR_SOURCE" "$STARTUP_SOURCE"; do
    if [[ ! -f "$source" ]]; then
        echo "HATA: Profil dosyasi bulunamadi: $source"
        exit 1
    fi
done

check_target() {
    local target="$1"
    local resolved

    if [[ -e "$target" && ! -L "$target" ]]; then
        echo "HATA: Normal dosyanin uzerine yazilmaz: $target"
        return 1
    fi

    if [[ -L "$target" ]]; then
        resolved="$(readlink -f -- "$target")" || return 1

        case "$resolved" in
            "$REPO/profiles/"*|"$HYPR/monitors_desktop.conf")
                ;;
            *)
                echo "HATA: Taninmayan baglanti: $target -> $resolved"
                return 1
                ;;
        esac
    fi
}

check_target "$MONITOR_TARGET"
check_target "$STARTUP_TARGET"

echo "===== PROFIL: $PROFILE ====="
echo "Monitor: $MONITOR_SOURCE"
echo "Startup: $STARTUP_SOURCE"
echo
echo "===== MEVCUT ====="
echo "Monitor: $(readlink -f "$MONITOR_TARGET" 2>/dev/null || echo yok)"
echo "Startup: $(readlink -f "$STARTUP_TARGET" 2>/dev/null || echo yok)"

if [[ "$MODE" != "--apply" ]]; then
    echo
    echo "DRY RUN: Degisiklik yapilmadi."
    exit 0
fi

OLD_MONITOR=""
OLD_STARTUP=""
MONITOR_EXISTED=false
STARTUP_EXISTED=false

if [[ -L "$MONITOR_TARGET" ]]; then
    MONITOR_EXISTED=true
    OLD_MONITOR="$(readlink -- "$MONITOR_TARGET")"
fi

if [[ -L "$STARTUP_TARGET" ]]; then
    STARTUP_EXISTED=true
    OLD_STARTUP="$(readlink -- "$STARTUP_TARGET")"
fi

replace_link() {
    local source="$1"
    local target="$2"
    local temp

    temp="$(mktemp "$target.XXXXXXXX")"
    rm -- "$temp"
    ln -s -- "$source" "$temp"

    if ! mv -Tf -- "$temp" "$target"; then
        rm -f -- "$temp"
        return 1
    fi
}

restore_monitor() {
    if [[ "$MONITOR_EXISTED" == true ]]; then
        replace_link "$OLD_MONITOR" "$MONITOR_TARGET"
    else
        rm -f -- "$MONITOR_TARGET"
    fi
}

if ! replace_link "$MONITOR_SOURCE" "$MONITOR_TARGET"; then
    echo "HATA: Monitor baglantisi guncellenemedi."
    exit 1
fi

if ! replace_link "$STARTUP_SOURCE" "$STARTUP_TARGET"; then
    echo "HATA: Startup baglantisi guncellenemedi."
    if ! restore_monitor; then
        echo "KRITIK: Monitor geri alma basarisiz. Elle kontrol edin."
    fi
    exit 1
fi

echo
echo "BASARILI: Iki profil baglantisi guncellendi."
echo "Hyprland reload yapilmadi."
