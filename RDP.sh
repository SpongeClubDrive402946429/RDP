#! /bin/bash
printf "Installing RDP Be Patience... " >&2
{
sudo useradd -m USER
sudo adduser USER sudo
echo 'USER' | sudo chpasswd
sed -i 's/\/bin\/sh/\/bin\/bash/g' /etc/passwd
sudo apt-get update
wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb
sudo dpkg --install chrome-remote-desktop_current_amd64.deb
sudo apt install --assume-yes --fix-broken
sudo DEBIAN_FRONTEND=noninteractive \
apt install --assume-yes xfce4 desktop-base
sudo bash -c 'echo "exec /etc/X11/Xsession /usr/bin/xfce4-session" > /etc/chrome-remote-desktop-session'  
sudo apt install --assume-yes xscreensaver
sudo systemctl disable lightdm.service
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg --install google-chrome-stable_current_amd64.deb
sudo apt install --assume-yes --fix-broken
sudo apt install nautilus nano xarchiver software-properties-common -y 
sudo adduser USER chrome-remote-desktop
sudo apt autoremove --purge ffmpeg -y
sudo mkdir -p /opt/ffmpeg
cd /opt/ffmpeg
sudo wget -c https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-amd64-static.tar.xz
sudo tar xvf ffmpeg-release-amd64-static.tar.xz
cd ffmpeg-4.3.1-amd64-static/
sudo ln -s "${PWD}/ffmpeg" /usr/local/bin/
sudo ln -s "${PWD}/ffprobe" /usr/local/bin/
sudo add-apt-repository ppa:jd-team/jdownloader -y
sudo apt-get update
sudo apt-get install jdownloader-installer -y
} &> /dev/null &&
printf "\nSetup Complete " >&2 ||
printf "\nError Occured " >&2
printf '\nCheck https://remotedesktop.google.com/headless  Copy Command Of Debian Linux And Paste Down\n'
read -p "Paste Here: " CRP
su - USER -c """$CRP"""
printf 'Check https://remotedesktop.google.com/access/ \n\n'
if sudo apt-get upgrade &> /dev/null
then
    printf "\n\nUpgrade Completed " >&2
else
    printf "\n\nError Occured " >&2
fi
