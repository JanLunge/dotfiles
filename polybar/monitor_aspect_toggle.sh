#!/bin/bash
if [ $(herbstclient list_monitors | grep 2: | cut -d' ' -f2 | cut -d'x' -f1) == 2900 ];
then 
    # set to 16x9
    herbstclient set_monitors 1920x1080+0+0 1280x1440+1920+0 2560x1400+3200+40 1280x1440+5760+0
else
    # set to 21x9
    herbstclient set_monitors 1920x1080+0+0 1110x1440+1920+0 2900x1400+3030+40 1110x1440+5930+0
fi
