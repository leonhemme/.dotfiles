# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

### Path ###
if [ -d "$HOME/.bin" ]; then
    PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/Applications" ]; then
    PATH="$HOME/Applications:$PATH"
fi

if [ -d "$HOME/.nvm" ]; then
    export NVM_DIR="$HOME/.nvm"
    if [ -s "$NVM_DIR/nvm.sh" ]; then
        . "$NVM_DIR/nvm.sh"
    fi
    if [ -s "$NVM_DIR/bash_completion" ]; then
        . "$NVM_DIR/bash_completion"
    fi
fi

if [ -f "$HOME/.cargo/env" ]; then
    . "$HOME/.cargo/env"
fi

bind "set completion-ignore-case on"
bind '"\C-f": "tms\n"'

### Environment variables ###
export LC_MONETARY=de_DE.UTF-8
export LC_PAPER=de_DE.UTF-8
export LC_MEASUREMENT=de_DE.UTF-8

### Functions ###
# Archive extraction
extr() {
    if [ -f "$1" ]; then
        # Set extraction output path, default to current directory if not provided
        local dest="${2:-.}"

        local archive_name=$(basename "$1")
        local folder_name="${archive_name%.*}"
        local target_dir="$dest/$folder_name"
        if [ ! -d "$target_dir" ]; then
            mkdir -p "$target_dir"
        fi

        case $1 in
        *.tar.bz2) tar xjf "$1" -C "$target_dir" ;;
        *.tar.gz) tar xzf "$1" -C "$target_dir" ;;
        *.bz2)
            local decompressed_file="${1%.bz2}"
            bunzip2 -c "$1" >"$target_dir/$(basename "$decompressed_file")"
            ;;
        *.rar) unrar x "$1" "$target_dir" ;;
        *.gz)
            local decompressed_file="${1%.gz}"
            gunzip -c "$1" >"$target_dir/$(basename "$decompressed_file")"
            ;;
        *.tar) tar xf "$1" -C "$target_dir" ;;
        *.tbz2) tar xjf "$1" -C "$target_dir" ;;
        *.tgz) tar xzf "$1" -C "$target_dir" ;;
        *.zip) unzip "$1" -d "$target_dir" ;;
        *.Z)
            local decompressed_file="${1%.Z}"
            uncompress -c "$1" >"$target_dir/$(basename "$decompressed_file")"
            ;;
        *.7z) 7z x "$1" -o"$target_dir" ;;
        *.deb) ar x "$1" -C "$target_dir" ;;
        *.tar.xz) tar xf "$1" -C "$target_dir" ;;
        *.tar.zst) unzstd -o "$target_dir" "$1" ;;
        *) echo "'$1' cannot be extracted via extr()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Navigation with cd
up() {
    local d=""
    local limit="$1"

    # default to limit of 1
    if [ -z "$limit" ] || [ "$limit" -le 0 ]; then
        limit=1
    fi

    for ((i = 1; i <= limit; i++)); do
        d="../$d"
    done

    # Execute cd, show error if cd fails.
    if ! cd "$d"; then
        echo "Couldn't go up $limit directories."
    fi
}

### Aliases ###
# Dotfiles repo
alias config='/usr/bin/git -C $HOME/.dotfiles'

# Adjust backlight brightness on laptop
alias brightness-high="sudo sh -c 'echo 255 > /sys/class/backlight/amdgpu_bl0/brightness'"
alias brightness-medium="sudo sh -c 'echo 96 > /sys/class/backlight/amdgpu_bl0/brightness'"
alias brightness-low="sudo sh -c 'echo 32 > /sys/class/backlight/amdgpu_bl0/brightness'"

alias ls='eza --group-directories-first'
alias ll='eza -alh --group-directories-first'
alias la='eza -ah --group-directories-first'
alias lstree='eza -aT --group-directories-first'

alias pac='sudo pacman'
# Update only standard packages
alias pacsyu='sudo pacman -Syyu'
# Update only AUR packages
alias yaysua='yay -Sua'
# Update standard pkgs and AUR pkgs (yay)
alias yaysyu='yay -Syu'
# Remove orphaned packages
alias pacclean='sudo pacman -Rns $(pacman -Qtdq)'

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

alias vim='nvim'

### Start some cool stuff
eval "$(starship init bash)"
