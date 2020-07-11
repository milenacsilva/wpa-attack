# WPA/WPA2 Attack
The contents of this repository are supposed to automize the aircracking suite against WPA/WPA2 Networks and are provided for educational purposes only


## Prerequisites
These scripts were made to run on GNOME Shell 3.28.4.  With that in mind, it requires NetWorkManager, aircrack-ng, and crunch

### In case your system:
#####  Doesn't run on GNOME 3:
try changing the line 81 in the wpaAttack.sh

##### Doesn't use NetWorkManager:
maybe the line 92?

##### Doesn't have aircrack-ng installed:
```
sudo apt-get install aircrack-ng
```

##### Doesn't have crunch installed:
```
sudo apt-get install crunch
```

## Set-up
##### 1. Clone this repository to where ever u want :)
##### 2. Change file permitions using:
```
sudo chmod 755 ./wpaAttacksh
```
###### and
```
sudo chmod 755 ./disconectclient.sh
```
##### 3. Lastly, as root and inside the wpa-attack directory, run the wpaAttack.sh script:
```
./wpaAttack.sh
```

## What does it do?
###### A. Puts the wireless interface of the user's choice in monitoring mode
###### B. Shows all the detected access points (runs airodump-ng)
###### C. Prompts user for a BSSID/Channel and saves all recorded captures in the ./captures/ directory
###### D. Executes the second script,performing a deauth attack in a chosen client in order to get a handshake
###### E. Restores the user's NetWork service 
###### F. Runs aircrack-ng either using a dictionary from the ./dic/ directory or crunch
###### G. Saves the password in the ./passwords/ directory
