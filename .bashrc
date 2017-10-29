[ -n "$PS1" ] && source ~/.zshrc
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# added by travis gem
source ~/.travis/travis.sh

export NVM_DIR="~/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# added by travis gem
[ -f /Users/tdeekens/.travis/travis.sh ] && source /Users/tdeekens/.travis/travis.sh
