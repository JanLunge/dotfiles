#!/bin/bash
MONSTR=""
MONOFFSET=0

MONLEFT="DP-2"
MONCENTER="DP-4"
MONTV="HDMI-0"

# TODO: if monitor settings file doesnt exist create it, with default settings
if [ -f ~/.config/monitorsettings.json ]; then
    echo 'File exists.'
else
   cat << EOF > ~/.config/monitorsettings.json
{
    "main": {
        "split": "21x9"
    }
}
EOF
fi

# Get the output from xrandr
xrandr_output=$(xrandr)

# Initialize arrays for connected and active monitors
connected_monitors=()
active_monitors=()

# Parse the xrandr output
while IFS= read -r line; do
  if [[ $line == *" connected "* ]]; then
    # Extract the monitor name
    monitor_name=$(echo $line | awk '{print $1}')
    connected_monitors+=("$monitor_name")
    
    # Check if the monitor is active (has a resolution and position set)
    if [[ $line == *"+"* ]]; then
      active_monitors+=("$monitor_name")
    fi
  fi
done <<< "$xrandr_output"

# Output the results
echo "Connected monitors:"
for monitor in "${connected_monitors[@]}"; do
  echo "- $monitor"
done

echo ""

echo "Active monitors (currently outputting display):"
for monitor in "${active_monitors[@]}"; do
  echo "- $monitor"
done


tvenable=$( cat ~/.config/monitorsettings.json | jq .tv.enable -r )
if [ $tvenable="true" ]; then
# mode for zoomed screens on one of the desks
zoom=$( cat ~/.config/monitorsettings.json | jq .tv.zoom -r )
  if [ $zoom = "zoomed" ]; then
    echo "zoomed tv mode"
    sh ~/.screenlayout/zoomed-tv.sh
    if [[ " ${active_monitors[@]} " =~ " ${MONLEFT} " ]]; then
        MONSTR+="1080x1920+$(( $MONOFFSET + 0 ))+0 "
        MONOFFSET=$(( $MONOFFSET + 1080 ))
    fi

    if [[ " ${active_monitors[@]} " =~ " ${MONTV} " ]]; then
        MONSTR+="2560x1400+$(( $MONOFFSET + 0 ))+0 "
        MONOFFSET=$(( $MONOFFSET + 2560 ))
    fi
  else
    echo "small tv mode"
    sh ~/.screenlayout/small-tv.sh
    if [[ " ${active_monitors[@]} " =~ " ${MONLEFT} " ]]; then
        MONSTR+="1440x2560+$(( $MONOFFSET + 0 ))+0 "
        MONOFFSET=$(( $MONOFFSET + 1440 ))
    fi

    if [[ " ${active_monitors[@]} " =~ " ${MONTV} " ]]; then
        MONSTR+="3840x2120+$(( $MONOFFSET + 0 ))+0 "
        MONOFFSET=$(( $MONOFFSET + 3840 ))
    fi
  fi
else
  sh ~/.screenlayout/desk.sh
  if [[ " ${active_monitors[@]} " =~ " ${MONCENTER} " ]]; then
      mode=$( cat ~/.config/monitorsettings.json | jq .main.split -r )
      if [ "$mode" == "21x9" ];
      then
        MONSTR+="1110x1440+$(( $MONOFFSET + 0 ))+0 2900x1400+$(( $MONOFFSET + 1110 ))+40 1110x1440+$(( $MONOFFSET + 4010 ))+0 "
      elif [ "$mode" == "16x9" ];
      then
          MONSTR+="1280x1440+$(( $MONOFFSET + 0 ))+0 2560x1400+$(( $MONOFFSET + 1280 ))+40 1280x1440+$(( $MONOFFSET + 3840 ))+0 "
      fi
      MONOFFSET=$(( $MONOFFSET + 5120 ))
  fi
fi
sleep 1
echo $MONSTR
herbstclient set_monitors $MONSTR
