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
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h \[\033[01;33m\]\w \n\[\033[01;34m\]\$\[\033[00m\] '

### ENV VARS ###

export EDITOR=vim
export PATH=$PATH:~/bin  

export GITHUBHOME=https://github.com/raphigaziano  # Git Home
export DEVDIR=~/dev                                # Dev dir

# virtualenvwrapper activation
export WORKON_HOME=$HOME/.virtualenvs
source $HOME/.venvburrito/startup.sh

# Source personal autocompletion script
source $HOME/bin/.autocompletions

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
    pygmentize -f terminal256 -O style=monokai -g "$@" | less -R
}

# Check gmail for new mails
# from http://www.catonmat.net/blog/yet-another-ten-one-liners-from-commandlinefu-explained/
function checkgmail {
    curl -u r.gaziano@gmail.com --silent "https://mail.google.com/mail/feed/atom" |
    perl -ne \
    '
        print "Subject: $1 " if /<title>(.+?)<\/title>/ && $title++;
        print "(from $1)\n"  if /<email>(.+?)<\/email>/;
    '
}

# mkdir and cd into into it
function cdmkdir () {
    mkdir -p "$@" && eval cd "\"\$$#\"";
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
alias gd='git difftool'
alias gdc='git difftool --cached'
alias gm='git commit -m'
alias gma='git commit -am'
alias gb='git branch'
alias gc='git checkout'
alias gra='git remote add'
alias grr='git remote rm'
alias gpu='git pull'
alias gcl='git clone'

# Quickie vim

# Compute filenames based on the passed extension, and call vim with those.
# This function should not be called manually:
# Set up an alias for it instead (see below).
function _vim_filext {
    # BAD NAME
    if [[ -z "$2" ]]; then
        echo "Give me a filename to work with!"
        return 1
    fi
    ext=$1
    shift
    res=()
    for f in $*; do
        res+=("$f.$ext")
    done
    vim ${res[@]}
}

alias v="vim"
alias vpy="_vim_filext 'py'"
alias vhtml="_vim_filext 'html'"
alias vcss="_vim_filext 'css'"
alias vjs="_vim_filext 'js'"
alias vc="_vim_filext 'c'"
alias vcpp="_vim_filext 'cpp'"
alias vh="_vim_filext 'h'"

alias ll="ls -lh"

# Run a simple http server in cwd
alias serve="python -m SimpleHTTPServer"

### Startup ###

cow_fortune
