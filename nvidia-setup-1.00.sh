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
sapt='sudo apt-get'
inst='sudo apt-get install -y'
#dir='/home/$USER'

# # # # # # # # # # # # # # # # # # # # # # # # # #
#   TEXT COLORS
# # # # # # # # # # # # # # # # # # # # # # # # # #

red='\033[0;31m'
grn='\033[0;32m'
ylw='\033[1;33m'
prp='\033[0;35m'
#blk='\033[0;30m'
blu='\033[0;34m'
noc='\033[0m'

# # # # # # # # # # # # # # # # # # # # # # # # # #
#   FUNCTIONS FOR EACH STEP
# # # # # # # # # # # # # # # # # # # # # # # # # #

step_1(){
    update_dist;
    pause;
    echo -e "$blu" Installing gcc-5 and 7z.... "$noc";
    pause;
    $inst p7zip-full p7zip-rar aptitude screen;
    pause;
    sudo cp -f /etc/apt/sources.list /etc/apt/sources.list.bk;
    sudo cp -f -R /etc/apt/trusted.gpg.d /etc/apt/trusted.gpg.d.bk;
    pause;
    echo deb http://us.archive.ubuntu.com/ubuntu/ xenial main | sudo tee -a /etc/apt/sources.list;
    pause;
    echo deb http://us.archive.ubuntu.com/ubuntu/ xenial universe | sudo tee -a /etc/apt/sources.list;
    pause;
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 40976EAF437D05B5 3B4FE6ACC0B21F32;
    pause;
    sudo apt update; 
    pause;
    sudo apt install gcc-5 g++-5;
    pause;
    sudo mv -f /etc/apt/sources.list.bk /etc/apt/sources.list;
    sudo mv -f -R /etc/apt/trusted.gpg.d.bk /etc/apt/trusted.gpg.d;
    sudo rm -f /etc/apt/trusted.gpg;
    pause;
    sudo apt-key update;
    pause;
    update_dist;
    pause;
    echo -e "$blu" Removing old Nvidia and Cuda drivers.... "$noc";
    pause;
    sudo nvidia-uninstall;
    pause;
    sudo nvidia-installer --uninstall;
    pause;
    $sapt remove --purge '^nvidia-.*';
    pause;
    update_dist;
    pause;
    while true; do
        echo -e "$red" Need to reboot. '\n'
        read -p "Do you want to do it now? y/n" -n 1 yn1 -r
            case $yn1 in
                [yY]) reboot;;
                [nN]) menu;;
                *) echo -e "Wrong answer"; menu;;
            esac
    done   
}

step_2(){
    echo -e "$blu" Creating gcc file paths.... "$noc";
    pause;
        sleep 3;
    cd /opt/ || return;
    pause;
    sudo mkdir gcc5;
    pause;
    cd gcc5 || return;
    pause;
    sudo ln -s /usr/bin/gcc-5 gcc;
    pause;
    sudo ln -s /usr/bin/g++-5 g++;
    pause;
    export PATH=/opt/gcc5:$PATH;
    pause;
    echo -e "$blu" Blacklisting Nouveau Kernal.... "$noc";
        sleep 3;
    pause;
    echo blacklist nouveau | tee -a /etc/modprobe.d/blacklist-nouveau.conf;
    pause;
    echo options nouveau modeset=0 | tee -a /etc/modprobe.d/blacklist-nouveau.conf;
    pause;
        echo -e "$ylw" Need to update initramfs "$noc";
        pause;
    sudo update-initramfs -u;
    pause;
    echo -e "$prp"   CHECK FOR NOUVEAU CORRECTLY BLACKLISTED  "$noc";
    lsmod | grep nouveau;
        pause;
    while true; do
        echo -e "$red" Press Ctrl + Alt + F1 to boot into tty mode... '\n';
        read -p $'Are you ready? y/n' -n 1 -r yn2 ;
        echo -e "$noc" ;
            case $yn2 in   
                [yY]) echo 'then you shouldnt see this';
                menu;;
                [nN]) echo 'fuck you then dickhole';
                menu;;
                *) menu;;
            esac
        done
}

step_3(){
    echo -e "$blu" Downloading Nvidia and Cuda versions.... "$noc";
        sleep 3;
    sudo service lightdm stop;
    pause;
    sudo service gdm3 stop;
    pause;
    sudo killall Xorg;
    pause;
    cd /tmp/ || return;
    pause;
    wget https://developer.nvidia.com/compute/cuda/8.0/Prod2/local_installers/cuda_8.0.61_375.26_linux-run;
    pause;
    wget https://developer.nvidia.com/compute/cuda/8.0/Prod2/patches/2/cuda_8.0.61.2_linux-run;
    pause;
    sudo sh cuda_8.0.61_375.26_linux-run --tar mxvf;
    pause;
    sudo cp InstallUtils.pm /usr/lib/x86_64-linux-gnu/perl-base/;
    pause;
    driver_ver;
    pause;
    sudo sh cuda_8.0.61.2_linux-run;
    pause;
    $inst nvidia-smi;
    pause;        
    menu;
}

step_4(){
    echo -e "$grn" Installing stuff  "$noc";
        sleep 3;
    update_dist;
    $inst hashcat hashcat-nvidia;
    $inst git;
    $inst net-tools;lightdm
    $inst mokutil;
    $inst build-essential;
    $inst libelf-dev;
    $inst wireshark;
    hashcat -I;
    pause;
    hashcat -b;
    pause;
    menu;
}


menu(){
    echo -ne "
        $red $usr $grn Installer MENU: $noc
        $ylw 1. Updating and Installing gcc-5
        $ylw 2. Gcc install and Nouveau blacklist 
        $ylw 3. Download and install Nvidia and Cuda NEEDS TTY
        $ylw 4. Install support programs
        $ylw 5. Quit " "$noc"
        read -r ans1
      case $ans1 in
                1) step_1; menu;;
                2) step_2; menu;;
                3) step_3; menu;;
                4) step_4; menu;;
                5) exit 0;;
                *) echo -e "$red""Wrong Selection.""$noc"; menu;;
            esac
}

# # # # # # # # # # # # # # # # # # # # # # # # # #
#   ACTION FUNCTIONS
# # # # # # # # # # # # # # # # # # # # # # # # # #

update_dist(){
    echo -e "$grn" Update and Upgrade in Progress "$noc";
        sleep 1;
    sudo apt update
    sudo apt full-upgrade -y;
    sudo apt autoremove -y;
}

pause(){
    while read -r -t 0.001; do :; done # dump the buffer
        echo -e "$red" Press "$grn"any "$ylw"key "$prp"to continue "$noc"
            read -n1 -rsp 
}

driver_ver(){
    while true; do
        echo -e "$ylw" Which driver to install... "$noc";
        echo -e "$blu" 1  Nvidia 390 "$noc";
        echo -e "$blu" 2  Nvidia 375 "$noc";
        echo -e "$red" 3  GO BACK "$noc";
            read -r drive;
            case $drive in 
                1) sudo apt install ubuntu-drivers-common -y; sudo ubuntu-drivers install -y;;
                2) sudo sh cuda_8.0.61_375.26_linux-run;;
                3) exit 0;;
                *) "$red" WTF IS THIS "$noc"; driver_ver;;
            esac
        done
}

# # # # # # # # # # # # # # # # # # # # # # # # # #
#   PRE-RUN NEEDS
# # # # # # # # # # # # # # # # # # # # # # # # # #
sudo cp -f -R /etc/apt /etc/apt.bk
sudo chmod ugo+rwx /etc/apt/sources.list -R
sudo chmod ugo+rwx /home/ -R

# # # # # # # # # # # # # # # # # # # # # # # # # #
#   ACTUAL RUN OF PROGRAM
# # # # # # # # # # # # # # # # # # # # # # # # # #

menu