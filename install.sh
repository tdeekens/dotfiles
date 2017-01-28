set -e

# Run Homebrew through the Brewfile
echo "› brew bundle .Brewfile"
brew bundle

# Run setting up osx settings
echo "› ./.osx"
./.osx
