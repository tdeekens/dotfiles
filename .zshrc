# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

autoload -U compinit && compinit

ZSH_THEME="typewritten"
export TYPEWRITTEN_CURSOR="beam"
export TYPEWRITTEN_PROMPT_LAYOUT="singleline_verbose"
export TYPEWRITTEN_SYMBOL="»"

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

for file in ~/.{aliases,functions,keybindings}; do
  [ -r "$file" ] && source "$file"
done

# added by travis gem
[ -f /Users/tdeekens/.travis/travis.sh ] && source /Users/tdeekens/.travis/travis.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "`fnm env --multi --use-on-cd`"

export PATH="$HOME/.yarn/bin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/tdeekens/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/tdeekens/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/tdeekens/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/tdeekens/google-cloud-sdk/completion.zsh.inc'; fi

# opam configuration
test -r /Users/tdeekens/.opam/opam-init/init.zsh && . /Users/tdeekens/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
#__conda_setup="$('/usr/local/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
#if [ $? -eq 0 ]; then
#    eval "$__conda_setup"
#else
#    if [ -f "/usr/local/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
#        . "/usr/local/Caskroom/miniconda/base/etc/profile.d/conda.sh"
#    else
#        export PATH="/usr/local/Caskroom/miniconda/base/bin:$PATH"
#    fi
#fi
#unset __conda_setup
# <<< conda initialize <<<

