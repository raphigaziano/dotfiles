#! /bin/bash
# Create a new config file and it's symlink in $HOME
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

# Create files in ~/.dotfiles along with symlinks in $HOME
for filename in $*
do
    path=$CONFDIR/$filename
    echo "create $path"
    touch $path
    echo new link ~/.${filename} to ${path}
    ln -s $path ~/.$filename
done

# Open files in vim
for filname in $*
do
    $EDITOR $filename
done
