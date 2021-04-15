#!/bin/bash
MONSTR=""
MONOFFSET=0

#left
MONLEFT="HDMI-0"
#center
MONCENTER="DP-2"
#right
MONRIGHT="DP-1"

if xrandr | grep " connected" | grep $MONRIGHT | grep -q mm;
then
    MONSTR+="1680x1050+$(( $MONOFFSET + 0 ))+0 "
    MONOFFSET=$(( $MONOFFSET + 1680 ))
fi

if xrandr | grep " connected" | grep $MONCENTER | grep -q mm;
then
    mode=$( cat ~/.config/monitorsettings.json | jq .main.split -r )
    if [ $mode == "21x9" ];
    then
    	MONSTR+="1110x1440+$(( $MONOFFSET + 0 ))+0 2900x1400+$(( $MONOFFSET + 1110 ))+40 1110x1440+$(( $MONOFFSET + 4010 ))+0 "
    elif [ $mode == "16x9" ];
    then
        MONSTR+="1280x1440+$(( $MONOFFSET + 0 ))+0 2560x1400+$(( $MONOFFSET + 1280 ))+40 1280x1440+$(( $MONOFFSET + 3840 ))+0 "
    fi
    MONOFFSET=$(( $MONOFFSET + 5120 ))
fi


if xrandr | grep " connected" | grep $MONLEFT | grep -q mm;
then
    MONSTR+="1920x1080+$(( $MONOFFSET + 0 ))+0 "
    MONOFFSET=$(( $MONOFFSET + 1920 ))
fi

herbstclient set_monitors $MONSTR
