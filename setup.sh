#!/bin/bash

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

wget --quiet https://raw.githubusercontent.com/altercation/vim-colors-solarized/master/colors/solarized.vim > ~/.vim/colors/solarized.vim
pyenv install 3.5.0
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"

brew bundle

$(brew --prefix)/opt/fzf/install
