#!/bin/bash

MAIN_MENU=" Applications\n󱚾 WiFi Settings\n Bluetooth Settings\n System\n󰩈 Exit"
WIFI_MENU="󱛁 WiFi Scan\n󱚼 Disable WiFi\n󰈉 Connect to Hidden Network\n󰉉 Show saved WiFi\n Back"
SYSTEM_MENU=" Shutdown\n Reboot\n󰒲 Sleep\n Back"

app_menu(){
    rofi -show drun -show-icons
}

wifi_scan(){ 
    WIFI_LIST=" Back\n󱛄 Rescan\n$(printf '#%.0s' {1..65})\n"
    WIFI_LIST+=$(nmcli -t -f ssid d w l | grep -v '^$')
    SELECTED_MENU=$(printf "%b" "$WIFI_LIST" | rofi -dmenu -p "Select SSID")

    case $SELECTED_MENU in
        " Back") wifi_menu ;;
        "󱛄 Rescan")
            notify-send "Rescan WiFi..."
            nmcli d w rescan
            wifi_scan
            ;;
        "$(printf '#%.0s' {1..65})") wifi_scan ;;
        *) 
            IS_CONNECTED=$(nmcli --get-value active,ssid d w l | grep "$SELECTED_MENU" | cut -d: -f1)
            IS_PASSWD=$(nmcli --get-value security,ssid d w l | grep "$SELECTED_MENU" | cut -d: -f1)

            echo "$IS_CONNECTED $IS_PASSWD"
            if [[ "$IS_CONNECTED" != "yes" ]]; then
                if [[ "$IS_PASSWD" == "" ]]; then
                    notify-send "Connecting...."
                    nmcli d w c "$SELECTED_MENU"
                    notify-send "WiFi connect success: $SELECTED_MENU"
                    wifi_scan
                else
                    PASSWD=$(echo -e " Back" | rofi -dmenu -p "Password for $SELECTED_MENU" -dump-filter -password)

                    if [[ $PASSWD == " Back" ]]; then
                        wifi_scan
                    else
                        if nmcli d w c "$SELECTED_MENU" password "$PASSWD"; then
                            notify-send "Success connect to $SELECTED_MENU"
                            wifi_scan
                        else
                            notify-send "Wrong password, try again!"
                        fi
                    fi
                                                                                                                                fi
            else
                notify-send "You are already connected to this WiFI"
                wifi_scan
            fi
            ;;
    esac

}

hidden_wifi(){
    SSID=$(echo -e "Back" | rofi -dmenu -p "Enter SSID" -dump-filter)

    case $SSID in 
        "Back") wifi_menu;;
        *)
            PW=$(echo -e "Back" | rofi -dmenu -p "Enter Password" -dump-filter)

            if [[ $PW == "Back" ]]; then
                wifi_menu
            fi
            notify-send "Connecting..."
            nmcli d w c "$SSID" password "$PW" hidden yes
            notify-send "WiFi connected success $SSID"
            wifi_menu
        ;;
    esac
}

saved_wifi(){
    LIST="Back"
    LIST+=$(nmcli -t -f NAME,DEVICE con show)

    M=$(echo -e "$LIST" | rofi -dmenu)

}

wifi_menu(){
    WIFI=$(echo -e "$WIFI_MENU" | rofi -dmenu)
    case $WIFI in  
        "󱛁 WiFi Scan") 
            notify-send "Scanning WiFi..." 
            wifi_scan ;;
        "󱚼 Disable WiFi") ;;
        "󰈉 Connect to Hidden Network") hidden_wifi;;
        "󰉉 Show saved WiFi") saved_wifi ;;
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
        " Applications") app_menu ;;
        "󱚾 WiFi Settings")
            wifi_menu
        ;;
        " Bluetooth Settings") rofi -drun ;;
        " System")
            system_menu 
        ;;
        
        "󰩈 Exit") exit ;;
    esac
}

main_menu
