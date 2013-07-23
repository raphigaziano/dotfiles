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

# Do NOT run as root
# TODO: warn user if so

# Check if user is root
# if [[ $EUID -ne 0 ]]; then
    # echo "This script must be run as root"
    # exit 1
# fi

CONFDIR=~/.dotfiles
BURRITOURL=https://raw.github.com/brainsik/virtualenv-burrito/master/virtualenv-burrito.sh

# First get virtualenv & virtualenvwrapper, 
# using venv-burrito to simplify the process
curl -s $BURRITOURL | $SHELL

# Create a "master" virtual env ?
# source $VENVBURRITO/startup.sh

# Install packages from pip-requirements.txt
# (pip should be installed already)
pip install --user -r $CONFDIR/scripts/pip-requirements.txt
