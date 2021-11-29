#!/bin/bash

echo "Installing homebrew"

sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "Setting up vim colors"
wget --quiet https://raw.githubusercontent.com/altercation/vim-colors-solarized/master/colors/solarized.vim > ~/.vim/colors/solarized.vim

echo "Installing zinit"
sh -c "$(curl -fsSL https://git.io/zinit-install)"

echo "Installing Brewfiles"
brew bundle --file ~/.brewfiles/Development
brew bundle --file ~/.brewfiles/Casks

echo "Installing fzf"
$(brew --prefix)/opt/fzf/install
