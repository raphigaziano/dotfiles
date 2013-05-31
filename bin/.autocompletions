# Autocompletion functions for personal scripts.
# Source this in bashrc.
#
# Author: raphigaziano <r.gaziano@gmail.com>
# Created: 2013-05-31 Fri 08:49
##############################################################################

# Helper.
# This function will scan the directory given as its first parameter,
# and "return" a list of all contained files, excluding the ones listed in
# its remaining params.
#
# args:
# $1    => Directory to scan.
# $2... => Files to ignore.
function __select_files {

    local dir f ignore

    dir=$1
    if [[ ! -d $dir ]]; then
        echo "First argument must be a valid directory"
        return 1
    fi
    shift

    files=()
    for f in $dir/*; do
        ignore=false
        for ignoref in $*; do
            if [[ "$f" == "$dir/$ignoref" ]]; then
                ignore=true
                break
            fi
        done
        if [[ $ignore == false && -f "$f" ]]; then
            files+=( "$(basename $f)" )
        fi
    done
    files=$( printf " %s" "${files[@]}" )
    return 0
}

# Custom file selection completion.
function __select_files_complete {
    local cur opts ignore

    cur="${COMP_WORDS[COMP_CWORD]}"
    cmd="${COMP_WORDS[COMP_CWORD-1]}"

    # Each command reusing the __select_files function should be
    # liste here as a separate case.
    case $cmd in
        ",dotconf.sh")
            ignore=(
                    README.rst
                    scripts
                    bin
                    backups
                    install.sh
            )
            __select_files "$HOME/.dotfiles" ${ignore[@]}
            ;;
        *)  # Catch all case.
            return 1
            ;;
    esac

    opts=$( printf " %s" "${files[@]}" )
    COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
    return 0
}

complete -F __select_files_complete ,dotconf.sh


