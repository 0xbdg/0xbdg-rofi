#!/bin/bash

MENU="App\nNetwork setting\nBluetooth setting"
CHOICES=$(echo -e "$MENU" | rofi -dmenu -p "0xbdg")

case $CHOICES in
    App) rofi -show drun -show-icons ;;
    *) exit ;;

esac
