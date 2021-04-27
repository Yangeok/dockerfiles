# Using centos

# Using ubuntu

# Install nimf
sudo apt-get install python-software-properties
sudo apt-get install software-properties-common
udo add-apt-repository ppa:hodong/nimf

# Install desktop
udo apt-get update
sudo apt-get install ubuntu-desktop
startx

# Install xrdp
sudo apt-get install xrdp 
sudo apt-get install xorgxrdp-hwe-18.04
sudo apt-get install mate-core mate-desktop-environment mate-notification-daemon
service xrdp start

# Install timezone
sudo dpkg-reconfigure tzdata