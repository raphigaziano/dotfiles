" All system-wide defaults are set in $VIMRUNTIME/debian.vim (usually just
" /usr/share/vim/vimcurrent/debian.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vim/vimrc), since debian.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing debian.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Pathogen plugin loading
" call pathogen#runtime_append_all_bundles()
" call pathogen#helptags()
runtime bundle/pathogen/autoload/pathogen.vim
call pathogen#infect()

" To update plugins:
" git submodule init
" git submodule update

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
syntax on

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
"set incsearch		" Incremental search
set autowrite		" Automatically save before commands like :next and :make
"set hidden             " Hide buffers when they are abandoned
set mouse=a		" Enable mouse usage (all modes)

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

""" PERSONAL SETTINGS """

" Bind Ctrl+movement to move between windows
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-h> <c-w>h
map <c-l> <c-w>l

" Shift + space to exist insert mode
imap <c-Space> <Esc>

" Easier indenting in visual mode (keep block selected)
vnoremap < <gv
vnoremap > >gv

" Settings {{{
set secure nocompatible
if version >= 600
        syntax enable

        if version >= 700
            filetype plugin indent on
        else
            filetype on
            filetype plugin on
            filetype inent on
        endif
else
        :finish
endif
" }}}

set title
" Activate autoindent
set autoindent
" Show actual cursor position
set ruler
set showcmd
set showmatch
set showmode
set scrolloff=2 " 2 lines above/below cursor when scrolling
set wildmenu " completion with menu
set wildignore=*.o,*.obj,*.bak,*.exe,*.py[co],*.swp,*~,*.pyc
set matchtime=2 

" Misc
set backspace=indent,eol,start
set formatoptions=croq
set number
set colorcolumn=80
set cursorline
"set relativenumber
set smartindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set incsearch

" *always* use unicode
set encoding=utf-8 fileencoding=

" Make no *.bak
set nobackup
" Keep backup while editing
set writebackup
" Do not wrap text
set nowrap

""" Windows settings"""

if has("win32")
    " Fix finstr
    set grepprg=findstr\ /R\ /S\ /N
    if has("gui")
        " GVim font
        set guifont=Courrier_New:h10:cANSI
        " see: http://vim.wikia.com/wiki/VimTip1
        set mousemodel=extend
    endif
endif
