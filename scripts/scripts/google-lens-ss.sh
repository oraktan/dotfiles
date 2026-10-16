#!/usr/bin/env bash

geometry=$(slurp) || exit 0

grim -g "$geometry" - | wl-copy --type image/png

firefox --new-tab "https://www.google.com/?olud"

notify-send "Google Lens" "Ekran görüntüsü panoya kopyalandı"
