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
    sudo cp -f -r /etc/apt /etc/apt.bk;
    update_dist;
    echo -e "$blu" Installing gcc-5 and 7z.... "$noc";
    $inst p7zip-full p7zip-rar aptitude screen ubuntu-drivers-common net-tools -y;
    sudo cp -f /etc/apt/sources.list /etc/apt/sources.list.bk;
    sudo cp -f -R /etc/apt/trusted.gpg.d /etc/apt/trusted.gpg.d.bk;
    echo deb http://us.archive.ubuntu.com/ubuntu/ xenial main | sudo tee -a /etc/apt/sources.list;
    echo deb http://us.archive.ubuntu.com/ubuntu/ xenial universe | sudo tee -a /etc/apt/sources.list;
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 40976EAF437D05B5 3B4FE6ACC0B21F32;
    sudo apt update; 
    sudo apt install gcc-5 g++-5 -y;
    sudo mv -f /home/bash-scripts/sources.list.bk /etc/apt/sources.list;
    sudo mv -f /etc/apt/trusted.gpg.d.bk /etc/apt/trusted.gpg.d;
    sudo rm -f /etc/apt/trusted.gpg;
    sudo apt-key update;
    update_dist;
    echo -e "$blu" Removing old Nvidia and Cuda drivers.... "$noc";
    sudo nvidia-uninstall;
    sudo nvidia-installer --uninstall;
    $sapt remove --purge '^nvidia-.*';
    update_dist;
    sudo timeshift --create --comments "Fishishing step 1";
    while true; do
        echo -ne "
            $red xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
            $red     Continue to step 2? y/n
            $red xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
            $red    "
            read -r yn1
            case $yn1 in
                [yY]) step_2;;
                [nN]) menu;;
                *) echo -e "Wrong answer"; menu;;
            esac
    done   
}

step_2(){
    echo -e "$blu" Creating gcc file paths.... "$noc";
        sleep 1;
    cd /opt/ || return;
    sudo mkdir gcc5;
    cd gcc5 || return;
    sudo ln -s /usr/bin/gcc-5 gcc;
    sudo ln -s /usr/bin/g++-5 g++;
    export PATH=/opt/gcc5:$PATH;
    echo -e "$blu" Blacklisting Nouveau Kernal.... "$noc";
        sleep 1;
    echo blacklist nouveau | sudo tee -a /etc/modprobe.d/blacklist-nouveau.conf;
    echo options nouveau modeset=0 | sudo tee -a /etc/modprobe.d/blacklist-nouveau.conf;
        echo -e "$ylw" Need to update initramfs "$noc";
    sudo update-initramfs -u;
    echo -e "$prp"   CHECK FOR NOUVEAU CORRECTLY BLACKLISTED  "$noc";
    lsmod | grep nouveau;
    sudo timeshift --create --comments "Fishishing step 2";
    while true; do
        echo -ne "
            $red xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
            $red Continue to step 3 or Reboot y/n/r
            $red xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
            $red    "
            read -r yn1
            case $yn1 in
                [yY]) step_3;;
                [nN]) menu;;
                [rR]) reboot;;
                *) echo -e "Wrong answer"; menu;;
            esac
    done 
}

step_3(){
    echo -e "$blu" Downloading Nvidia and Cuda versions.... "$noc";
        sleep 1;
    sudo service lightdm stop;
    sudo service gdm3 stop;
    sudo killall Xorg;
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
    pause;
    sudo modprobe -r nouveau;
    #$inst nvidia-driver-390 nvidia-headless-390 nvidia-utils-390;
    #sudo modprobe -i nvidia;
    pause;
    sh cuda_8.0.61_375.26_linux-run;
    pause;
    sudo sh cuda_8.0.61.2_linux-run;
    sudo modprobe -i nvidia
    pause;
    source;
    sudo aptitude build-dep nvidia-smi;
    $inst nvidia-smi;
    pause;        
    sudo timeshift --create --comments "Fishishing step 3";
    while true; do
        echo -ne "
            $red xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
            $red     Continue to step 4? y/n
            $red xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
            $red    "
            read -r yn1
            case $yn1 in
                [yY]) step_4;;
                [nN]) menu;;
                *) echo -e "Wrong answer"; menu;;
            esac
    done 
}

step_4(){
    echo -e "$grn" Installing stuff  "$noc";
        sleep 1;
    update_dist;
    #sudo git clone https://github.com/hashcat/hashcat.git;
    #cd hashcat || return;
    #make;
    #make install;
    $inst hashcat hashcat-nvidia;
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
    clear;
    echo -ne "
        $red $usr $grn Installer MENU: $noc
        $ylw 1. Updating and Installing gcc-5
        $ylw 2. Gcc config and Nouveau blacklist 
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
        echo -e "$red" Press "$grn"any "$ylw"key "$prp"to "$blu"continue "$noc"
            read -n1 -rsp ' '
}
     

driver_ver(){
    while true; do
        echo -e "$ylw" Which driver to install... "$noc";
        echo -e "$blu" 1  Nvidia 390 "$noc";
        echo -e "$blu" 2  Nvidia 375 "$noc";
        echo -e "$red" 3  GO BACK "$noc";
            read -r drive;
            case $drive in 
                1) sudo sh cuda_8.0.61_375.26_linux-run; 
                sudo ubuntu-drivers install; 
                break;;
                2) sudo sh cuda_8.0.61_375.26_linux-run; 
                break;;
                3) break;;
                *) "$red" WTF IS THIS "$noc"; 
                driver_ver;;
            esac
        done
}

source(){
    clear;
    echo -e "$red" Remaking sources.list "$noc";
    sudo chmod ugo+rwx /etc/apt -R;
    rm -f /etc/apt/sources.list;
    touch /etc/apt/sources.list;
    echo deb http://us.archive.ubuntu.com/ubuntu bionic main restricted | sudo tee -a /etc/apt/sources.list;
    echo deb-src http://us.archive.ubuntu.com/ubuntu bionic main restricted | sudo tee -a /etc/apt/sources.list;
    echo deb http://us.archive.ubuntu.com/ubuntu bionic-updates main restricted | sudo tee -a /etc/apt/sources.list;
    echo deb-src http://us.archive.ubuntu.com/ubuntu bionic-updates main restricted | sudo tee -a /etc/apt/sources.list;
    echo deb http://us.archive.ubuntu.com/ubuntu bionic universe | sudo tee -a /etc/apt/sources.list;
    echo deb-src http://us.archive.ubuntu.com/ubuntu bionic universe | sudo tee -a /etc/apt/sources.list;
    echo deb http://us.archive.ubuntu.com/ubuntu bionic-updates universe | sudo tee -a /etc/apt/sources.list;
    echo deb-src http://us.archive.ubuntu.com/ubuntu bionic-updates universe | sudo tee -a /etc/apt/sources.list;
    echo deb http://us.archive.ubuntu.com/ubuntu bionic multiverse | sudo tee -a /etc/apt/sources.list;
    echo deb-src http://us.archive.ubuntu.com/ubuntu bionic multiverse | sudo tee -a /etc/apt/sources.list;
    echo deb http://us.archive.ubuntu.com/ubuntu bionic-updates multiverse | sudo tee -a /etc/apt/sources.list;
    echo deb-src http://us.archive.ubuntu.com/ubuntu bionic-updates multiverse | sudo tee -a /etc/apt/sources.list;
    echo deb http://us.archive.ubuntu.com/ubuntu bionic-backports main restricted universe multiverse | sudo tee -a /etc/apt/sources.list;
    echo deb-src http://us.archive.ubuntu.com/ubuntu bionic-backports main restricted universe multiverse | sudo tee -a /etc/apt/sources.list;
    echo deb http://us.archive.ubuntu.com/ubuntu bionic-security main restricted | sudo tee -a /etc/apt/sources.list;
    echo deb-src http://us.archive.ubuntu.com/ubuntu bionic-security main restricted | sudo tee -a /etc/apt/sources.list;
    echo deb http://us.archive.ubuntu.com/ubuntu bionic-security universe | sudo tee -a /etc/apt/sources.list;
    echo deb-src http://us.archive.ubuntu.com/ubuntu bionic-security universe | sudo tee -a /etc/apt/sources.list;
    echo deb http://us.archive.ubuntu.com/ubuntu bionic-security multiverse | sudo tee -a /etc/apt/sources.list;
    echo deb-src http://us.archive.ubuntu.com/ubuntu bionic-security multiverse | sudo tee -a /etc/apt/sources.list;
}
# # # # # # # # # # # # # # # # # # # # # # # # # #
#   PRE-RUN NEEDS
# # # # # # # # # # # # # # # # # # # # # # # # # #
sudo chmod ugo+rwx /etc/apt/sources.list -R
sudo chmod ugo+rwx /home/ -R
sudo apt install -y timeshift
#sudo timeshift --create --comment "before nvidia" --verbose

# # # # # # # # # # # # # # # # # # # # # # # # # #
#   ACTUAL RUN OF PROGRAM
# # # # # # # # # # # # # # # # # # # # # # # # # #

menu