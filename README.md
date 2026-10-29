# 🚀 Polished Hyprland Config by sn3ak-007

A modern, dark-themed, and highly functional Hyprland setup designed for productivity and aesthetics.

## ✨ Features
- **Waybar Customization**: A clean bar with integrated system monitors.
- **Advanced Control Menu**: Right-click the audio icon to switch outputs or use the popup for quick settings.
- **Smart Audio Handling**: Automatic stream migration when changing output devices.
- **Fedora & Gentoo Ready**: Optimized for stability across different distributions.

## 🛠️ Installation

### 1. Copy Configuration
Clone this repository or copy the files to your config folder:
```bash
mkdir -p ~/.config/hypr ~/.config/waybar ~/.local/bin
cp -r hypr/* ~/.config/hypr/
cp -r waybar/* ~/.config/waybar/
cp waybar-popup waybar-control-menu ~/.local/bin/
chmod +x ~/.local/bin/waybar-popup ~/.local/bin/waybar-control-menu
```

### 2. Install Dependencies
Ensure you have the following tools installed:

**For Fedora:**
```bash
sudo dnf install hyprland waybar fuzzel brightnessctl bluez bluez-utils network-manager notify-send
```

**For Gentoo:**
Ensure you have `waybar`, `fuzzel`, `brightnessctl`, `bluez`, and `networkmanager` in your world file.

## ⌨️ Usage
- **Waybar Audio**: 
  - Left-click $\rightarrow$ Volume slider popup.
  - Right-click $\rightarrow$ Choose audio output device.
- **Quick Settings**: Accessible via the clock/home menu in Waybar.

## 📄 License
MIT
