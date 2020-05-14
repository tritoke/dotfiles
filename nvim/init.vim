" vim: foldmethod=marker foldlevel=0

" General Options {{{

" do syntax highlighting
filetype on
syntax on

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

" Jump to last location when file is opened
augroup jump_to_previous " {{{
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
augroup END " }}}

" }}}

" language specific settings {{{

" indentation settings
set autoindent " keep the current level of indentation when you go to a newline, e.g. with o
set smarttab " back space over tab boundaries i.e. <tab><bs> will leave you where you started

" use 2 spaces for indentation normally
set softtabstop=2 tabstop=2 shiftwidth=2 expandtab

augroup language_settings " {{{
  autocmd!
  autocmd FileType php setlocal cin fdm=syntax
  autocmd FileType c,cpp,java setlocal cin fdm=syntax noet 
  autocmd FileType java setlocal foldnestmax=4
  autocmd FileType python setlocal ts=4 sw=4 sts=0 si fdm=indent 
  autocmd FileType rust setlocal ts=4 sw=4 sts=0 cin fdm=syntax
  autocmd FileType html setlocal ts=4 sw=4 sts=0
  autocmd FileType asm,conf setlocal ts=8 sw=8 sts=0 fdm=indent noet
  autocmd FileType bib setlocal ts=6 sw=6 sts=0
  autocmd FileType markdown setlocal ts=4 sw=4 sts=0 ve=all noai spell
  autocmd FileType rmd,plaintex,mail setlocal spell
  autocmd FileType make setlocal noet fdm=indent
  autocmd FileType email setlocal tw=72
  autocmd FileType vim setlocal fdm=marker
  autocmd FileType sh,bash,zsh setlocal fdm=indent
  autocmd FileType verilog,systemverilog setlocal si fdm=indent nowrap
        \ cinwords=module,begin,function,task
  autocmd FileType tex setlocal spell
augroup END " }}}

" }}}

" Keyboard Shortcuts and remappings {{{

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

" random leader commands
nnoremap <leader>n /<++><enter>ca<
nnoremap <leader>t :!nohup st&>/dev/null&\!<enter><enter>

" awesome line to toggle highlighting after a search but only until the next
" one so each consecutive search will be highlighted but only the current
" search can be toggled
nnoremap <silent><expr> <Leader>h (&hls && v:hlsearch ? ':nohls' : ':set hls')."\n"

" toggle paste mode on / off
nnoremap <silent><expr> <Leader>v (&paste ? ':set nopaste' : ':set paste')."\n"

" shortcut automatically making a PDF in each of RMarkdown, Markdown and LaTeX
augroup pdf_mappings
  autocmd!
  autocmd FileType tex nnoremap <leader>w :!detex % \| wc -w<enter>
  autocmd FileType tex nnoremap <leader>p :!latexrun %<enter>
  autocmd FileType markdown nnoremap <leader>p :!pandoc % -s -o "%:r".pdf<enter>
  autocmd FileType markdown nnoremap <leader>j :!pandoc % -V monofont="JetBrains Mono NL Medium" --pdf-engine=xelatex -s -o "%:r".pdf<enter>
  autocmd FileType rmd nnoremap <leader>p :!echo "rmarkdown::render('<c-r>%', rmarkdown::pdf_document())" \| R --vanilla<enter>
  autocmd FileType rmd,markdown,tex nnoremap <leader>v :!zathura "%:r".pdf & disown<enter><enter>
augroup END

" }}}

" Abbreviations {{{

augroup shabangs " {{{
  autocmd!
  autocmd FileType python :iab <buffer> #! #!/usr/bin/env python
  autocmd FileType sh :iab <buffer> #! #!/bin/sh
augroup END " }}}



" Java bad lol {{{

" iabbrev print System.out.println
" }}}

" }}}

" Appearance {{{
" colourschemes
if 1
  " dark: https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim
  colorscheme molokai
else
  " light: https://www.vim.org/scripts/download_script.php?src_id=10153
  colorscheme summerfruit256
  set cul
endif

function Light()
  colorscheme summerfruit256
  set cul
endfunction

function Dark()
  colorscheme molokai
  set nocul
endfunction

" highight a badly spelt word red
highlight clear SpellBad
highlight SpellBad ctermbg=Red 
highlight SpellCap ctermbg=DarkGrey

" highlighting for folds
highlight clear Folded
highlight Folded guifg=Black

" }}}
