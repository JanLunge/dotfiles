#!/bin/bash
 
res=$(echo "suspend|lock|logout|reboot|shutdown|hibernate" | rofi -sep "|" -dmenu -i -p 'Power Menu: ' "" -auto-select -no-fullscreen) 
 
if [ $res = "lock" ]; then
    /usr/local/bin/lock.sh
fi
if [ $res = "suspend" ]; then
    systemctl suspend
fi
if [ $res = "logout" ]; then
    i3-msg exit
fi
if [ $res = "reboot" ]; then
    systemctl reboot
fi
if [ $res = "shutdown" ]; then
    systemctl poweroff
fi
if [ $res = "hibernate" ]; then
    systemctl hibernate
fi
exit 0
