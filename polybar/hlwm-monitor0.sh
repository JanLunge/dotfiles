#!/usr/bin/env bash
herbstclient --idle "tag_*" 2>/dev/null | {

    while true; do

        for number in $(herbstclient list_monitors | cut -c1 | xargs -d '\n')
        do
            TAG="$(herbstclient list_monitors | grep $number: | xargs -d' ' -n 1 | grep \" | cut -c2)"
            FOCUS="$(herbstclient list_monitors | grep $number: | xargs -d' ' -n 1 | grep "\[")"
            if [ $FOCUS == "[FOCUS]" ];
            then
                echo -n "%{B#F27127}"
            fi
            echo -n "%{A1:herbstclient use $TAG:}  $TAG  %{A -u -o F- B-}"
            echo -n "%{B-}"
        done
    echo "    "
    # wait for next event from herbstclient --idle
    read -r || break
done
} 2>/dev/null
