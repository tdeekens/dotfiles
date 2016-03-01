# tdeekens.zsh-theme

if [ $UID -eq 0 ]; then NCOLOR="red"; else NCOLOR="green"; fi
local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

# git settings
ZSH_THEME_GIT_PROMPT_SUFFIX="$FG[075])%{$reset_color%}"

# primary prompt
#PROMPT='$FG[237]------------------------------------------------------------%{$reset_color%}
PROMPT='%{$FG[245]%}!%!%  %{$FG[237]%}%D{[%H:%M]}%{$fg[cyan]%}%p %c %{$fg_bold[cyan]%}%(!.#.»)%{$reset_color%} '

RPS1='${return_code}'

# right prompt
RPROMPT='$FG[237]%n@%m%{$reset_color%}%'
