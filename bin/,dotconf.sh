#! /bin/bash
# 
# Manage configuration files stored in ~./dotfiles.
#
# For each <filename> arg, open ~/.dotfiles/<filename> with the system's
# default editor if the file already exists.
#
# Otherwise, create a new config file and it's symlink in $HOME.
# 
# TODO: Add -d flag to create a directory
#
# raphigaziano <r.gaziano@gmail.com>
# Created: 05-20-2013
#####################################################

USAGE=",conf-dir <filename>[, <filename>...]"
CONFDIR=~/.dotfiles

# Check args
if [ $# -lt 1  ]
then
    echo "Usage: $USAGE"
    exit 1
fi

for filename in $*
do
    path=$CONFDIR/$filename
    # Create files in ~/.dotfiles along with symlinks in $HOME
    if [ ! -e $path ]; then
        echo "create $path"
        touch $path
        echo new link ~/.${filename} to ${path}
        ln -s $path ~/.$filename
    fi
done

# Open files in system's default editor
for filname in $*
do
    if [ -f $path ]; then
        $EDITOR $CONFDIR/$filename
    fi
done
