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
git clone https://github.com/christoomey/vim-tmux-navigator.git ~/.vim/pack/plugins/start/vim-tmux-navigator

# install tmux plugins
mkdir ~/.tmux_plugins
# yanking was buggy so i removed it for now
# git clone https://github.com/tmux-plugins/tmux-yank ~/.tmux_plugins/tmux-yank
# git clone https://github.com/tmux-plugins/tmux-copycat ~/.tmux_plugins/tmux-copycat
git clone https://github.com/tmux-plugins/tmux-resurrect ~/.tmux_plugins/tmux-resurrect
git clone https://github.com/tmux-plugins/tmux-continuum ~/.tmux_plugins/tmux-continuum
git clone https://github.com/christoomey/vim-tmux-navigator.git ~/.tmux_plugins/vim-tmux-navigator
# install tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

cp $DIR/vimrc ~/.vimrc
cp $DIR/tmux.conf ~/.tmux.conf
cp $DIR/gitconfig ~/.gitconfig

# ssh key gen
mkdir ~/.ssh
ssh-keygen -t ed25519 -C "solsticedante@gmail.com" -f ~/.ssh/github -N "" -q
ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa -q

echo "New pub sshkey for github:"
cat ~/.ssh/github.pub
echo "New pub sshkey for ssh:"
cat ~/.ssh/id_rsa.pub

# install pyenv to manage multiple python versions
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
echo '# for installing pyenv\n# ref: https://github.com/pyenv/pyenv#installation' >> ~/.bashrc
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.bashrc


exec "$SHELL"
echo 'AngstyDuck recommends restarting all shells with `exec "$SHELL"` to ensure your shells have the newly installed packages :3'
./is_this_really_necessary.sh  # y e  s
