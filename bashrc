# Env vars
export EDITOR=vim

# Set VIM Mode
set -o vi

# Add $HOME/bin to $PATH
# (Apparently a bad idea to do so here, but i'll bother with this later)
PATH=$PATH:~/bin  # already set in mint's .profile
# Git Home
GITHOME=https://github.com/raphigaziano

# Custom prompt
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h \[\033[01;34m\]\W \$\[\033[00m\] '

# Fortune fun
function cow_fortune {
    cowsay_dir=/usr/share/cowsay/cows
    # Pick a random cowsay file
    cowsay_file=$(ls $cowsay_dir | sort -R | tail -1)
    fortune | cowsay -f $cowsay_file
    echo
}
cow_fortune

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
alias serve="python -c 'import SimpleHTTPServer; SimpleHTTPServer.test()'"
