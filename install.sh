set -e

# Run Homebrew through the Brewfile
echo "› brew bundle .Brewfile"
brew bundle

# Setting up some folder is need be
echo "› mkdir -p"
mkdir -p ~/.vim/colors
mkdir -p ~/.nvm

# Run setting up osx settings
echo "› ./.osx"
./.osx
