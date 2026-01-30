#!/usr/bin/env bash
# Simple Hyprland keybind viewer for rofi

set -euo pipefail

# ---- kill blockers -----------------------------------------
pkill yad 2>/dev/null || true
pidof rofi >/dev/null && pkill rofi

# ---- files --------------------------------------------------
CONF_FILES=(
  "$HOME/.config/hypr/configs/Keybinds.conf"
  "$HOME/.config/hypr/UserConfigs/UserKeybinds.conf"
  "$HOME/.config/hypr/UserConfigs/Laptops.conf"
)

ROFI_THEME="$HOME/.config/rofi/config-keybinds.rasi"
MSG="🔍 Hyprland Keybinds (type to search)"

# ---- extract + format --------------------------------------
parse_binds() {
  awk '
  function trim(s){gsub(/^[ \t]+|[ \t]+$/,"",s); return s}

  /^[ \t]*bind/ {
    split($0, x, "=")
    if (length(x) < 2) next

    binder=trim(x[1])
    rhs=trim(x[2])

    n=split(rhs, a, /[ \t]*,[ \t]*/)
    if (n < 2) next

    mods=trim(a[1])
    key=trim(a[2])
    if (mods=="" || key=="") next

    gsub(/\$mainMod/, "SUPER", mods)
    gsub(/[ \t]+/, "+", mods)

    combo=mods "+" key

    if (binder ~ /^bindd/) {
      desc = (n>=3 ? trim(a[3]) : "")
      if (desc != "")
        print combo " — " desc
    } else {
      dispatcher = (n>=3 ? trim(a[3]) : "")
      params=""
      for (i=4;i<=n;i++) params=params" "trim(a[i])
      if (dispatcher != "")
        print combo " — " dispatcher params
    }
  }'
}

# ---- build list --------------------------------------------
LIST=""
for f in "${CONF_FILES[@]}"; do
  [[ -f "$f" ]] || continue
  LIST+=$(parse_binds < "$f")
  LIST+=$'\n'
done

[[ -z "$LIST" ]] && exit 1

# ---- rofi --------------------------------------------------
printf '%s\n' "$LIST" \
  | sort -u \
  | rofi -dmenu -i -mesg "$MSG" -config "$ROFI_THEME"

