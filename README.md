# Kelpos Hyprland Config

Personal Hyprland configuration for a dual-monitor desktop, using the Hyprland 0.57+ Lua API.

## Included

- `hyprland.lua`: active configuration, monitor layout, keybindings, startup applications and window rules.
- Rofi outside-click dismissal and a subtle 20% dim behind the menu.
- `hyprpaper.conf`: wallpaper setup.
- Hyprlock configuration and media/Cava helper scripts.
- `bin/rofi-toggle.sh`: launcher used by Super + Space.
- `hyprland.conf`, `monitors.conf` and `workspaces.conf`: legacy configuration retained for reference. The Lua configuration is active.

## Setup

Back up your existing configuration before copying files. Adjust monitor names, positions, refresh rates, wallpaper paths and startup applications for your machine.

```sh
mkdir -p ~/.config/hypr ~/.local/bin
cp hyprland.lua hyprpaper.conf hyprlock.conf hyprlock-cava.conf ~/.config/hypr/
cp -r Scripts ~/.config/hypr/
install -m 755 bin/rofi-toggle.sh ~/.local/bin/rofi-toggle.sh
hyprctl reload
```

Wallpaper and profile images referenced by the configurations are local assets and are not included.

## Related configuration and dependencies

The Lua configuration references scripts from [Kelpos Waybar Theme](https://github.com/Otamarau/kelpos-waybar-theme). For the packaged lock-screen assets and setup details, see [Kelpos Hyprlock Theme](https://github.com/Otamarau/kelpos-hyprlock-theme).

Rofi themes and modes remain in `~/.config/rofi`; this repository contains the Hyprland integration and launcher only. Installed applications referenced by startup commands and keybindings include Kitty, Nautilus, Rofi, Hyprpaper, Hyprlock, Waybar, Mako, Playerctl, Cava, Grim, Slurp, wl-clipboard, Cliphist, Greenclip, CopyQ, NetworkManager applet, brightnessctl and WirePlumber. Review startup commands before enabling this configuration on another system.
