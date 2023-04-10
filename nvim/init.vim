" vim: foldmethod=marker foldlevel=0 formatoptions-=cro

" General Options {{{

" do syntax highlighting
syntax on
filetype plugin indent on

" don't fold by default
set foldlevel=99

" always give panes their own status bar
set laststatus=1

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

call plug#begin('~/.local/share/nvim')

" for tracking time spent programming in vim
Plug 'wakatime/vim-wakatime'

" because arm assembly is very cool
Plug 'alisdair/vim-armasm'

" I write lots of languages :)
Plug 'sheerun/vim-polyglot'

" these things get hella annoying sometimes
Plug 'vim-scripts/Improved-AnsiEsc'

call plug#end()


" }}}

" Keyboard Shortcuts and remappings {{{

" set localleader
let maplocalleader=","

" easily open up vimrc
nnoremap <silent> <leader>ev :tabe $MYVIMRC<enter>
nnoremap <silent> <leader>sv :source $MYVIMRC<enter>

" map F1 to escape
nnoremap <F1> <Esc>
inoremap <F1> <Esc>
vnoremap <F1> <Esc>

" fold and unfold with space
nnoremap <silent> <space> za

" switch tabs
nnoremap <silent> L :tabn<enter>
nnoremap <silent> H :tabp<enter> 

" Copy text to the clipboard directly
vnoremap <silent> <C-c> "+y
vnoremap <silent> <C-x> "+c

" Paste text from the clipboard directly
vnoremap <silent> <C-v> <ESC>"+p
inoremap <silent> <C-v> <ESC>"+pa

" search for the next instance of <++>
" replace around it, and clear the search buffer
nnoremap <silent> <leader>n /<++><enter>:let @/ = ""<enter>ca<

" start a new terminal
nnoremap <silent> <leader>t :!nohup st&>/dev/null&\!<enter><enter>

" change colourscheme with a leader
nnoremap <silent> <leader>l :call Light()<enter>
nnoremap <silent> <leader>d :call Dark()<enter>

" awesome line to toggle highlighting after a search but only until the next
" one so each consecutive search will be highlighted but only the current
" search can be toggled
nnoremap <silent><expr> <leader>h (&hls && v:hlsearch ? ':nohls' : ':set hls').'<enter>'

" clear the current search pattern
nnoremap <leader>cs :let @/ = ""<enter>

" toggle paste mode on / off
nnoremap <silent><expr> <leader>v (&paste ? ':set nopaste' : ':set paste').'<enter>'

" source vim-css-colour plugin
nnoremap <silent> <leader>co :call Color()<enter>

" nerd tree mappings
noremap <silent> <leader>o :NERDTree<enter>

" open man page in splits / tabs
nnoremap <silent> <leader>ms "zyiw:exe "sp man://".@z.""<enter>
nnoremap <silent> <leader>mv "zyiw:exe "vsp man://".@z.""<enter>
nnoremap <silent> <leader>me "zyiw:exe "tabe man://".@z.""<enter>
nnoremap <silent> <leader>mS "zyiW:exe "sp man://".@z.""<enter>
nnoremap <silent> <leader>mV "zyiW:exe "vsp man://".@z.""<enter>
nnoremap <silent> <leader>mE "zyiW:exe "tabe man://".@z.""<enter>

" open terminals in splits
nnoremap <silent> <leader>zs :exe "sp term://zsh"<enter>
nnoremap <silent> <leader>zv :exe "vsp term://zsh"<enter>
nnoremap <silent> <leader>ze :exe "tabe term://zsh"<enter>

" set the X11 KB map - leader = \ therefore moves when my keyboard is disconnected - why I need this damn command at all
nnoremap <silent> <localleader>kb :! setxkbmap gb<enter><enter>

" Escape out of nested term:// things
tnoremap <silent> <Esc> <C-\><C-n>

" }}}

" autocommands {{{

" resize splits when the vim window changes size
autocmd VimResized * wincmd =

" }}}

