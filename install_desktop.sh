#!/bin/bash

# install bluelight filter
apt-get install -y redshift-gtk

# install telegram desktop
add-apt-repository -y ppa:atareao/telegram
apt update && apt install -y telegram

# install keepassxc
apt install -y keepassxc

# install spotify
curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | apt-key add -
echo "deb http://repository.spotify.com stable non-free" | tee /etc/apt/sources.list.d/spotify.list
apt-get update && apt-get install -y spotify-client

# install ghostwriter
sudo add-apt-repository -y ppa:wereturtle/ppa
sudo apt update
sudo apt install -y ghostwriter

# install discord
snap install discord

# install slack
cd ~/Desktop
wget https://downloads.slack-edge.com/linux_releases/slack-desktop-4.0.2-amd64.deb
sudo apt install -y ./slack-desktop-*.deb
rm ./slack-desktop-*.deb


./is_this_really_necessary.sh  # y e  s
