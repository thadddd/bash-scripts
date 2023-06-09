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

#usr=$(whoami)
#dir="/home/$usr/"
inst='sudo apt install -y'
suap='sudo apt'
suag='sudo apt-get'
su='sudo'
upda='sudo apt update'
line='echo -ne'


# # # # # # # # # # # # # # # # # # # # # # # # # #
#   TEXT COLORS
# # # # # # # # # # # # # # # # # # # # # # # # # #

#blk='\e[30m'
red='\e[31m'
grn='\e[32m'
ylw='\e[33m'
blu='\e[34m'
mag='\e[35m'
#cyn='\e[36m'
#gry='\e[37m'
noc='\e[0m'

# # # # # # # # # # # # # # # # # # # # # # # # # #
#   MENU FUNCTIONS
# # # # # # # # # # # # # # # # # # # # # # # # # #

mainMENU(){
    header1;
    echo -ne "
        $red=====$noc$grn Nvidia and Cuda Setup for d101 $noc$red=====$noc
        ";
        header2;
        echo -ne "
        $red========== $noc$grn     MAIN MENU  $noc$red    ===========$noc
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
        ";
        $line;
    header2;
                pause;
        $suap update;
                spacer;
                spacer;
        $suap full-upgrade -y;
                spacer;
                spacer;
        $suap autoremove -y;
                spacer;
                spacer;
        $inst p7zip-full p7zip-rar aptitude screen ubuntu-drivers-common timeshift net-tools dkms build-essential;
                spacer;
                spacer;
    $su timeshift --create --comment "Step1 Finish";
    footer1;
                pause;
}

step_2(){
    header1;
    echo -ne "
        $red==$noc$grn STEP 2 -$noc$ylw Install Some Crap        $noc$red   ==$noc
        ";
    header2;
                spacer;
                spacer;
    sleep 3;
        $su chmod ugo+rwx /etc/apt -R;
        $su mv -f sources.list.bk /etc/apt/sources.list.bk;
                spacer;
                spacer;
        echo deb http://us.archive.ubuntu.com/ubuntu/ xenial main | $su tee -a /etc/apt/sources.list;
        echo deb http://us.archive.ubuntu.com/ubuntu/ xenial universe | $su tee -a /etc/apt/sources.list;
            $su apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 40976EAF437D05B5 3B4FE6ACC0B21F32;
        $suag update && $suap update; 
                spacer;
                spacer;
        $inst gcc-5 g++-5;
                spacer;
                spacer;
            $su cp -f /etc/apt/sources.list.bk /etc/apt/sources.list;
            $su cp -f /etc/apt/trusted.gpg.bk /etc/apt/trusted.gpg;
            $su apt-key update;
                    $suag update && $suap update;
                spacer;
                spacer;
        cd /opt/ || return;
            $su mkdir gcc5;
        cd gcc5 || return;
            $su ln -s /usr/bin/gcc-5 gcc;
            $su ln -s /usr/bin/g++-5 g++;
                    export PATH=/opt/gcc5:$PATH;
            $su chmod ugo+rwx /etc/modprobe.d/ -R;
                    touch /etc/modprobe.d/blacklist-nouveau.conf;
        echo blacklist nouveau | $su tee -a /etc/modprobe.d/blacklist-nouveau.conf;
        echo options nouveau modeset=0 | $su tee -a /etc/modprobe.d/blacklist-nouveau.conf;
            $su update-initramfs -u;
                spacer;
                spacer;
            $su timeshift --create --comments "Step2 Finsish";
    footer1;
                pause;
}

step_3(){
    clear;
    header1;
    echo -e "
        $red==$noc$grn STEP 3 -$noc$ylw Purge Nvida drivers   4noc$red      ==$noc
    ";
    header2;
        $su nvidia-uninstall;
                spacer;
                spacer;
        $su nvidia-installer --uninstall;
                spacer;
                spacer;
        $suap remove --purge '^nvidia-.*';
                spacer;
                spacer;
        $su timeshift --create --comments "Step3 Finish";
    footer1;
                pause;
}

step_4(){
    header1;
    echo -e "$red==$noc$grn STEP 4 -$noc$ylw Install Nvidia and Cuda $noc$red    ==$noc";
    header2;
        $su service lightdm stop;
        $su service gdm3 stop;
        $su killall Xorg;
                spacer;
                spacer;
        $su ln -s /usr/bin/gcc-5 gcc;
        $su ln -s /usr/bin/g++-5 g++;
            export PATH=/opt/gcc5:$PATH;
        $su mkdir /home/cuda-8.0;
        $su mkdir /home/cuda-8.0/dl;
            $su chmod ugo+rwx /home -R;
            cd /home/cuda-8.0/dl || return;
    wget https://developer.nvidia.com/compute/cuda/8.0/Prod2/local_installers/cuda_8.0.61_375.26_linux-run;
    wget https://developer.nvidia.com/compute/cuda/8.0/Prod2/patches/2/cuda_8.0.61.2_linux-run;
        $su sh cuda_8.0.61_375.26_linux-run --tar mxvf;
        $su cp InstallUtils.pm /usr/lib/x86_64-linux-gnu/perl-base/;
                spacer;
                spacer;
        $su modprobe -r nouveau;
    #$inst nvidia-driver-390 nvidia-headless-390 nvidia-utils-390;
    #$su modprobe -i nvidia;
        $su sh cuda_8.0.61_375.26_linux-run --override;
                spacer;
                spacer;
                    sleep 2;
        $su sh cuda_8.0.61.2_linux-run;
        $su modprobe -i nvidia
                #$su aptitude build-dep nvidia-smi;
        $inst nvidia-smi;
        $su timeshift --create --comments "Step4 Finish";
    footer1;
                pause;
}

step_5(){
    header1;
    echo -e "
        $red==$noc$grn STEP 5 -$noc$ylw Install Support Programs $noc$red   ==$noc 
        ";
    header2;
        $su chmod ug+rwx /home -R;
        cd /home || return;
            $upda;
        $inst hashcat hashcat-nvidia;
                spacer;
                spacer;
        $inst mokutil;
                spacer;
                spacer;
        $inst libelf-dev;
                spacer;
                spacer;
        $inst wireshark;
                spacer;
                spacer;
        $su git clone https://github.com/ZerBea/hcxtools.git
            cd hcxtools || return;
            make; make install;
                spacer;
                spacer;
    hashcat -I;
                pause;
    hashcat -b;
                pause;
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
    echo -ne "$red==========================================$noc";
}

header2(){
    echo -ne "$red==========================================$noc";
    echo " ";
                pause;
}

footer1(){
    echo -ne "
    $red=====$noc$ylw DONE$noc$red =====$noc"
}

spacer(){
    echo -ne "$red==========================================$noc";
}
pause(){
                spacer;
    while read -r -t 0.001; do :; done # dump the buffer
        echo -e "$red" Press "$grn"any "$ylw"key "$mag"to "$blu"continue "$noc"
            read -n1 -rsp ' ';
                spacer;
}


# # # # # # # # # # # # # # # # # # # # # # # # # #
#   PROGRAM
# # # # # # # # # # # # # # # # # # # # # # # # # #

mainMENU