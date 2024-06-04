#!/bin/bash
if [ $(herbstclient list_monitors | grep 1: | cut -d' ' -f2 | cut -d'x' -f1) == 2900 ];
then 
    # set to 16x9
    herbstclient set_monitors 1280x1440+0+0 2560x1400+1280+40 1280x1440+3860+0
else
    # set to 21x9
    herbstclient set_monitors 1110x1440+0+0 2900x1400+1110+40 1110x1440+4010+0
fi
