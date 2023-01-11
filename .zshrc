# Download Znap, if it's not there yet.
[[ -f ~/Git/zsh-snap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git ~/Git/zsh-snap

source ~/Git/zsh-snap/znap.zsh  # Start Znap

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

znap prompt sindresorhus/pure

# Autocompletions
znap install g-plane/zsh-yarn-autocompletions
znap install greymd/docker-zsh-completion
znap install zsh-users/zsh-completions

# Plugins
znap source none9632/zsh-sudo

ZSH_AUTOSUGGEST_STRATEGY=( history )
znap source zsh-users/zsh-autosuggestions

ZSH_HIGHLIGHT_HIGHLIGHTERS=( main brackets )
znap source zsh-users/zsh-syntax-highlighting

znap source ohmzsh/ohmyzsh lib/{git,theme-and-appearance}

zstyle ':omz:update' mode reminder  # just remind me to update when it's time

zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path ~/.zsh/cache/$HOST

zstyle ':completion:*' list-colors ''

zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'

zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'

zstyle ':completion:*::::' completer _expand _complete _ignored _approximate
zstyle ':completion:*' menu select=1 _complete _ignored _approximate

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions': format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*:' group-name ''

source $ZSH/oh-my-zsh.sh

# User configuration

export EDITOR='nano'

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Aliases

function aur-clone() {
    pkg="/home/$USER/AUR/$1"
    git clone "https://aur.archlinux.org/$1.git" "$pkg"
    cd "$pkg"
}

function fix-bluetooth() {
    sudo rfkill block bluetooth
    sudo rfkill unblock bluetooth
    sudo systemctl restart bluetooth
}

alias aur-make="makepkg -Acs"

alias ls="ls --color=auto --group-directories-first"
alias grep="grep --color=auto"
alias mkdir="mkdir -pv"
alias most="du -hsx * | sort -rh | head -10"
alias which="(alias; declare -f) | /usr/bin/which --tty-only --read-alias --read-functions --show-tilde --show-dot"

function any() {
    emulate -L zsh
    unsetopt KSH_ARRAYS
    if [[ -z "$1" ]]; then
        echo "any - grep for process(es) by keyword" >&2
        echo "Usage: any " >&2 ; return 1
    else
        ps xauwww | grep -i --color=auto "[${1[1]}]${1[2,-1]}"
    fi
}

function extract() {
    if [ -z "$1" ]; then
        echo "Usage: extract <path/filename>.<zip|rar|bz2|gz|tar|tbz2|7z|tar.bz2|tar.gz|tar.xz>"
    else
        if [ -f $1 ]; then
            case $1 in
                *.tar.bz2)   tar xvjf $1 ;;
                *.tar.gz)    tar xvzf $1 ;;
                *.tar.xz)    tar xvJf $1 ;;
                *.bz2)       bunzip2 $1  ;;
                *.rar)       unrar x -ad $1 ;;
                *.gz)        gunzip $1 ;;
                *.tar)       tar xvf $1 ;;
                *.tbz2)      tar xvjf $1 ;;
                *.zip)       unzip $1 ;;
                *.7z)        7z x $1 ;;
                *)           echo "extract: '$1' - unknown archive method" ;;
            esac
        else
            echo "$1 - file does not exist"
        fi
    fi
}

function dexec() {
    docker exec -it $@ /bin/bash
}

alias dcp="docker-compose "
alias dcpull="docker-compose pull"
alias dclogs="docker-compose logs -ft "

alias glog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue) <%an>%Creset' --abbrev-commit"
alias gundo="git clean -df && git checkout -- ."

setopt no_beep
setopt interactive_comments

setopt auto_cd
setopt append_history
setopt extended_history
setopt inc_append_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt hist_reduce_blanks
setopt hist_verify
setopt share_history

setopt always_to_end
setopt auto_menu
setopt auto_name_dirs
setopt complete_in_word

unsetopt menu_complete

setopt correct
setopt correctall
