#!/usr/bin/env bash
monitor_width=$(herbstclient list_monitors | grep 1: | cut -d' ' -f2 | cut -d'x' -f1)
if [[ -z "$monitor_width" ]]; then
    echo "Error: Could not extract monitor width."
    exit 1
fi
if [ $monitor_width == 2900 ];
then echo "21x9";
else echo "16x9"
fi
