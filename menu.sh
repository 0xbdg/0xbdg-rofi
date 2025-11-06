#!/bin/bash

MENU="Applications\nNetwork setting\nBluetooth setting"
CHOICES=$(echo -e "$MENU" | rofi -dmenu -p "0xbdg")

case $CHOICES in
    Applications) rofi -show drun -show-icons ;;
    *) exit ;;

esac
