#!/bin/bash

MENU=" Applications\n󰖩 WiFi Settings\n Bluetooth Setting\n System"
WIFI_MENU="󱛁 WiFi Scan\n󱚼 Disable WiFi\n󰈉 Connect to Hidden Network\n󰉉 Show saved WiFi"
BLUETOOTH_MENU=""
SYSTEM_MENU=" Shutdown\n Reboot\n󰒲 Sleep"

MAIN_MENU=$(echo -e "$MENU" | rofi -dmenu -p "0xbdg")
WIFI=$(echo -e "$WIFI_MENU" | rofi -dmenu)
BLUETOOTH=$()

function main()
    case $MAIN_MENU in
        " Applications") rofi -show drun -show-icons ;;
        "󰖩 WiFi Settings")
            case $WIFI in 
                "󱛁 WiFi Scan") rofi -drun ;;
                *) exit ;;
            esac
        ;;
        
        *) exit ;;

    esac
main
