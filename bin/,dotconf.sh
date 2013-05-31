#! /bin/bash
# 
# Manage configuration files stored in ~./dotfiles.
#
# For each <filename> arg, open ~/.dotfiles/<filename> with the system's
# default editor if the file already exists.
#
# Otherwise, create a new config file and it's symlink in $HOME.
#
# raphigaziano <r.gaziano@gmail.com>
# Created: 05-20-2013
#####################################################

USAGE="`basename $0` <filename>[, <filename>...]"
CONFDIR=~/.dotfiles

# Check args
if [ $# -lt 1  ]
then
    echo "Usage: $USAGE"
    exit 1
fi

files=()
for filename in $*; do
    files+=("$CONFDIR/$filename")
done

$EDITOR ${files[@]}

for f in $*; do
    path=$CONFDIR/$filename
    if [[ -e $path && ! -e $HOME/.$f ]]; then
        echo "new link $HOME/.${f} -> ${path}"
        ln -s $path $HOME/.$f
    fi
done
