#!/bin/sh
# install nodejs and npm online

# typescript
sudo npm install -g typescript

# linting for js and tsc
sudo npm install eslint --global

# install nodejs version manager npm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# install typescript version manager tvm
sudo npm install -g tvm

# install mongodb
brew install mongodb-community@5.0
