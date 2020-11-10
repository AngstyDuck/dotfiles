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

# install typora
wget -qO - https://typora.io/linux/public-key.asc | sudo apt-key add -
add-apt-repository 'deb https://typora.io/linux ./'
apt-get update
apt-get install typora

# install discord
snap install discord


./is_this_really_necessary.sh  # y e  s
