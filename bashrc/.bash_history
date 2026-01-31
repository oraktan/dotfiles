sudo dnf install -y steam
sudo dnf update
flatpak install flathub net.waterfox.waterfox
cd Downloads/
tar xjf waterfox-*.tar.bz2
mv waterfox /opt
sudo mv waterfox /opt
ln -s /opt/waterfox/waterfox /usr/local/bin/waterfox
sudo ln -s /opt/waterfox/waterfox /usr/local/bin/waterfox
ls
cd /opt/
ls
cd waterfox/
ls
waterfox
sudo dnf install -y waterfox
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
flatpak remote-modify --enable flathub
sudo cat /etc/os-release 
sudo dnf upgrade --refresh
sudo dnf system-upgrade download --releasever=43
reboot
sudo rpm -Uvh http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo rpm -Uvh http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install steam
sudo dnf install -y ghostty
vim
sudo dnf install -y vim neovim
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
thunder
sudo dnf install -y thunderbird
thunderbird
cat /etc/os-release 
waterfox &
sudo dnf install hyprland
sudo dnf install hyprland-devel
rebooyt
reboot
firefox
git
git clone https://www.github.com/oraktan/firstsetup
cd firstsetup/
bash install.sh 
cd dotfiles/
ls
cp -r * ../../.config/hypr/
cd
cd .config/hypr/
ls
ll
cd ..
ll
cd hypr/
ls
ll
git clone https://github.com/JaKooLit/Arch-Hyprland
mv Arch-Hyprland/ ../../
cd ../..
cd Arch-Hyprland/
bash install.sh 
sudo dnf copr enable solopasha/hyprland
sudo dnf install hyprland
sudo dnf install hyprpanel
sudo dnf update -y
sudo dnf copr enable solopasha/hyprland -y && sudo dnf update -y && sudo dnf install -y hyprland xdg-desktop-portal-hyprland wlroots wayland-protocols waybar wireplumber pipewire pipewire-alsa pipewire-pulseaudio pavucontrol network-manager-applet wofi dunst hyprpaper hyprlock hypridle grim slurp hyprpicker thunar kitty fontawesome-fonts google-noto-sans-fonts google-noto-emoji-fonts brightnessctl playerctl polkit-gnome
wofi
rofi
wofi show
cd 
vim .config/hypr/hyprland.conf 
waybar
sudo dnf install -y waybar

hyprpanel 
sudo dnf install -y hyprland xdg-desktop-portal-hyprland wlroots wayland-protocols waybar wireplumber pipewire pipewire-alsa pipewire-pulseaudio pavucontrol network-manager-applet wofi dunst hyprpaper hyprlock hypridle grim slurp hyprpicker thunar kitty fontawesome-fonts google-noto-sans-fonts google-noto-emoji-fonts brightnessctl playerctl polkit-gnome
sudo dnf install -y waybar wireplumber pipewire pipewire-alsa pipewire-pulseaudio pavucontrol network-manager-applet wofi dunst hyprpaper hyprlock hypridle grim slurp hyprpicker thunar kitty fontawesome-fonts google-noto-sans-fonts google-noto-emoji-fonts brightnessctl playerctl polkit-gnome
vim .config/hypr/hyprland.conf 
hyprctl reload
reboot
[200~sudo dnf install -y   hyprland   waybar   rofi   dunst   kitty   wl-clipboard   grim   slurp   pipewire \
sudo dnf install -y   hyprland   waybar   rofi   dunst   kitty   wl-clipboard   grim   slurp   pipewire   wireplumber
s rofi
rofi show
git clone https://github.com/JaKooLit/Fedora-Hyprland.git
cd Fedora-Hyprland/
chmod +x install.sh
./install.sh
yazi
yazi
yazi --debug
cd .config/yazi/
rm -rf yazi.toml 
mkdir -p ~/.config/yazi/flavors
pwd
vim yazi.toml
ya pack -a yazi-rs/flavors:catppuccin-mocha
mkdir -p ~/.config/yazi/flavors/catppuccin-mocha.yazi
curl -L https://raw.githubusercontent.com/yazi-rs/flavors/main/catppuccin-mocha.yazi/flavor.toml -o ~/.config/yazi/flavors/catppuccin-mocha.yazi/flavor.toml
cd flavors/catppuccin-mocha.yazi/
pwd
ll
pwd
ls -la
vim flavor.toml 
cd ..
cd .
cd ..
vim yazi.toml 
echo '[theme]
use = "catppuccin-mocha"' > ~/.config/yazi/yazi.toml
vim yazi.toml 
yazi --debug
vim theme.toml
yazi --debug | grep theme.toml
yazi --debug 
vim yazi.toml 
vim theme.toml 
COLORTERM=truecolor yazi
COLORTERM=gryvbox yazi
yazi
pwd
cd
spf -c
spf --help
spf --help | grep config
spf pl
vim .config/superfile/config.toml 
spf
cd .config/superfile/
spf
yazi
vim hotkeys.toml 
