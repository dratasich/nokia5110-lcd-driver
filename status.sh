#!/bin/bash

scriptdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

function print_status {
    # wifi settings
    wid=$(iwconfig 2> /dev/null | \
              grep "SSID" | \
              awk '{print $1}')
    wip=$(ifconfig | \
              grep -A 1 "$wid" | \
              grep -o "inet addr:[0-9]*.[0-9]*.[0-9]*.[0-9]*" | \
              awk '{print $2}' | \
              sed -e "s/addr://g")
    ssid=$(iwconfig 2> /dev/null | \
               grep -o "SSID:.*" | \
               sed -e "s/SSID://g" | \
               sed -e "s/\"//g")

    # try to ping "daisy"
    daisy="NOK"
    if ping -w 1 daisy > /dev/null ; then
        daisy="OK"
    fi

    # check processes for ROS
    num=$(ps aux | grep ros | wc -l)
    num=$(expr $num - 1)

    echo "$ssid $wip; daisy: $daisy; ps ros: $num;  /$1"
}

while true; do
    for s in  0 1 2 3 4 5 6 7 8 9; do
        print_status $s
        sleep 15
    done
done
