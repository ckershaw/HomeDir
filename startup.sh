#!/bin/bash

	sudo apt-get install git svn libxmu-dev libgsl0-dev libcv-dev libcvaux-dev libopencv-dev libopencv-dev libblas-dev libf2c2-dev liblapack-dev libeigen3-dev libsuitesparse-dev libatlas-base-dev libqhull-dev doxygen libxml2-dev libann-dev libboost-dev libboost-system-dev libboost-program-options-dev libdevil-dev libcurl4-nss-dev unity-tweak-tool gnome-tweak-tool synaptic compizconfig-settings-manager compiz-plugins-extra  ubuntu-restricted-extras gstreamer0.10-plugins-ugly gstreamer0.10-ffmpeg libxine1-ffmpeg gxine mencoder libdvdread4 totem-mozilla icedax tagtool easytag id3tool lame nautilus-script-audio-convert libmad0 mpg321 p7zip-rar p7zip-full unace unrar zip unzip sharutils rar uudeview mpack arj cabextract file-roller indicator-cpufreq indicator-multiload gksu

	scp maav_team@maaverick.engin.umich.edu:~/installGCS.sh ./
    ./installGCS.sh

    cd iarc/
    git remote add ckershaw caen:Public/iarc.git
    git fetch ckershaw
    git remote add jbendes caen:/afs/umich.edu/user/j/b/jbendes/Public/iarc.git
    git fetch jbendes 
    git remote add isaac maav_team@maaverick.engin.umich.edu:repo/isaac/iarc.git
    git fetch isaac


    svn co https://robots.engin.umich.edu/svn/perls/branches/neec perls-neec
    cd perls-neec/third-party/
    ./perls-essentials

    gsettings set com.canonical.desktop.interface scrollbar-mode normal
    gsettings set com.canonical.indicator.session show-real-name-on-panel true

    sudo echo "enable=0" >  /etc/default/apport

    sudo apt-get autoremove unity-lens-music unity-lens-photos unity-lens-gwibber unity-lens-video unity-lens-shopping
     
    sudo apt-get upgrade

    cd
    cp scripts/.mybashrc ./
    cp scripts/.gitconfig ./
    cp scripts/.vimrc ./
    cp scripts/.ssh ./
    sudo cp /etc/NetworkManager/NetworkManager.conf /etc/NetworkManager/Unmanaged.conf
    sudo mv /etc/NetworkManager/NetworkManager.conf /etc/NetworkManager/Managed.conf
    sudo ln -s /etc/NetworkManager/Managed.conf /etc/NetworkManager/NetworkManager.conf
    sudo network-manager restart

    echo "you still need to run installGCS"
    echo "you still need to merge iarc git"
    echo "you still need to ant iarc"
    echo "you still need build third party"
    echo "you still need build perls"
