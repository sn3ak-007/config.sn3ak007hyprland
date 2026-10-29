# 🌌 sn3ak-007 Hyprland Ecosystem

![Hyprland](https://img.shields.io/badge/Window_Manager-Hyprland-blue)
![Status](https://img.shields.io/badge/Status-Polished-green)
![Distro](https://img.shields.io/badge/Distro-Fedora%20%7C%20Gentoo-orange)

A curated, high-performance Hyprland configuration focusing on a seamless user experience, a deep-black aesthetic, and intelligent system automation.

## 🌟 Key Highlights

### 🎧 Intelligent Audio Management
- **Dynamic Output Switching**: Change audio devices on the fly via Waybar.
- **Auto-Migration**: Active streams (like Firefox or Spotify) automatically follow your selected output device.
- **Quick Control**: integrated volume sliders and mute toggles in a custom popup.

### 🛠️ Integrated Tooling
- **Custom Control Center**: A centralized popup for Wi-Fi, Bluetooth, Brightness, and Power management.
- **Performance Boost**: One-click CPU performance switching integrated directly into the bar.
- **Hybrid GPU Offloading**: Optimized for laptops with dual GPUs (Intel/NVIDIA).

### 🎨 Aesthetics & UX
- **Deep Dark Theme**: A consistent, eye-friendly dark palette across all components.
- **Noto Typography**: Full multi-language support (CJK/Emoji) for a global experience.
- **Minimalist Waybar**: Information-dense but clutter-free system monitoring.

## 🚀 Quick Start

### 📦 Prerequisites
Ensure you have the following installed:
- **Core**: `hyprland`, `waybar`, `fuzzel`
- **Utilities**: `brightnessctl`, `bluez`, `bluez-utils`, `network-manager`, `libnotify`
- **Audio**: `pipewire`, `wireplumber`

**Fedora installation:**
```bash
sudo dnf install hyprland waybar fuzzel brightnessctl bluez bluez-utils network-manager libnotify pipewire wireplumber
```

### 📂 Installation
```bash
# 1. Create necessary directories
mkdir -p ~/.config/hypr ~/.config/waybar ~/.local/bin

# 2. Deploy configuration
cp -r hypr/* ~/.config/hypr/
cp -r waybar/* ~/.config/waybar/
cp waybar-popup waybar-control-menu ~/.local/bin/

# 3. Set permissions
chmod +x ~/.local/bin/waybar-popup ~/.local/bin/waybar-control-menu
```

## ⌨️ Interaction Map

| Action | Component | Result |
| :--- | :--- | :--- |
| **Left Click** | Audio Icon | Opens Volume Slider Popup |
| **Right Click** | Audio Icon | Switches Audio Output Device |
| **Left Click** | Clock | Opens System Control Center |
| **Click** | CPU Icon | Toggles CPU Performance Mode |

## 🛡️ Maintenance
This repository includes **GitHub Actions** that automatically lint the configuration and scripts on every push to ensure stability.

---
*Maintained by [sn3ak-007](https://github.com/sn3ak-007)*
