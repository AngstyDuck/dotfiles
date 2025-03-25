#!/bin/sh
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew update

# install vim, openssh (so we can ssh into this instance)
brew install tmux htop

# install tmux plugins
mkdir ~/.tmux_plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm # install tmux plugin manager

# move config files
mkdir -p ~/.config/nvim
cp $DIR/../../neovim.lua ~/.config/nvim/init.lua
cp $DIR/../../tmux.conf ~/.tmux.conf
cp $DIR/../../gitconfig ~/.gitconfig

# set up symlinks
ln -s $(which nvim) /usr/local/bin/n

exec "$SHELL"
echo 'AngstyDuck recommends restarting all shells with `exec "$SHELL"` to ensure your shells have the newly installed packages uwu <3'
./is_this_really_necessary.sh  # y e  s

# Additional configurations
# tmux have problems resizing on MacOS
# fix with this: https://superuser.com/questions/660013/resizing-pane-is-not-working-for-tmux-on-mac
