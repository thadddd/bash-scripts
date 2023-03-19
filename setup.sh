#!/usr/bin/bash

######################################################################################
###                                                               made by: thadddd ###
###                                                 http://www.github.com/thadddd/ ###
###                                                        Started: March 10, 2023 ###
###                                  Current v: 1.00   Upload date: March 16, 2023 ###                        
######################################################################################

## Nvidia GeForce 560 Ti installer with Cuda 8.0 on Ubuntu Server 20.04.3

# # # # # # # # # # # # # # # # # # # # # # # # # #
#   INITIAL VARIABLES NEEDED
# # # # # # # # # # # # # # # # # # # # # # # # # #

usr=$(whoami)
dir='/home/$usr/'



# # # # # # # # # # # # # # # # # # # # # # # # # #
#   TEXT COLORS
# # # # # # # # # # # # # # # # # # # # # # # # # #

blk='\e[30m'
red='\e[31m'
grn='\e[32m'
ylw='\e[33m'
blu='\e[34m'
mag='\e[35m'
cyn='\e[36m'
gry='\e[37m'
noc='\e[0m'

# # # # # # # # # # # # # # # # # # # # # # # # # #
#   MENU FUNCTIONS
# # # # # # # # # # # # # # # # # # # # # # # # # #

mainMENU(){
    clear;
    echo -ne "
        $red==========================================$noc
        $red=====$noc$grn Nvidia and Cuda Setup for d101 $noc$red=====$noc
        $red==========================================$noc
        $red========== $noc$grn     MAIN MENU  $noc$red    ===========$noc
        $red==========================================$noc
        $red==$noc$ylw 1-Update, Upgrade, and Autoremove $noc$red   ==$noc
        $red==$noc$ylw 2-Install gcc-5 g++-5             $noc$red   ==$noc
        $red==$noc$ylw 3-Purge Old Nvidia Drivers        $noc$red   ==$noc
        $red==$noc$ylw 4-Install Nvidia 390 and Cuda 8.0 $noc$red   ==$noc
        $red==$noc$ylw 5-Install Supporting Programs     $noc$red   ==$noc
        $red==$noc$prp 6-PURGE PREVIOUS STEPS AND RESTART $noc$red  ==$noc
        $red==$noc$prp 7-QUIT                             $noc$red  ==$noc
        $red==========================================$noc";
        read -r ans1;
        while true; do 
            case $ans1 in
                1) step_1; mainMENU;;
                2) step_2; mainMENU;;
                3) step_3; mainMENU;;
                4) step_4; mainMENU;;
                5) step_5; mainMENU;;
                6) step_6; mainMENU;;
                7) exit 0;;
                *) echo -e "WRONG CHOICE"; sleep 3; mainMENU;;
            esac
        done
}


# # # # # # # # # # # # # # # # # # # # # # # # # #
#   EXTRA FUNCTIONS
# # # # # # # # # # # # # # # # # # # # # # # # # #

step_1(){
    clear;
    header1;
    echo -ne "
        $red=====$noc$red  Step 1 -$noc$ylw Updating Everything$noc$grn  =====$noc
    ";header1;
    sleep 3;
    pause;
        sudo apt update;
        sudo apt full-upgrade -y;
        sudo apt autoremove -y;
    footer1;
    pause;
}

step_2(){
    clear;
    header1;
    echo -ne "
        $red=====$noc$red   Step 2 -$noc$ylw Install Some Crap$noc$grn   =====$noc
        ";header1;
        sleep 3;
        sudo chmod ugo+rwx /etc/apt -R;
        sudo cp -f /etc/apt/sources.list /etc/apt/sources.list.bk;
        sudo cp -f /etc/apt/trusted.gpg /etc/apt/trusted.gpg.bk;
        sudo apt install -y p7zip-full p7zip-rar aptitude screen ubuntu-drivers-common timeshift net-tools;
        echo deb http://us.archive.ubuntu.com/ubuntu/ xenial main | sudo tee -a /etc/apt/sources.list;
         echo deb http://us.archive.ubuntu.com/ubuntu/ xenial universe | sudo tee -a /etc/apt/sources.list;
        sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 40976EAF437D05B5 3B4FE6ACC0B21F32;
        sudo apt-get update && sudo apt update; 
        sudo apt install gcc-5 g++-5 -y;
        sudo cp -f /etc/apt/sources.list.bk /etc/apt/sources.list;
        sudo cp -f /etc/apt/trusted.gpg.bk /etc/apt/trusted.gpg;
        sudo apt-key update;
        sudo apt-get update && sudo apt update;
        sudo timeshift --create --comments "Step2 Finsish"
        footer1;
    pause;
}

step_3(){
    clear;

    sudo nvidia-uninstall;
    sudo nvidia-installer --uninstall;
    sudo apt remove --purge '^nvidia-.*';
    pause;
}

step_4(){
    clear;
    pause;
}

step_5(){
    clear;
    pause;
}

step_6(){
    clear;
    pause;
}

header1(){
    clear;
    ehco -ne "
        $red==========================================$noc";
}

footer1(){
    echo -ne " $red=====$noc$ylw DONE$noc$red =====$noc"
}
# # # # # # # # # # # # # # # # # # # # # # # # # #
#   PROGRAM
# # # # # # # # # # # # # # # # # # # # # # # # # #