# [ [AUTHOR](https://github.com/swrneko) OF THIS DOTS IS SWRNEKO ] 

### Arch Linux / Hyprland / Noctalia Shell
A minimal, efficiency-oriented desktop environment configuration with a focus on clean aesthetics and smooth Wayland performance.

---

# 📺 SHOWCASE VIDEO
<p align="center">
  <a href="YOUR_YOUTUBE_LINK_HERE">
    <img src="https://raw.githubusercontent.com/swrneko/dots-next/main/src/screen.jpg" alt="Showcase Preview" width="100%" style="border-radius: 10px;">
  </a>
  <br>
  <em>Click the image above to watch the full system showcase on YouTube</em>
</p>

---

## 📦 01. Prerequisites & Dependencies

To ensure the system looks and functions exactly as shown in the video, you must install the following base packages.

### Core Components (Arch Linux)
Use `pacman` to install the system core:

```bash
sudo pacman -S --needed \
    hyprland hyprpm hyprlock \
    xdg-desktop-portal-hyprland xdg-desktop-portal-gtk \
    xorg-xwayland xorg-xrdb xembedsniproxy \
    grim slurp wl-clipboard \
    brightnessctl playerctl wireplumber \
    kitty nemo btop ttf-0xproto-nerd \
    cpupower python-pipx git base-devel \
    noctalia
```

**Why these are important:**
*   **XDG Portals:** Essential for screen sharing (Discord/Zoom) and file picker dialogs.
*   **Font (0xProto Nerd Font):** Hardcoded in Kitty and Noctalia configs. Without it, icons will appear as empty boxes.
*   **Utilities:** `grim`/`slurp` handle screenshots, while `playerctl` manages media playback via keybindings.

### External Modules (AUR)
These components should be installed via an AUR helper (e.g., `yay` or `paru`):
1.  **Noctalia Shell:** [Installation Guide](https://docs.noctalia.dev/noctalia/getting-started/installation/). The heart of the UI (panels, widgets, and launcher).
2.  **Zen Browser:** My primary browser. You can change this to your preferred browser in the `hyprland.lua` file.

---

## 🚀 02. Installation Procedure

I recommend a automated installation because it has a backup process to prevent any loss data way.

### Option A: Automated (Recommended)
Clone the repo to your home directory:
```bash
git clone https://github.com/w0nd3rfuul/dots-next.git
cd dots-next
chmod +x install.sh
./install.sh
```

### Option B: Manual Installation

### Step 1: Clone the Repository
Clone the dots into your home directory:
```bash
git clone https://github.com/w0nd3rfuul/dots-next.git
cd dots-next
```

### Step 2: System Backup (Safety First)
Before applying the dots, it's better to move your existing configurations to a backup folder to prevent any data loss.
```bash
# Create a backup directory
mkdir -p ~/dotfiles_backup

# Move existing directories (errors will be ignored if folders don't exist)
mv ~/.config/hypr ~/dotfiles_backup/ 2>/dev/null
mv ~/.config/kitty ~/dotfiles_backup/ 2>/dev/null
mv ~/.config/noctalia ~/dotfiles_backup/ 2>/dev/null
```

### Step 3: Apply Configuration
Copy the `.config` content from this repository to your system:
```bash
cp -r .config/* ~/.config/
```

---

## ⚙️ 03. Hardware Adaptation (Critical Nuances)

After copying the files, you **must** adjust a few settings to match your hardware, otherwise, the system might fail to boot or perform poorly.

### 1. Display Configuration
Hyprland needs to know your monitor's resolution and refresh rate.
1. Open the config: `nano ~/.config/hypr/hyprland.lua`
2. Locate the `hl.monitor` section.

### 2. NVIDIA Support
Hyprland works best on AMD/Intel. If you are using an **NVIDIA GPU**, you **must** uncomment (remove the `#`) these lines in `hyprland.conf`:
```bash
env = LIBVA_DRIVER_NAME,nvidia
env = XDG_SESSION_TYPE,wayland
env = GBM_BACKEND,nvidia-drm
env = __GLX_VENDOR_LIBRARY_NAME,nvidia
```
*Failure to do this may result in a black screen, crashes, or visual artifacts.*

---

## ⌨️ 04. System Keybindings

| Shortcut | Action | Description |
| :--- | :--- | :--- |
| `SUPER` + `RET` | **Terminal** | Launch Kitty |
| `SUPER` + `D` | **Launcher** | Open Application Menu (Noctalia) |
| `SUPER` + `E` | **Explorer** | Open Nemo File Manager |
| `SUPER` + `SHIFT` + `Q` | **Kill** | Close focused window |
| `SUPER` + `SHIFT` + `S` | **Area screenshot** | Select area for screenshot |

*Note: The `SUPER` key is usually the Windows logo key.*

---

## 🛠️ 05. Troubleshooting

*   **Black screen on login:** Double-check your monitor settings in `hyprland.lua` and ensure GPU drivers are installed.
*   **Missing Panels:** Ensure Noctalia Shell is installed.
*   **Broken Icons:** You likely missed the `ttf-0xproto-nerd` package.

If you encounter a bug or have a suggestion, please open an **Issue** or leave a comment under the video. Enjoy!
