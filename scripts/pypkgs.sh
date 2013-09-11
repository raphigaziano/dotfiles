#! /bin/bash
#
# Install python packages listed in pip-requirements.
#
# Dependencies:
# - Pip itself should already be installed.
# - curl (not installed by default on some systems)
#
# raphigaziano <r.gaziano@gmail.com>
# Created: 05-22-2013
#
##############################################################################

CONFDIR=~/.dotfiles
# Pointing to forked repo for latest virtualenv.
# Still not using it -> no py3 support yet
BURRITOURL=https://raw.github.com/raphigaziano/virtualenv-burrito/master/virtualenv-burrito.sh

# Store root test for reuse
root="[ $EUID -eq 0 ]"

# Check if the script is run as root, and warn the user if so
# warn and prompt him to decide if we keep going or abort.
if $root; then
    echo "You've ran pypkgs as the system's super user."
    echo "This will bypass the virtualenv installation and install the packages"
    echo "globally, which might not be what you want to do."
    read -p "Keep going anyway [y/N] ? " answer
    case $answer in 
        [yY]* )
            ;; # No-op, just keep going
        * )
            exit 0;;
    esac
fi

# First get virtualenv & virtualenvwrapper, 
# using venv-burrito to simplify the process

# if ! $root; then
#     echo "Installing venv-burrito..."
#     curl -s $BURRITOURL | $SHELL
# 
#     # Create a "master" virtual env ?
#     # source $VENVBURRITO/startup.sh
# else
#     echo "Bypassing venv-burrito installation."
# fi

# Install packages from pip-requirements.txt
# (pip should be installed already)

pipfile=$CONFDIR/scripts/pip-requirements.txt
echo "Installing python packages listed in $pipfile..."
pip install --user -r $pipfile
