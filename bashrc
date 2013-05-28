# bashrc
#
# Shell settings & utilis
#
# raphigaziano <r.gaziano@gmail.com>
####################################

### General ###

# Set VIM Mode
set -o vi

# Custom prompt
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h \[\033[01;34m\]\W \$\[\033[00m\] '

### ENV VARS ###

export EDITOR=vim
export PATH=$PATH:~/bin  

export GITHUBHOME=https://github.com/raphigaziano  # Git Home
export DEVDIR=~/dev                                # Dev dir

# virtualenvwrapper activation
export WORKON_HOME=$HOME/.virtualenvs
source $HOME/.venvburrito/startup.sh

### Utils, shortcuts ###

# From http://sametmax.com/a-linterieur-de-mon-bashrc/
extract () {
    if [ -f $1 ]
    then
        case $1 in
            (*.7z)      7z x $1 ;;
            (*.lzma)    unlzma $1 ;;
            (*.rar)     unrar x $1 ;;
            (*.tar)     tar xvf $1 ;;
            (*.tar.bz2) tar xvjf $1 ;;
            (*.bz2)     bunzip2 $1 ;;
            (*.tar.gz)  tar xvzf $1 ;;
            (*.gz)      gunzip $1 ;;
            (*.tar.xz)  tar Jxvf $1 ;;
            (*.xz)      xz -d $1 ;;
            (*.tbz2)    tar xvjf $1 ;;
            (*.tgz)     tar xvzf $1 ;;
            (*.zip)     unzip $1 ;;
            (*.Z)       uncompress ;;
            (*) echo "don't know how to extract '$1'..." ;;
        esac
    else
        echo "Error: '$1' is not a valid file!"
        exit 0
    fi
}

# Syntax higlighted less
function cless {
    # NOTE: Requires pygments.
    pygmentize -f terminal "$@" | less -R
}

# Cd into project dir and activate its virtualenv
function project {
    workon $1
    cd $DEVDIR/$1
}

# Fun crap \o/

function rcowsay() {
    cowsay_dir=/usr/share/cowsay/cows
    # Pick a random cowsay file
    cowsay_file=$(ls $cowsay_dir | sort -R | tail -1)
    cowsay -f $cowsay_file $*
    echo
}
function cow_fortune {
    fortune | rcowsay
}

### Aliases ###

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

# Git aliases

alias ga='git add'
alias gp='git push'
alias gl='git log'
alias gs='git status'
alias gd='git diff'
alias gdc='git diff --cached'
alias gm='git commit -m'
alias gma='git commit -am'
alias gb='git branch'
alias gc='git checkout'
alias gra='git remote add'
alias grr='git remote rm'
alias gpu='git pull'
alias gcl='git clone'

alias ll="ls -lh"

function mkdircd () {
    mkdir -p "$@" && eval cd "\"\$$#\"";
}

# Run a simple http server in cwd
alias serve="python -m SimpleHTTPServer"

### Startup ###

cow_fortune
