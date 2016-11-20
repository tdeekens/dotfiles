# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.

ZSH_THEME="purity"

autoload -U promptinit && promptinit

PURE_PROMPT_SYMBOL=»

prompt purity

# Example aliass
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)

plugins=(sublime gitfast brew brew-cask thefuck autojump osx umsicht history-search-multi-word bower autojump nvm jira zsh-syntax-highlighting nvm-auto-use git-it-on)

source $ZSH/oh-my-zsh.sh

for file in ~/.{.bash_profile,bash_prompt,exports,aliases,functions}; do
  [ -r "$file" ] && source "$file"
done

unset file
unset MAILCHECK

HOMEBREW_CASK_OPTS="--appdir=/Applications"

[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh

source ~/.nvm/nvm.sh

# added by travis gem
[ -f /Users/tdeekens/.travis/travis.sh ] && source /Users/tdeekens/.travis/travis.sh

eval "$(thefuck --alias)"

if test -f ~/.gnupg/.gpg-agent-info -a -n "$(pgrep gpg-agent)"; then
  source ~/.gnupg/.gpg-agent-info
  export GPG_AGENT_INFO
else
  eval $(gpg-agent --daemon --write-env-file ~/.gnupg/.gpg-agent-info)
fi

# OPAM configuration
. /Users/tdeekens/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

source ~/.oh-my-zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# OPAM configuration
. /Users/tdeekens/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
