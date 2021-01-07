#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

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

git clone https://github.com/mileszs/ack.vim.git ~/.vim/pack/vendor/start/ack.vim

apt-get install -y ripgrep

cp $DIR/vimrc ~/.vimrc
cp $DIR/gitconfig ~/.gitconfig

# ssh key gen
mkdir ~/.ssh
ssh-keygen -t ed25519 -C "solsticedante@gmail.com" -f ~/.ssh/github -N "" -q
ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa -q

echo "New pub sshkey for github:"
cat ~/.ssh/github.pub
echo "New pub sshkey for ssh:"
cat ~/.ssh/id_rsa.pub


./is_this_really_necessary.sh  # y e  s
