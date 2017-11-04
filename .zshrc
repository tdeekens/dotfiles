# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

ZSH_THEME="tdeekens"

autoload -U compinit && compinit

PURE_PROMPT_SYMBOL=»

plugins=()

source $ZSH/oh-my-zsh.sh

for file in ~/.{bash_profile,bash_prompt,exports}; do
  [ -r "$file" ] && source "$file"
done

unset file
unset MAILCHECK

if test -f ~/.gnupg/.gpg-agent-info -a -n "$(pgrep gpg-agent)"; then
  source ~/.gnupg/.gpg-agent-info
  export GPG_AGENT_INFO
else
  eval $(gpg-agent --daemon ~/.gnupg/.gpg-agent-info)
fi

source ~/.zplug

for file in ~/.{aliases,functions}; do
  [ -r "$file" ] && source "$file"
done

# added by travis gem
[ -f /Users/tdeekens/.travis/travis.sh ] && source /Users/tdeekens/.travis/travis.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
