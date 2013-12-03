" vimrc
" =====
"
" VIM 7.3 Config File
"
" raphigaziano <r.gaziano@gmail.com
" Created: 05-20-2013
"
" """"""""""""""""""""""""""""""""""

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

let mapleader=","
let maplocalleader=","

" Load pathogen modules.
" Keep this at the top of the file, right after runtime! debian.vim
call pathogen#infect()
call pathogen#helptags()

" Activate powerline
" set rtp+=$HOME/.local/lib/python2.7/site-packages/powerline/bindings/vim
" Use powerline fonts with vim-airline
" TODO : Error checking
let g:airline_powerline_fonts=1
" Airline themes i like:
" - murmur
" - serene
" - simple
" - ubaryd
" - understated
" - wombat
let g:airline_theme='wombat'

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
source /etc/vim/vimrc.local
endif

""" General Options """

" *always* use unicode
set encoding=utf-8 fileencoding=

" Jump to the last position when reopening a file
if has("autocmd")
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Plugins, indent rules and syntax depend on filetype
if version >= 600
    syntax enable

    if version >= 700
        filetype plugin indent on
    else
        filetype on
        filetype plugin on
        filetype indent on
    endif
else
    :finish
endif

syntax on

set background=dark     " If using a dark background within the 
                    " editing area and syntax highlighting turn 
                    " on this option as well
" highligh color for Vmode selection
highlight Visual ctermfg='White' ctermbg='Yellow'

" completion menu colors
highlight Pmenu ctermbg='DarkBlue' ctermfg='LightGreen'
highlight PmenuSel cterm='bold' ctermfg='LightGreen'


" Status line
set laststatus=2                                
set statusline=                                 
set statusline+=%-3.3n\                         " buffer number
set statusline+=%f\                             " filename
set statusline+=%h%m%r%w                        " status flags
set statusline+=\[%{strlen(&ft)?&ft:'none'}]    " file type
set statusline+=%=                              " right align remainder
set statusline+=0x%-8B                          " character value
set statusline+=%-14(%l,%c%V%)                  " line, character
set statusline+=%<%P                            " file position

set cursorline          " Highlight current line
set ruler               " Cursor position
set title               " ???

set backspace=indent,eol,start  " Backspace behaviour
set scrolloff=2         " 2 lines above/below cursor when scrolling

set number              " Set line numbers
set relativenumber      " Line numbering relative to current line

set showcmd             " Show (partial) command in status line.
set showmode            " Show current mode

set nobackup            " Make no *.bak
set writebackup         " Keep backup while editing
set nowrap              " Do not wrap text
set autowrite		    " Automatically save before commands like 
                    " :next and :make
set mouse=a	        	" Enable mouse usage (all modes)

set cpoptions+=$        " Show a dollar sign at the end of the section being
                    " changed
set timeoutlen=500

set virtualedit=all
set hidden              " Allow hiding unsaved buffers

""" Text Formatting """

set autoindent          " Activate autoindent
set formatoptions=croq  " Not sur what this is for ?
set colorcolumn=80      " Show 80th columen
set smartindent         " Indentation
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

""" Searching """

set showmatch		    " Show matching brackets.
set ignorecase		    " Do case insensitive matching
set smartcase	    	" Do smart case matching
set incsearch	    	" Incremental search
set wildmenu            " completion with menu
set wildignore=*.o,*.obj,*.bak,*.exe,*.py[co],*.swp,*~,*.pyc
set matchtime=2 
set wrapscan            " Wrap around the file

""" Key bindings """

" Bind Ctrl+movement to move between windows
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-h> <c-w>h
map <c-l> <c-w>l

" Ctrl-Space for autocompletion
inoremap <Nul> <C-x><C-o>

" Ctrl-j/k to select items from ompletion menus 
" from
" http://stackoverflow.com/questions/2170023/how-to-map-keys-for-popup-menu-in-vim
function! OmniPopup(action)
    if pumvisible()
        if a:action == 'j'
            return "\<C-N>"
        elseif a:action == 'k'
            return "\<C-P>"
        endif
    endif
    return a:action
endfunction

inoremap <c-j> <C-R>=OmniPopup('j')<CR>
inoremap <c-k> <C-R>=OmniPopup('k')<CR>

" Use j+k to escape insert mode
inoremap jk <Esc>

" Easier indenting in visual mode (keep block selected)
vnoremap < <gv
vnoremap > >gv

" In Visual mode, map Enter key to the EasyAlign command
vnoremap <silent> <Enter> :EasyAlign<cr>

" To insert timestamp, press F5.
" TODO: Find some better mapping
nmap <F5> a<C-R>=strftime("%Y-%m-%d %a %H:%M")<CR><Esc>
imap <F5> <C-R>=strftime("%Y-%m-%d %a %H:%M")<CR>

" Uppercase current word when in insert MODE
" TODO Use <cword>?
" inoremap <c-u> <esc>mqviwU<esc>`qa
inoremap <c-u> <esc>mqviwU<esc>`qa

" Edit vimrc
nnoremap <leader>ev :split $MYVIMRC<cr>
" source it
nnoremap <leader>sv :source $MYVIMRC<cr>

" Toggle between current & last buffer
" All modes ? or which ones ? 
nnoremap <leader>t :b#<cr>

" open / close quickfix window
" TODO: Toggle ?
nnoremap <leader>qfo :copen<cr>
nnoremap <leader>qfc :cclose<cr>

""" Disabled mappings 
" inoremap <esc> <nop>

""" Abbreviations """

""" Typo guards
iabbrev amdin admin

""" Windows settings """
""" ( Boo, I know  ) """

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


""" Plugin Options """

" NERDTree "

" Auto close explorer on opening a file
let g:NERDTreeQuitOnOpen=1
let g:NERDTreeHighlightCursorline=1
let g:NERDChristmasTree=1

" mappings
map <F2> :NERDTreeToggle<cr>
map <F3> :TlistToggle<cr>

" Taglist "
" Focus Tag window on opening
let Tlist_GainFocus_On_ToggleOpen = 1
" Tag window on the right
let Tlist_Use_Right_Window = 1

" ctrp "
" bindings
let g:ctrlp_map = '<C-P>'
let g:ctrlp_cmd = 'CtrlP'
" CtrlP workind dir
let g:ctrlp_working_path_mode = 'ra'

" Python-mode "
let g:pymode_lint_cwindow = 0

""" FileTypes """

""" Python

au FileType python set omnifunc=pythoncomplete#Complete
