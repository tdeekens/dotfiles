#!/usr/bin/env bash

DOTFILES_ROOT=$(pwd -P)
DOTFILES=(.aliases .bash_prompt .bashrc .curlrc .editorconfig .exports .zshrc .zinitrc .gitattributes .gitconfig .gitignore .inputrc .oh-my-zsh/plugins/umsicht.plugin.zsh .osx .vimrc .wgetrc Brewfile .bin .keybindings)
DOTFILES_ROOT=$(pwd -P)

set -e

echo ''

info () {
  printf "\r  [ \033[00;34m..\033[0m ] $1\n"
}

user () {
  printf "\r  [ \033[0;33m??\033[0m ] $1\n"
}

success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
  echo ''
  exit
}

setup_gitconfig () {
  if ! [ -f git/gitconfig.local.symlink ]
  then
    info 'setup gitconfig'

    git_credential='cache'
    if [ "$(uname -s)" == "Darwin" ]
    then
      git_credential='osxkeychain'
    fi

    user ' - What is your github author name?'
    read -e git_authorname
    user ' - What is your github author email?'
    read -e git_authoremail

    sed -e "s/AUTHORNAME/$git_authorname/g" -e "s/AUTHOREMAIL/$git_authoremail/g" -e "s/GIT_CREDENTIAL_HELPER/$git_credential/g" git/gitconfig.local.symlink.example > git/gitconfig.local.symlink

    success 'gitconfig'
  fi
}


link_file () {
  local src=$1 dst=$2

  local overwrite= backup= skip=
  local action=

  if [ -f "$dst" -o -d "$dst" -o -L "$dst" ]
  then

    if [ "$overwrite_all" == "false" ] && [ "$skip_all" == "false" ]
    then

      local currentSrc="$(readlink $dst)"

      if [ "$currentSrc" == "$src" ]
      then

        skip=true;

      else

        user "File already exists: $dst ($(basename "$src")), what do you want to do?\n\
        [s]kip, [S]kip all, [o]verwrite, [O]verwrite all?"
        read -n 1 action

        case "$action" in
          o )
            overwrite=true;;
          O )
            overwrite_all=true;;
          s )
            skip=true;;
          S )
            skip_all=true;;
          * )
            ;;
        esac

      fi

    fi

    overwrite=${overwrite:-$overwrite_all}
    skip=${skip:-$skip_all}

    if [ "$overwrite" == "true" ]
    then
      rm -rf "$dst"
      success "removed $dst"
    fi

    if [ "$skip" == "true" ]
    then
      success "skipped $src"
    fi
  fi

  if [ "$skip" != "true" ]  # "false" or empty
  then
    ln -s "$1" "$2"
    success "linked $1 to $2"
  fi
}

install_dotfiles () {
  info 'installing dotfiles'

  local overwrite_all=false backup=false skip_all=false

  user "Want to [b]ackup all .dotfiles?"
  read -n 1 action

  case "$action" in
    b )
      backup=true;;
    * )
      ;;
  esac

  if [ "$backup" == "true" ]
  then
    ARCHIVE=( "${DOTFILES[@]/#/$HOME/}" )
    tar -cvzf $HOME/.dotfiles-$(date '+%y-%m-%d').tar.gz "${ARCHIVE[@]}" &>/dev/null
    success "backed up all in .dotfiles-$(date '+%y-%m-%d').tar.gz"
  fi

  for src in  "${DOTFILES[@]}"
  do
    dst="$HOME/$src"
    src="$DOTFILES_ROOT/$src"
    link_file "$src" "$dst"
  done
}

install_dotfiles

chmod +x .bin/*

echo ''
echo '  All installed!'
