#! /bin/bash
# 
# Manage configuration files stored in ~./dotfiles.
#
# For each <filename> arg, open ~/.dotfiles/<filename> with the system's
# default editor if the file already exists.
#
# Otherwise, create a new config file and it's symlink in $HOME.
# 
# Passing the -d flag as first argument will create a config directory.
#
# raphigaziano <r.gaziano@gmail.com>
# Created: 05-20-2013
#####################################################

USAGE="`basename $0` [-d] <filename>[, <filename>...]"
CONFDIR=~/.dotfiles
echo $USAGE; exit
# Check args
if [ $# -lt 1  ]
then
    echo "Usage: $USAGE"
    exit 1
fi

# Naive flag detection
if [[ $1 == -d  ]]; then
    diropt=1
    shift
fi

for filename in $*
do
    path=$CONFDIR/$filename
    # Create files in ~/.dotfiles along with symlinks in $HOME
    if [ ! -e $path ]; then
        echo "create $path"
        if [ -z $diropt ]; then     # Regular file
            touch $path
        else
            mkdir $path             # Directory
        fi
        echo "new link ~/.${filename} -> ${path}"
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
