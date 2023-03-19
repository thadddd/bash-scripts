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
inst='sudo apt install -y'
suap='sudo apt'
suag='sudo apt-get'
su='sudo'
upda='sudo apt update'


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
    header1;
    echo -ne "
        $red=====$noc$grn Nvidia and Cuda Setup for d101 $noc$red=====$noc
        ";
        header2;
        echo -ne "$red========== $noc$grn     MAIN MENU  $noc$red    ===========$noc
        $red==$noc$ylw 1-Update, Upgrade, and Autoremove $noc$red   ==$noc
        $red==$noc$ylw 2-Install gcc-5 g++-5             $noc$red   ==$noc
        $red==$noc$ylw 3-Purge Old Nvidia Drivers        $noc$red   ==$noc
        $red==$noc$ylw 4-Install Nvidia 390 and Cuda 8.0 $noc$red   ==$noc
        $red==$noc$ylw 5-Install Supporting Programs     $noc$red   ==$noc
        $red==$noc$mag 6-PURGE PREVIOUS STEPS AND RESTART $noc$red  ==$noc
        $red==$noc$mag 7-QUIT                             $noc$red  ==$noc 
        " ; 
        header2;
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
                *) echo "WRONG CHOICE"; sleep 3; mainMENU;;
            esac
        done
}


# # # # # # # # # # # # # # # # # # # # # # # # # #
#   EXTRA FUNCTIONS
# # # # # # # # # # # # # # # # # # # # # # # # # #

step_1(){
    header1;
    echo -ne "
    $red==$noc$grn STEP 1 -$noc$ylw Update, Upgrade, Autoremove$noc$red ==$noc 
    " ;
    header2;
    sleep 3;
    pause;
        sudo apt update;
    header2;
        sudo apt full-upgrade -y;
    header2;
        sudo apt autoremove -y;
    header2;
        sudo apt install -y p7zip-full p7zip-rar aptitude screen ubuntu-drivers-common timeshift net-tools;
    header2;
    sudo timeshift --create --comment "Step1 Finish";
    footer1;
    pause;
}

step_2(){
    header1;
    echo -ne "
        $red==$noc$grn STEP 2 -$noc$ylw Install Some Crap        $noc$red   ==$noc
        ";
    header2;
    sleep 3;
        sudo chmod ugo+rwx /etc/apt -R;
        sudo cp -f /etc/apt/sources.list /etc/apt/sources.list.bk;
        sudo cp -f /etc/apt/trusted.gpg /etc/apt/trusted.gpg.bk;
    header2;
        echo deb http://us.archive.ubuntu.com/ubuntu/ xenial main | sudo tee -a /etc/apt/sources.list;
        echo deb http://us.archive.ubuntu.com/ubuntu/ xenial universe | sudo tee -a /etc/apt/sources.list;
        sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 40976EAF437D05B5 3B4FE6ACC0B21F32;
        sudo apt-get update && sudo apt update; 
    header2;
        sudo apt install gcc-5 g++-5 -y;
    header2;
        sudo cp -f /etc/apt/sources.list.bk /etc/apt/sources.list;
        sudo cp -f /etc/apt/trusted.gpg.bk /etc/apt/trusted.gpg;
        sudo apt-key update;
        sudo apt-get update && sudo apt update;
    header2;
        cd /opt/ || return;
        sudo mkdir gcc5;
        cd gcc5 || return;
        sudo ln -s /usr/bin/gcc-5 gcc;
        sudo ln -s /usr/bin/g++-5 g++;
        export PATH=/opt/gcc5:$PATH;
        sudo chmod ugo+rwx /etc/modprobe.d/ -R;
        touch /etc/modprobe.d/blacklist-nouveau.conf;
        echo blacklist nouveau | sudo tee -a /etc/modprobe.d/blacklist-nouveau.conf;
        echo options nouveau modeset=0 | sudo tee -a /etc/modprobe.d/blacklist-nouveau.conf;
        sudo update-initramfs -u;
    header2;
        sudo timeshift --create --comments "Step2 Finsish";
        footer1;
    pause;
}

step_3(){
    header1;
    echo -e "
        $red==$noc$grn STEP 3 -$noc$ylw Purge Nvida drivers   4noc$red      ==$noc
    ";
    header2;
    sudo nvidia-uninstall;
    header2;
    sudo nvidia-installer --uninstall;
    header2;
    sudo apt remove --purge '^nvidia-.*';
    header2;
    sudo timeshift --create --comments "Step3 Finish";
    footer1;
    pause;
}

step_4(){
    header1;
    echo -e "$red==$noc$grn STEP 4 -$noc$ylw Install Nvidia and Cuda $noc$red    ==$noc";
    header2;
    sudo service lightdm stop;
    sudo service gdm3 stop;
    sudo killall Xorg;
    header2;
    sudo ln -s /usr/bin/gcc-5 gcc;
    sudo ln -s /usr/bin/g++-5 g++;
    export PATH=/opt/gcc5:$PATH;
    sudo mkdir /home/cuda-8.0;
    sudo mkdir /home/cuda-8.0/dl;
    sudo chmod ugo+rwx /home -R;
    cd /home/cuda-8.0/dl || return;
    wget https://developer.nvidia.com/compute/cuda/8.0/Prod2/local_installers/cuda_8.0.61_375.26_linux-run;
    wget https://developer.nvidia.com/compute/cuda/8.0/Prod2/patches/2/cuda_8.0.61.2_linux-run;
    sudo sh cuda_8.0.61_375.26_linux-run --tar mxvf;
    sudo cp InstallUtils.pm /usr/lib/x86_64-linux-gnu/perl-base/;
    header2;
    sudo modprobe -r nouveau;
    #$inst nvidia-driver-390 nvidia-headless-390 nvidia-utils-390;
    #sudo modprobe -i nvidia;
    sh cuda_8.0.61_375.26_linux-run;
    header2; sleep 2;
    sudo sh cuda_8.0.61.2_linux-run;
    sudo modprobe -i nvidia
    #sudo aptitude build-dep nvidia-smi;
    $inst nvidia-smi;
    sudo timeshift --create --comments "Step4 Finish";
    footer1;
    pause;
}

step_5(){
    header1;
    echo -e "$red==$noc$grn STEP 5 -$noc$ylw Install Support Programs $noc$red   ==$noc 
    ";
    header2;
    $upda;
    $inst hashcat hashcat-nvidia;
    $inst mokutil;
    $inst build-essential;
    $inst libelf-dev;
    $inst wireshark;
    $inst hcxtools;
    hashcat -I;
    pause;
    hashcat -b;
    pause;
    sudo timeshift --create --comments "Step5 Finish" ;
    footer1;
    pause;
}

step_6(){
    clear;
    echo -ne "
        $red XXXXXXXXXXX NOT SETUP YET XXXXXXXXXXXXXX" ;
    pause;
}

header1(){
    clear;
    ehco -ne "
        $red==========================================$noc";
}

header2(){
    ehco -ne "
        $red==========================================$noc";
}

footer1(){
    echo -ne " $red=====$noc$ylw DONE$noc$red =====$noc"
}
# # # # # # # # # # # # # # # # # # # # # # # # # #
#   PROGRAM
# # # # # # # # # # # # # # # # # # # # # # # # # #