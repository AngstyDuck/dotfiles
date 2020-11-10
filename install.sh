#!/bin/bash

apt-get update


# install vim, openssh (so we can ssh into this instance)
apt-get install -y vim openssh-server curl tmux htop


# install pip and virtualenv
apt-get install -y python3-pip
sudo -u $USER pip3 install virtualenv


# install vim plugins
mkdir -p ~/.vim/pack/vendor/start

git clone git://github.com/ajh17/VimCompletesMe.git ~/.vim/pack/vendor/start/VimCompletesMe

git clone https://github.com/preservim/nerdtree.git ~/.vim/pack/vendor/start/nerdtree
vim -u NONE -c "helptags ~/.vim/pack/vendor/start/nerdtree/doc" -c q

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all
source ~/.bashrc

cp ./vimrc ~/.vimrc


./is_this_really_necessary.sh  # y e  s
