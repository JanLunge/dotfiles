#!/bin/bash
# changeVolume

# Arbitrary but unique message id
msgId="991049"
channel=0
# Change the volume using alsa(might differ if you use pulseaudio)
amixer -c $channel set Master "$@" > /dev/null

# Query amixer for the current volume and whether or not the speaker is muted
volume="$(amixer -c $channel get Master | tail -1 | awk '{print $4}' | sed 's/[^0-9]*//g')"
mute="$(amixer -c $channel get Master | tail -1 | awk '{print $6}' | sed 's/[^a-z]*//g')"
if [[ $volume == 0 || "$mute" == "off" ]]; then
    # Show the sound muted notification
    dunstify -a "changeVolume" -u low -i audio-volume-muted -r "$msgId" "Volume muted" 
else
    # Show the volume notification
    dunstify -a "changeVolume" -u low -i audio-volume-high -r "$msgId" \
             "Volume: ${volume}%" "$(getProgressString 10 "<b> </b>" " " $volume)"
fi

# Play the volume changed sound
canberra-gtk-play -i audio-volume-change -d "changeVolume"
