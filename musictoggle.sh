#!/bin/bash

main() {
    local action=toggle
    while getopts :mu option; do 
        case "$option" in 
            m) action=mute ;;
            u) action=unmute ;;
            ?) usage 1 "invalid option: -$OPTARG" ;;
        esac
    done
    shift $((OPTIND - 1))
    local pid=$(pidof "$1")
    if [[ -z "$pid" ]]; then
        echo "error: no running processes for: $1" >&2
    elif [[ "$1" ]]; then
        $action "$1"
    else
        usage 1 "specify an application name" 
    fi
}

usage() {
    [[ "$2" ]] && echo "error: $2"
    echo "Usage: $0 [-m | -u] appname"
    echo "Default: toggle mute"
    echo "Arguments:"
    echo "-m = mute application"
    echo "-u = unmute application"
    exit $1
}

toggle() {
    local status=$(get_status "$1")
    if [[ "$status" == "yes" ]]; then
      unmute "$1"
    elif [[ "$status" == "no" ]]; then
      mute "$1"
    fi
}

mute()   { adjust_muteness "$1" 1; }
unmute() { adjust_muteness "$1" 0; }

adjust_muteness() { 
    local index=$(get_index "$1")
    local status=$(get_status "$1")
    [[ "$index" ]] && pacmd set-sink-input-mute "$index" $2 >/dev/null 
}

get_index() {
    local pid=$(pidof "$1")
    pacmd list-sink-inputs | 
    awk -v pid=$pid '
    $1 == "index:" {idx = $2} 
    $1 == "application.process.id" && $3 == "\"" pid "\"" {print idx; exit}
    '
}

get_status() {
   local pid=$(pidof "$1")
   pacmd list-sink-inputs | 
   awk -v pid=$pid '
   $1 == "muted:" {idx = $2} 
   $1 == "application.process.id" && $3 == "\"" pid "\"" {print idx; exit}
   '
}

main "$@"
