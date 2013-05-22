# Set VIM Mode
set -o vi

### ENV VARS ###

EDITOR=vim
PATH=$PATH:~/bin  

GITHUBHOME=https://github.com/raphigaziano  # Git Home
DEVDIR=~/dev                                # Dev dir

# Custom prompt
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h \[\033[01;34m\]\W \$\[\033[00m\] '

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

# Utils, shortcuts

# From http://sametmax.com/a-linterieur-de-mon-bashrc/
extract () {
    if [ -f $1 ]
    then
        case $1 in
            (*.7z) 7z x $1 ;;
            (*.lzma) unlzma $1 ;;
            (*.rar) unrar x $1 ;;
            (*.tar) tar xvf $1 ;;
            (*.tar.bz2) tar xvjf $1 ;;
            (*.bz2) bunzip2 $1 ;;
            (*.tar.gz) tar xvzf $1 ;;
            (*.gz) gunzip $1 ;;
            (*.tar.xz) tar Jxvf $1 ;;
            (*.xz) xz -d $1 ;;
            (*.tbz2) tar xvjf $1 ;;
            (*.tgz) tar xvzf $1 ;;
            (*.zip) unzip $1 ;;
            (*.Z) uncompress ;;
            (*) echo "don't know how to extract '$1'..." ;;
        esac
    else
        echo "Error: '$1' is not a valid file!"
        exit 0
    fi
}

# Cd into project dir and activate its virtualenv
function project {
    workon $1
    cd $DEVDIR/$1
}

# Aliases

alias cd..="cd .."
alias cd...="cd ../.."
alias cd....="cd ../../.."
alias cd.....="cd ../../../.."
alias cd......="cd ../../../../.."

alias ll="ls -lh"

function mkdircd () {
    mkdir -p "$@" && eval cd "\"\$$#\"";
}

# Run a simple http server in cwd
alias serve="python -m SimpleHTTPServer"

cow_fortune
