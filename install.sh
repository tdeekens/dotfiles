set -e

# Run Homebrew through the Brewfile
echo "› brew bundle .Brewfile"
brew bundle .Brewfile

# Run Homebrew through the Caskfile
echo "› brew bundle .Caskfile"
brew bundle .Caskfile

# Run setting up osx settings
echo "› ./.osx"
./.osx
