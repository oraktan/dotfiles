
-- Hyprland 0.57 - Kisisel pencere kurallari
-- Lenovo: workspace 1-5 | Samsung: workspace 6-10
-- Bu dosya ~/.config/hypr/windowrules.lua konumuna kopyalanir.

-- Waterfox profilleri: pencere basligina gore
hl.window_rule({
    name = "waterfox-personal-ws1",
    match = { title = ".*Personal.*" },
    workspace = "1",
})

hl.window_rule({
    name = "waterfox-work-ws2",
    match = { title = ".*Original profile.*" },
    workspace = "2",
})

hl.window_rule({
    name = "waterfox-whatsapp-ws3",
    match = { title = ".*WhatsApp.*" },
    workspace = "3",
})

-- Thunderbird: Lenovo, workspace 5
hl.window_rule({
    name = "thunderbird-ws5",
    match = { class = "^(net.thunderbird.Thunderbird)$" },
    workspace = "5",
})

-- Ghostty: Samsung, workspace 6
hl.window_rule({
    name = "ghostty-ws6",
    match = { class = "^(com.mitchellh.ghostty)$" },
    workspace = "6",
})

-- LibreOffice: Samsung, workspace 7
hl.window_rule({
    name = "libreoffice-ws7",
    match = { class = "^(libreoffice.*)$" },
    workspace = "7",
})

-- Okular: Samsung, workspace 8
-- Eski dosyada hem workspace 7 hem 8 vardi; 8 secildi.
hl.window_rule({
    name = "okular-ws8",
    match = { class = "^(org.kde.okular)$" },
    workspace = "8",
})

-- Telegram: Samsung, workspace 9
hl.window_rule({
    name = "telegram-ws9",
    match = { class = "^(org.telegram.desktop|telegram-desktop)$" },
    workspace = "9",
})

-- GNOME Loupe: ortada, floating, %60 boyutlu, opak
hl.window_rule({
    name = "loupe-floating",
    match = { class = "^(org.gnome.Loupe)$" },
    float = true,
    size = { "60%", "60%" },
    center = true,
    opacity = "1.0 override 1.0 override",
})

-- Mousepad: ortada, floating, sabit boyutlu, tum workspace'lerde
hl.window_rule({
    name = "mousepad-floating",
    match = { class = "^(mousepad)$" },
    float = true,
    size = { 800, 500 },
    center = true,
    opacity = "0.95 override 0.85 override",
    pin = true,
})
