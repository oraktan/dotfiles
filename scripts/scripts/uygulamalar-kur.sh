#!/usr/bin/env bash
set -euo pipefail

echo "=== Fedora uygulamalari ==="

sudo dnf install -y \
  git gh curl wget \
  neovim fzf \
  swappy grim slurp wtype wl-clipboard \
  wf-recorder ffmpeg-free libnotify \
  rmlint krename meld converseen \
  gimagereader-gtk trash-cli

echo "=== Espanso kontrolu ==="

if dnf repoquery --available --qf '%{name}' espanso-wayland 2>/dev/null | grep -qx espanso-wayland; then
    sudo dnf install -y espanso-wayland
else
    echo "Espanso Wayland bulunamadi."
    echo "Terra deposu etkinlestirildikten sonra kurulabilir."
fi

echo "=== Flatpak uygulamalari ==="

flatpak remote-add --user --if-not-exists flathub \
  https://flathub.org/repo/flathub.flatpakrepo

flatpak install --user -y flathub \
  com.github.qarmin.czkawka \
  com.rustdesk.RustDesk \
  org.localsend.localsend_app \
  org.sabnzbd.sabnzbd \
  org.signal.Signal

echo "=== Kurulum tamamlandi ==="
