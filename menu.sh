#!/bin/bash

MAIN_MENU=" Applications\n󰖩 WiFi Settings\n Bluetooth Setting\n System"
WIFI_MENU="󱛁 WiFi Scan\n󱚼 Disable WiFi\n󰈉 Connect to Hidden Network\n󰉉 Show saved WiFi\n Back"
BLUETOOTH_MENU="Power:\nScan\nPairable\nDiscoverable\nBack"
SYSTEM_MENU=" Shutdown\n Reboot\n󰒲 Sleep\n Back"

wifi_menu(){
    WIFI=$(echo -e "$WIFI_MENU" | rofi -dmenu)
    case $WIFI in  
            "󱛁 WiFi Scan") rofi -drun ;;
            " Back") main_menu ;;
            *) exit ;;
    esac
}

bluetooth_menu(){
    BLUETOOTH=""
}

system_menu(){
    SYSTEM=$(echo -e "$SYSTEM_MENU" | rofi -dmenu)
    case $SYSTEM in 
        " Shutdown") ;;
        " Back") main_menu ;;
        *) exit ;;
    esac
}

main_menu(){
    MAIN=$(echo -e "$MAIN_MENU" | rofi -dmenu -p "0xbdg")
    case $MAIN in
        " Applications") rofi -show drun -show-icons ;;
        "󰖩 WiFi Settings")
            wifi_menu
        ;;
        " Bluetooth Setting") rofi -drun ;;
        " System")
            system_menu 
        ;;
        
        *) exit ;;

    esac
}

main_menu
