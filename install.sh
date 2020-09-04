#!/bin/bash

if [ "$EUID" -ne 0 ]
    then echo "I don't have the required permissions (｡╯︵╰｡), make sure to run the installer as root"
    exit
fi

echo "Installing requiwed packages, pwease wait (￣▽￣*)ゞ"
apt-get -qq install aircrack-ng crunch -y

echo "Changing permissions for required files ヽ(*・ω・)ﾉ"
chmod 755 ./wpaAttacksh
chmod 755 ./disconectclient.sh

echo "We're all set up! Have fun hacking *ethically* (≧◡≦)"

exit