#!/bin/sh
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew update

# install vim, openssh (so we can ssh into this instance)
brew install tmux htop

# install vim plugins
# vim plugin manager
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

mkdir -p ~/.vim/pack/vendor/start
git clone git://github.com/ajh17/VimCompletesMe.git ~/.vim/pack/vendor/start/VimCompletesMe
git clone https://github.com/preservim/nerdtree.git ~/.vim/pack/vendor/start/nerdtree
vim -u NONE -c "helptags ~/.vim/pack/vendor/start/nerdtree/doc" -c q

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all
source ~/.bashrc

git clone https://github.com/mileszs/ack.vim.git ~/.vim/pack/vendor/start/ack.vim
brew install ripgrep
git clone https://github.com/christoomey/vim-tmux-navigator.git ~/.vim/pack/plugins/start/vim-tmux-navigator
git clone --depth 1 https://github.com/dense-analysis/ale.git ~/.vim/pack/git-plugins/start/ale

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

cp $DIR/../../vimrc ~/.vimrc
cp $DIR/../../tmux.conf ~/.tmux.conf
cp $DIR/../../gitconfig ~/.gitconfig

exec "$SHELL"
echo 'AngstyDuck recommends restarting all shells with `exec "$SHELL"` to ensure your shells have the newly installed packages uwu <3'
./is_this_really_necessary.sh  # y e  s


# Additional configurations
# tmux have problems resizing on MacOS
# fix with this: https://superuser.com/questions/660013/resizing-pane-is-not-working-for-tmux-on-mac
