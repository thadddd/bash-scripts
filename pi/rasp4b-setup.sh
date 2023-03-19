#!/usr/bin/bash

######################################################################################
###                                                               made by: thadddd ###
###                                                 http://www.github.com/thadddd/ ###
###                                                        Started: March 10, 2023 ###
###                                  Current v: 1.00   Upload date: March 16, 2023 ###                        
######################################################################################

##||||||||||| Automated setup of rapsi-pi 4b
############################################ 
## DISTROS:
## 1-KALI 32 DESKTOP
## 2-KALI 32 HEADLESS 
## 3-KALI 64 DESKTOP
## 4-RASPIAN 32 DESKTOP
## 5-RASPIAN 32 HEADLESS
## 6-RASPIAN 64 DESKTOP
## 7-UBUNTU SERVER
## 8-UBUNTU 32 DESKTOP
## 9-UBUNTU 32 HEADLESS
## 10-UBUNTU 64 DESKTOP
## 11-OPENAUTO PRO
## 12-OPENWRT
##
## PI VERSION
## 1-PI 400 4GB
## 2-PI 4B 1GB
## 3-PI 4B 2GB
## 4-PI 4B 4GB
## 5-PI 3B 512MB
##
## PURPOSE:
## 1-WARDRIVING
## 2-WIFI HACK
## 3-PIHOLE
## 4-IOT
## 5-MEDIA
## 6-TRUCK HEADUNIT
## 7-ROUTER
## 8-TRAFFIC SNIFFER
##
## WIFI ADAPTERS:
## 1-ALPHA AWUS1900
## 2-ALPHA AWUS036AC
## 3-BROSTREND AC1L/AC3L
## 4-NINEPLUS

# # # # # # # # # # # # # # # # # # # # # # # # # #
#   INITIAL VARIABLES NEEDED
# # # # # # # # # # # # # # # # # # # # # # # # # #

usr=$(whoami)
sapt='sudo apt-get'
inst='sudo apt-get install -y'
#dir='/home/$usr/'
dist=$101
bit=$102
vers=$103
adap=$104
pur1=$105
pur2=$106
pur3=$107

# # # # # # # # # # # # # # # # # # # # # # # # # #
#   TEXT COLORS
# # # # # # # # # # # # # # # # # # # # # # # # # #

blk='\e[0;30m'
red='\e[0;31m'
grn='\e[0;32m'
ylw='\e[0;33m'
blu='\e[0;34m'
prp='\e[0;35m'
cyn='\e[0;36m'
gry='\e[0;37m'
noc='\e[0;0m'

# # # # # # # # # # # # # # # # # # # # # # # # # #
#   Functions - Menus
# # # # # # # # # # # # # # # # # # # # # # # # # #

menuMAIN(){
    clear;
    echo -ne "
        $YLW ________________________________________
        $RED ..... Raspberry Pi Automated Setup .....
        $YLW ________________________________________
        $noc    
        $red Which distro is installed?
        $noc    
        $GRN -----KaliPi-----
        $grn 1--KaliPi 32bit Headless
        $grn 2--KaliPi 32bit Desktop
        $grn 3--KaliPi 64bit Desktop
        $BLU -----Raspian-----
        $blu 4--Raspian 32bit Headless
        $blu 5--Raspian 32bit Desktop
        $blu 6--Raspian 64bit Desktop
        $PRP -----Ubuntu-----
        $prp 7--
"
}

menu_head(){
    clear;
    echo -ne "
        $RED ==============================
        $YLW |  Raspberry Pi Auto Setup   |  
        $GRN ==============================
        $noc"
}







