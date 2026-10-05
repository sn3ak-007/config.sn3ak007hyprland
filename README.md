# Hyprland monochrome desktop

A personal black-and-white Hyprland desktop setup with Waybar, Fuzzel, Mako,
media keys, volume/brightness popups, Wi-Fi and Bluetooth menus, and a
touchpad-friendly laptop configuration. The scripts use `$HOME` and commands
from `PATH`, so they do not assume a particular username or `/usr/bin` layout.

## Requirements

- Linux with Hyprland's native Lua configuration support (the config uses the
  `hl` Lua API; older Hyprland releases may not support it).
- A supported package manager for optional automatic dependency installation:
  APT (Debian/Ubuntu), DNF (Fedora), Pacman (Arch), Zypper (openSUSE), or
  Portage (Gentoo).
- NetworkManager for Wi-Fi controls, PipeWire/WirePlumber for audio controls,
  and BlueZ for Bluetooth controls. Those services must be enabled separately
  if the distribution does not enable them automatically.

## Install

Clone this repository and install the profile:

```sh
git clone https://github.com/sn3ak-007/config.sn3ak007hyprland.git
cd config.sn3ak007hyprland
./install.sh
```

The installer backs up files it replaces under
`~/.local/state/hyprland-profile-backups/` and copies the configuration and
helper scripts into their standard XDG locations. It does not change system
services or install packages unless explicitly requested.

To install dependencies from the detected package manager as well:

```sh
./install.sh --deps
```

Review the package list in `scripts/install-dependencies.sh` first. Some
stable-release repositories may not provide a recent enough Hyprland or one
of its companion applications; in that case, install Hyprland from the
distribution's recommended source and install the remaining dependencies
manually. The package-manager command may prompt for administrator
authentication.

After installation, log out, choose **Hyprland** in the display manager, and
log in again. The profile uses automatic preferred monitor modes and the
included dark wallpaper. Set `HYPRLAND_VIDEO_WALLPAPER` to a readable video
file if you also have `mpvpaper` and want a video background.

## What is included

- `config/hypr`: Lua compositor config, lock screen, wallpaper, and background
- `config/waybar`: status bar, fan sensor, media controls, and menus
- `config/fuzzel`: monochrome application launcher
- `config/mako`: monochrome desktop notifications and replaceable OSD
- `scripts`: portable helper scripts used by the config

## Notes

- Hardware-specific readings are optional. If no fan sensor is exposed through
  Linux `hwmon`, Waybar shows `FAN N/A`.
- The GTK network/Bluetooth popup needs GTK 3, PyGObject, Pycairo, and
  GTK Layer Shell. eduVPN controls are optional and appear only when its CLI
  and GUI are available on `PATH`.
- For DCTerra eduroam, use the official [geteduroam Linux client](https://github.com/geteduroam/linux-app/releases)
  and select **DCTerra**. DCTerra's official CAT entry redirects to its
  geteduroam provisioning profile; do not use a hand-built PEAP profile or
  disable certificate verification. The Waybar Wi-Fi menu reuses the
  generated `eduroam (from geteduroam)` profile when it is present.
- Fedora, Debian/Ubuntu, Arch, openSUSE, and Gentoo package commands are
  provided as a convenience, but this profile has only been exercised on its
  original Gentoo/Hyprland setup. Review the scripts and distribution package
  availability before using `--deps`.
