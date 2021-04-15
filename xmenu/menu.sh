#!/bin/sh

cat <<EOF | xmenu | sh &
left
	on	xrandr --output DP-3 --left-of DP-0 --auto
	off	xrandr --output DP-3 --off
4k
	on	xrandr --output DP-4 --right-of DP-0 --auto
	wqhd	xrandr --output DP-4 --right-of DP-0 --mode 2560x1440
	off	xrandr --output DP-4 --off

reload Bar	sh ~/.config/polybar/launch.sh
reload HLWM	herbstclient reload
reload mon	sh ~/dotfiles/herbstluftwm/auto-monitor-config.sh
fullscreen	herbstclient fullscreen
swap tags to focus
	on	herbstclient set swap_monitors_to_get_tag 1
	off	herbstclient set swap_monitors_to_get_tag 0
compositor
	on	herbstclient spawn picom
	off	killall picom
EOF
