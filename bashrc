# Env vars
export EDITOR=vim

# Set VIM Mode
set -o vi

# Add $HOME/bin to $PATH
# (Apparently a bad idea to do so here, but i'll bother with this later)
PATH=$PATH:~/bin  # already set in mint's .profile

# Custom prompt
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h \[\033[01;34m\]\W \$\[\033[00m\] '

# Fortune fun
# echo; fortune | cowsay; echo
fortune; echo

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
