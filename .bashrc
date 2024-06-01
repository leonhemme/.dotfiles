#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '


### PATH ###
if [ -d "$HOME/.bin" ] ;
  then PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/Applications" ] ;
  then PATH="$HOME/Applications:$PATH"
fi


# Ignore case for tab completion
bind "set completion-ignore-case on"


### FUNCTIONS ###
# Archive extraction
# Usage: ex <file>
ex ()
{
  if [ -f "$1" ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   unzstd $1    ;;
      *)           echo "'$1' cannot be extracted via ex()." ;;
    esac
  else
    echo "'$1' is not a valid file."
  fi
}

# Navigation with cd
up () {
  local d=""
  local limit="$1"

  # Default to limit of 1
  if [ -z "$limit" ] || [ "$limit" -le 0 ]; then
    limit=1
  fi

  for ((i=1;i<=limit;i++)); do
    d="../$d"
  done

  # Execute cd, show error if cd fails.
  if ! cd "$d"; then
    echo "Couldn't go up $limit directories.";
  fi
}

### ALIASES ###
# Dotfiles repo
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

# Adjust backlight brightness on laptop
alias brightness-high="sudo sh -c 'echo 255 > /sys/class/backlight/amdgpu_bl0/brightness'"
alias brightness-medium="sudo sh -c 'echo 96 > /sys/class/backlight/amdgpu_bl0/brightness'"
alias brightness-low="sudo sh -c 'echo 32 > /sys/class/backlight/amdgpu_bl0/brightness'"

# ls
alias ls='exa -alh --color=always --group-directories-first'     # preferred listing
alias lstree='exa -aT --color=always --group-directories-first'  # tree listing

alias pac='sudo pacman'
# Update only standard packages
alias pacsyu='sudo pacman -Syyu'
# Update only AUR packages
alias yaysua='yay -Sua --noconfirm'alias yaysyu='yay -Syu --noconfirm'               	# update standard pkgs and AUR pkgs (yay)
alias paccleanup='sudo pacman -Rns $(pacman -Qtdq)'  	# remove orphaned packages

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# Confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'
alias ln='ln -i'

# Create directories with parents
alias mkdir='mkdir -pv'

# Powerline config
#if [ -f $HOME/.local/lib/python3.10/site-packages/powerline/bindings/bash/powerline.sh ]; then
#  $HOME/.local/bin/powerline-daemon -q
#  POWERLINE_BASH_CONTINUATION=1
#  POWERLINE_BASH_SELECT=1
#  source $HOME/.local/lib/python3.10/site-packages/powerline/bindings/bash/powerline.sh
#fi

### RUN SOME COOL PROGRAMS ###
#Starship prompt
eval "$(starship init bash)"

# Run preferred shell as interactive (on top of bash)
# exec fish

