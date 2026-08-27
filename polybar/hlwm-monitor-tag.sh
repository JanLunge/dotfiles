#!/usr/bin/env bash
herbstclient --idle "tag_*" 2>/dev/null | {
    TAG=$(herbstclient list_monitors |grep "$1:"| cut -d ' ' -f 5|tr -d '"')
    ACTIVETAG=$(herbstclient tag_status | xargs -d'\t' -n 1|grep "#"| cut -c2-)
    echo "%{A1:herbstclient use $TAG:} $TAG : $ACTIVETAG %{A -u -o F- B-}"
    # while i true; do
    #     # Read tags into $tags as array
    #     IFS=$'\t' read -ra tags <<< "$(herbstclient tag_status $1)"
    #     {
    #         for i in "${tags[@]}" ; do
    #             # Read the prefix from each tag and render them according to that prefix
    #             case ${i:0:1} in
    #                 '+')
    #                     echo "%{A1:herbstclient use ${i:1}:}"
    #                     echo "  ${i:1}  %{A -u -o F- B-}"
    #                     ;;
    #                 '#')
    #                     echo "%{A1:herbstclient use ${i:1}:}"
    #                     echo "%{B#F20}  ${i:1}  %{A -u -o F- B-}"
    #                     ;;

    #             esac
    #         done
    #     } | tr -d "\n"
    #     echo "    "
    # # wait for next event from herbstclient --idle
    # read -r || break
    # done
} 2>/dev/null
