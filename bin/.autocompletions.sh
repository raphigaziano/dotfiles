# Autocompletion functions for personal scripts.
# Source this in bashrc.
#
# Author: raphigaziano <r.gaziano@gmail.com>
# Created: 2013-05-31 Fri 08:49
##############################################################################


# Helper.
# Get an already typed subcommand.
#
# args:
# $*    => array of accepted subcommands
function __get_subcmd {
    for (( i=0; $i < ${#COMP_WORDS[@]}-1; i++ )); do
        case "$*" in *"${COMP_WORDS[i]}"*)
                cmd=${COMP_WORDS[i]}
                ;;
        esac
    done
}

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
            if [[ "$f" == $dir/$ignoref ]]; then
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
# Inspired by apt_get's autocompletion: /etc/bash_completion.d/apt
function __dotconf_complete {

    # TODO: better "return" from __select_files

    local opts cur prev cmd i
    COMPRREPLY=()
    opts=(
        config
        script
        snippets
    )

    _get_comp_words_by_ref cur prev
    __get_subcmd ${opts[@]}

    if [[ -n $cmd ]]; then
        local files
        case $cmd in
            config)
                ignore=(
                    README.rst
                    scripts
                    bin
                    backups
                    install.sh
                )
                __select_files "$HOME/.dotfiles" ${ignore[@]}
                ;;
            script)
                ignore=(
                    *.pyc
                )
                __select_files "$HOME/bin" ${ignore[@]}
                ;;
            snippets)
                __select_files "$HOME/.dotfiles/vim/snippets"
                ;;
            *)  # Catch all case.
                return 1
                ;;
        esac

        COMPREPLY=( $(compgen -W "${files}" -- ${cur}) )
        return 0
    fi

    # Subcommand completion
    local optstring=$( printf "%s " "${opts[@]}")
    COMPREPLY=( $(compgen -W "${optstring}" -- ${cur}) )
    return 0
} &&
complete -F __dotconf_complete ,dotconf.sh

# Helper.
# Get the list of feeds for ,feedreadr completion.
function __get_feeds {
    feeds=$(python -c "from __future__ import print_function; \
                       import json; data=json.load(open('$HOME/bin/.feeds')); \
                       print(' '.join(data.keys()))")
}

# Subcmds & feed completion
function __feedreadr_complete {
    local opts cur prev cmd i
    opts=(
        fetch
        list
        register
        remove
    )

    _get_comp_words_by_ref cur prev
    __get_subcmd ${opts[@]}

    if [[ -n $cmd ]]; then
        case $cmd in
            fetch|remove)
                __get_feeds
                COMPREPLY=( $(compgen -W "${feeds}" -- ${cur}) )
                return 0
                ;;
            *)  # Catch-all case: no-op
                ;;
        esac
    fi

    # Subcommand completion
    local optstring=$( printf "%s " "${opts[@]}")
    COMPREPLY=( $(compgen -W "${optstring}" -- ${cur}) )
} &&
complete -F __feedreadr_complete ,feedreadr.py
