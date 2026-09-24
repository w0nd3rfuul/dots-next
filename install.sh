#!/bin/bash
set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# ---------------- #
# 1. DEPENDENCIES  #
# ---------------- #
echo -e "${YELLOW}>>> Installing dependencies...${NC}"
sudo pacman -S --needed --noconfirm \
    hyprland hyprpm hyprlock \
    xdg-desktop-portal-hyprland xdg-desktop-portal-gtk \
    xorg-xwayland xorg-xrdb xembedsniproxy \
    grim slurp wl-clipboard \
    brightnessctl playerctl wireplumber \
    kitty nemo btop ttf-0xproto-nerd \
    cpupower python-pipx git base-devel \
    noctalia

echo -e "${GREEN}>>> Dependencies installed.${NC}"

# ---------------- #
# 2. AUR PACKAGES  #
# ---------------- #
echo -e "${YELLOW}>>> Installing AUR packages (zen-browser-bin)...${NC}"
if command -v paru >/dev/null 2>&1; then
    AUR_HELPER="paru"
elif command -v yay >/dev/null 2>&1; then
    AUR_HELPER="yay"
else
    echo -e "${RED}>>> No AUR helper found (paru/yay). Skipping AUR packages.${NC}"
    echo -e "${RED}>>> Install zen-browser-bin manually.${NC}"
    AUR_HELPER=""
fi

if [ -n "$AUR_HELPER" ]; then
    $AUR_HELPER -S --needed --noconfirm zen-browser-bin || true
fi

# ---------------- #
# 3. BACKUP        #
# ---------------- #
echo -e "${YELLOW}>>> Backing up existing configs...${NC}"
mkdir -p "$HOME/dotfiles_backup"
mv "$HOME/.config/hypr" "$HOME/dotfiles_backup/" 2>/dev/null || true
mv "$HOME/.config/kitty" "$HOME/dotfiles_backup/" 2>/dev/null || true
mv "$HOME/.config/noctalia" "$HOME/dotfiles_backup/" 2>/dev/null || true

# ---------------- #
# 4. COPY CONFIGS  #
# ---------------- #
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo -e "${YELLOW}>>> Copying configs...${NC}"

# Hyprland
mkdir -p "$HOME/.config/hypr"
cp -v "$SCRIPT_DIR/hypr/hyprland.lua" "$HOME/.config/hypr/hyprland.lua"

# Kitty
mkdir -p "$HOME/.config/kitty"
cp -v "$SCRIPT_DIR/kitty/kitty.conf" "$HOME/.config/kitty/kitty.conf"

# Noctalia
mkdir -p "$HOME/.config/noctalia"
cp -rv "$SCRIPT_DIR/noctalia/." "$HOME/.config/noctalia/"

echo -e "${GREEN}>>> Configs copied.${NC}"

# ---------------- #
# 5. HYPRLAND PLUGINS #
# ---------------- #
echo -e "${YELLOW}>>> Installing Hyprland plugins...${NC}"
hyprpm add https://github.com/VirtCode/hypr-dynamic-cursors || true
hyprpm enable dynamic-cursors || true

echo -e "${GREEN}>>> Done!${NC}"
echo -e "${GREEN}>>> Restart Hyprland with: hyprctl dispatch exit${NC}"