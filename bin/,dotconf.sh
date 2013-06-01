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

CONFDIR=~/.dotfiles

function usage {
    # TODO: update this & header
    echo "USAGE=`basename $0` <filename>[, <filename>...]"
    exit 1
}

# Check args
if [ $# -lt 2 ]
then
    usage
fi

# Actual File Editing
function edit_files {

    local dir files filename

    dir=$1
    shift

    files=()
    for filename in $*; do
        files+=("$dir/$filename")
    done

    $EDITOR ${files[@]}
}


cmd=$1
shift

case $cmd in

    config)
        edit_files $CONFDIR $*
        for f in $*; do
            path=$CONFDIR/$f
            if [[ -e $path && ! -e $HOME/.$f ]]; then
                echo "new link $HOME/.$f -> ${path}"
                ln -s $path $HOME/.$f
            fi
        done
        ;;

    script)
        edit_files $HOME/bin $*
        for f in $*; do
            path=$HOME/bin/$f
            if [[ -e $path ]]; then
                chmod +x "$path"
            fi
        done
        ;;

    snippets)
        edit_files $CONFDIR/vim/snippets $*
        ;;

    # Add other locations here as a separate case

    *)  # Catch all case => invalid cmd
        echo "Invalid command: $cmd"
        exit 1
        ;;
esac

exit 0
