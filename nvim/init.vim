" vim: foldmethod=marker foldlevel=0 formatoptions-=cro

" General Options {{{

" do syntax highlighting
syntax on
filetype plugin indent on

" always give panes their own status bar
set laststatus=1

" don't fold anything when opening the file
set foldlevel=99

" don't fold more than 2 levels deep
set foldnestmax=2

" don't redraw while doing macros (super speedy bois)
set lazyredraw

" splitting pane defaults
set splitbelow splitright

" backspace over all the things
set bs=indent,eol,start

" styling for the vertical spliters - use unicode vertical bar
set fillchars+=vert:│

" enable omnicompletion
set omnifunc=syntaxcomplete#Complete

" Text wrapping settings {{{

" wrap words at word boundaries instead of at at characters
set linebreak

" show a unicode elipsis at the start of every wrapped line
set showbreak=…

" add some space below/above the cursor when scrolling
set scrolloff=2

" }}}

" search settings {{{

" start searching as you type
set incsearch

" case insensitive searching
set ignorecase

" become case sensitive if a capital is used
set smartcase

" when substituting show the substition while typing
set inccommand=nosplit

" }}}

" undo settings {{{

" Allow persistent undo 
set undolevels=10000
set undodir=/tmp/tritoke/vim_undo
set undofile

" }}}

" Jump to last location when file is opened {{{
augroup jump_to_previous
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
augroup END " }}}

" Indentation settings {{{

" keep the current level of indentation when you go to a newline, e.g. with o
set autoindent

" back space over tab boundaries i.e. <tab><bs> will leave you where you started
set smarttab

" default to replacing a tab char with 2 spaces
set expandtab
set tabstop=2
set shiftwidth=2

" }}}

" }}}

" Appearance {{{

" colourschemes {{{

function Light()
  colorscheme summerfruit256
  set cul
endfunction

function Dark()
  colorscheme molokai
  set nocul
endfunction

" }}}

if 1
  " dark: https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim
  call Dark()
else
  " light: https://www.vim.org/scripts/download_script.php?src_id=10153
  call Light()
endif

" }}}

" Plugins {{{

" disable fzf.vim
let g:loaded_fzf = 0

" function to source the vim-css-colors plugin
function Color()
  exec "source /usr/share/vim/vimfiles/after/syntax/" . &filetype . ".vim"
endfunction

" }}}

" Keyboard Shortcuts and remappings {{{

" set localleader
let maplocalleader=","

" easily open up vimrc
nnoremap <leader>ev :tabe $MYVIMRC<enter>
nnoremap <leader>sv :source $MYVIMRC<enter>

" map F1 to escape
nnoremap <F1> <Esc>
inoremap <F1> <Esc>
vnoremap <F1> <Esc>

" fold and unfold with space
nnoremap <space> za

" switch tabs
nnoremap = :tabn<enter>
nnoremap - :tabp<enter> 

" Copy text to the clipboard directly
vnoremap <C-c> "+y
vnoremap <C-x> "+c

" Paste text from the clipboard directly
vnoremap <C-v> <ESC>"+p
inoremap <C-v> <ESC>"+pa

" search for the next instance of 
" replace around it, and clear the search buffer
nnoremap <leader>n /<++><enter>:let @/ = ""<enter>ca<

" start a new terminal
nnoremap <leader>t :!nohup st&>/dev/null&\!<enter><enter>

" change colourscheme with a leader
nnoremap <leader>l :call Light()<enter>
nnoremap <leader>d :call Dark()<enter>

" awesome line to toggle highlighting after a search but only until the next
" one so each consecutive search will be highlighted but only the current
" search can be toggled
nnoremap <silent><expr> <Leader>h (&hls && v:hlsearch ? ':nohls' : ':set hls').'<enter>'

" clear the current search pattern
nnoremap <Leader>cs :let @/ = ""<enter>

" toggle paste mode on / off
nnoremap <silent><expr> <Leader>v (&paste ? ':set nopaste' : ':set paste').'<enter>'

" source vim-css-colour plugin
nnoremap <silent> <Leader>co :call Color()<enter>

" }}}
