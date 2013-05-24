#! /bin/bash
#
# Automagically install the listed packages.
# Update the package list below accordingly.
#
# Should run on any Debian-like system (needs apt-get)
#
# raphigaziano <r.gaziano@gmail.com>
# Created: 05-22-2013
#
##############################################################################

packages=(
    tmux
    tree
    python-pip
    exuberant-ctags
)

# Check if user is root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root" 1>&2
    exit 1
fi

echo "Updating package index..."; echo
apt-get update
echo "Done."

for pname in ${packages[@]}
do
    echo "Installing $pname..."
    apt-get install $pname
    echo "Done."
done

exit 0
