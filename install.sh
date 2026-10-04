#!/bin/sh
set -eu

root=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
home=${HOME:?HOME must be set}
install_deps=0

case "${1:-}" in
    "")
        ;;
    --deps)
        install_deps=1
        ;;
    -h|--help)
        printf 'Usage: %s [--deps]\n\nInstall the Hyprland profile. --deps also installs packages using the detected package manager.\n' "$0"
        exit 0
        ;;
    *)
        printf 'Unknown option: %s\nUsage: %s [--deps]\n' "$1" "$0" >&2
        exit 2
        ;;
esac

if [ "$install_deps" -eq 1 ]; then
    "$root/scripts/install-dependencies.sh"
fi

backup_root="$home/.local/state/hyprland-profile-backups/$(date +%Y%m%d-%H%M%S)"

install_tree() {
    source_dir=$1
    target_dir=$2
    find "$source_dir" -type f -print | while IFS= read -r source; do
        relative=${source#"$source_dir"/}
        target="$target_dir/$relative"
        mkdir -p "$(dirname "$target")"

        if [ -e "$target" ] || [ -L "$target" ]; then
            backup="$backup_root/${target#"$home"/}"
            mkdir -p "$(dirname "$backup")"
            cp -a "$target" "$backup"
        fi

        cp "$source" "$target"
        case "$source" in
            "$root"/scripts/*) chmod 755 "$target" ;;
            *) chmod 644 "$target" ;;
        esac
    done
}

install_tree "$root/config" "$home/.config"
install_tree "$root/scripts" "$home/.local/bin"

if [ -d "$backup_root" ]; then
    printf 'Previous files were backed up to: %s\n' "$backup_root"
else
    rmdir "$backup_root" 2>/dev/null || true
fi

printf 'Installed Hyprland profile files to %s/.config and %s/.local/bin.\n' "$home" "$home"
printf 'Log out, select Hyprland in your display manager, and log back in.\n'
