#!/bin/sh
set -eu

run_privileged() {
    if [ "$(id -u)" -eq 0 ]; then
        "$@"
    elif command -v sudo >/dev/null 2>&1; then
        sudo "$@"
    elif command -v doas >/dev/null 2>&1; then
        doas "$@"
    else
        echo "Install dependencies as root or install sudo/doas first." >&2
        exit 1
    fi
}

if [ -r /etc/os-release ]; then
    . /etc/os-release
else
    echo "Cannot detect this Linux distribution (/etc/os-release is missing)." >&2
    exit 1
fi

family="$ID ${ID_LIKE:-}"
case "$family" in
    *debian*|*ubuntu*)
        command -v apt-get >/dev/null 2>&1 || {
            echo "APT was not found." >&2
            exit 1
        }
        run_privileged apt-get update
        run_privileged apt-get install -y \
            hyprland hyprlock hyprpaper waybar fuzzel mako-notifier \
            playerctl brightnessctl pipewire-bin wireplumber network-manager \
            bluez blueman python3 python3-gi python3-cairo gir1.2-gtk-3.0 \
            libgtk-layer-shell0 libnotify-bin grim slurp alacritty dolphin \
            firefox-esr jq fonts-liberation
        ;;
    *fedora*)
        command -v dnf >/dev/null 2>&1 || {
            echo "DNF was not found." >&2
            exit 1
        }
        run_privileged dnf install -y \
            hyprland hyprlock hyprpaper waybar fuzzel mako playerctl \
            brightnessctl pipewire-utils wireplumber NetworkManager bluez \
            blueman python3 python3-gobject python3-cairo gtk3 gtk-layer-shell \
            libnotify grim slurp alacritty dolphin firefox jq liberation-fonts
        ;;
    *arch*)
        command -v pacman >/dev/null 2>&1 || {
            echo "Pacman was not found." >&2
            exit 1
        }
        run_privileged pacman -S --needed \
            hyprland hyprlock hyprpaper waybar fuzzel mako playerctl \
            brightnessctl pipewire wireplumber networkmanager bluez blueman \
            python python-gobject python-cairo gtk-layer-shell libnotify grim \
            slurp alacritty dolphin firefox jq ttf-liberation
        ;;
    *suse*)
        command -v zypper >/dev/null 2>&1 || {
            echo "Zypper was not found." >&2
            exit 1
        }
        run_privileged zypper install -y \
            hyprland hyprlock hyprpaper waybar fuzzel mako playerctl \
            brightnessctl pipewire wireplumber NetworkManager bluez blueman \
            python3-gobject python3-cairo gtk-layer-shell libnotify-tools grim \
            slurp alacritty dolphin MozillaFirefox jq liberation-fonts
        ;;
    *gentoo*)
        command -v emerge >/dev/null 2>&1 || {
            echo "Emerge was not found." >&2
            exit 1
        }
        run_privileged emerge --ask \
            gui-apps/hyprland gui-apps/hyprlock gui-apps/hyprpaper \
            gui-apps/waybar gui-apps/fuzzel gui-apps/mako \
            media-sound/playerctl app-misc/brightnessctl media-video/pipewire \
            media-video/wireplumber net-misc/networkmanager net-wireless/bluez \
            net-wireless/blueman dev-lang/python dev-python/pygobject \
            dev-python/pycairo gui-libs/gtk-layer-shell dev-libs/libnotify \
            media-gfx/grim gui-apps/slurp x11-terms/alacritty kde-apps/dolphin \
            www-client/firefox app-misc/jq media-fonts/liberation-fonts
        ;;
    *)
        printf 'Automatic dependency installation is not configured for %s.\n' "$ID" >&2
        echo "Install the packages listed in README.md with your distribution's package manager, then run ./install.sh." >&2
        exit 1
        ;;
esac
