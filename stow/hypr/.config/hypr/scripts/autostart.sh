#!/bin/bash

set +e

# obs
# dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=wlroots
# The next line of command is not necessary. It is only to avoid some situations where it cannot start automatically
# /usr/lib/xdg-desktop-portal-wlr &

# plugins
hyprpm reload -n &

# notify
swaync &

# night light
hyprsunset -t 4000 &

# applets
nm-applet & blueman-applet &

# swayosd
swayosd-server &

# pyprland
pypr &

# wallpaper
#swaybg -i ~/.config/mango/wallpaper/room.png &
#waypaper --restore &

# top bar
waybar -c ~/.config/hypr/waybar/config.jsonc -s ~/.config/hypr/waybar/style.css &

# keep clipboard content
wl-clip-persist --clipboard regular --reconnect-tries 0 &

# clipboard content manager
wl-paste --watch cliphist store &
wl-paste --type text --watch cliphist store &
wl-paste --type image --watch cliphist store &

# xwayland dpi scale
#echo "Xft.dpi: 140" | xrdb -merge #dpi缩放
#gsettings set org.gnome.desktop.interface text-scaling-factor 1

# Permission authentication
#/usr/lib/xfce-polkit/xfce-polkit &
