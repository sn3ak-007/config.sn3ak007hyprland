# Hyprland Config by sn3ak-007

A polished Hyprland and Waybar configuration.

## Installation

1. Copy the `hypr` and `waybar` directories to your `~/.config/` folder.
2. Place the scripts from the root into `~/.local/bin/` and make them executable:
   `chmod +x ~/.local/bin/waybar-popup ~/.local/bin/waybar-control-menu`

## Fedora Compatibility
This configuration uses common tools:
- Hyprland
- Waybar
- Fuzzel
- WirePlumber / PipeWire
- Brightnessctl
- NetworkManager (nmcli)
- Bluez (bluetoothctl)

On Fedora, ensure these are installed:
`sudo dnf install hyprland waybar fuzzel brightnessctl bluez bluez-utils network-manager`
