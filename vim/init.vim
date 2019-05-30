"                            vim:foldmethod=marker

source ~/.vimrc

" General Options {{{
" Automatically switch between line numbering modes
set number relativenumber
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" highlight current line
set cursorline

" plugins need it?
filetype plugin indent on

" }}}

" Keyboard Shortcuts and remaps {{{
" jump to the first ALE linter error
nnoremap ,, :ALEFirst<CR>

" switches to hexmode
nnoremap <Leader>x :Hexmode <CR>

" Toggle the NERDTree sidebar
map <F6> :NERDTreeToggle<CR>

" vimtex amazing section jump thing
autocmd FileType tex map <leader>o :VimtexTocOpen<CR>


" tabularize
nnoremap <leader>= :Tabularize /=<LF>
nnoremap <leader>- :Tabularize /-><LF>

" ghcmod-vim
au FileType haskell nmap :t :GhcModType
au FileType haskell nmap :tc :GhcModTypeClear

" }}}

" Plugins {{{
call plug#begin('~/.config/nvim/plugged')

Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ } " Language server protocol support

Plug 'fidian/hexmode' " Switch to hex mode

Plug 'w0rp/ale' " Asynchronous linting engine
Plug 'ncm2/ncm2' " Auto completion manager

Plug 'lervag/vimtex', { 'on': 'VimtexTocOpen', 'for': 'latex'} " latex but like better (better completion / autocompilation)

Plug 'godlygeek/tabular', { 'for': 'haskell' } " lines up tabs 

Plug 'ervandew/supertab' " Tab completion
Plug 'jiangmiao/auto-pairs', { 'for': ['python', 'c', 'c++', 'haskell', 'java'] } " Auto-insert closing pairs
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' } " File directory exporer
Plug 'scrooloose/nerdcommenter' " uber cool commenting out multiple lines
Plug 'zchee/deoplete-jedi', { 'for': 'python' } " Deoplete jedi source
Plug 'tweekmonster/deoplete-clang2', { 'for': 'c' } " Deoplete clang source
Plug 'eagletmt/ghcmod-vim', { 'for': 'haskell' } " type info in Haskell
Plug 'eagletmt/neco-ghc', { 'for': 'haskell' } " Deoplete haskell source
" Plug 'w0rp/vim-polyglot' " b i g language pack

Plug 'roxma/nvim-yarp' " Required for ncm2 and (optionally) deoplete
Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'} " Neovim completion
" Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' } " TabNine integration

Plug 'chrisbra/Colorizer' " Highlight hex codes with correct colours
" Plug 'airblade/vim-gitgutter' " Git diff line status and git functionality
" Plug 'majutsushi/tagbar' " View and browse ctags of a file
Plug 'wakatime/vim-wakatime' " Wakatime integration
" Plug 'tpope/vim-fugitive' " MORE Git functionality

" Colour schemes
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'crusoexia/vim-monokai'

call plug#end()
" }}}

" Appearance {{{
colorscheme monokai

" highight a badly spelt word red
hi clear SpellBad
hi SpellBad ctermbg=Red 
hi SpellCap ctermbg=DarkGrey

" highlighting for folds
hi clear Folded
hi Folded guifg=Black

" airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='molokai'
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:webdevicons_enable_airline_statusline = 1

" }}}

" Plugin Configuration {{{

" Enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect

" Define the Python interpreters to use to speed up startup
" and to aide with working in virtual environments
" git clone https://github.com/pyenv/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv
" the above command adds virtualenv plugin
" pyenv install 3.7.2
" pyenv install 2.7.15
" pyenv virtualenv 3.6.5 py3nvim
" pyenv virtualenv 2.7.15 py2nvim
" pyenv activate py3nvim
" pip install pynvim neovim
" pyenv deactivate 
" repeat for python2
let g:python_host_prog  = $PYENV_ROOT.'/versions/py2nvim/bin/python'	  " Python 2
let g:python3_host_prog = $PYENV_ROOT.'/versions/py3nvim/bin/python'	  " Python 3

" disable haskell-vim omnifunc
let g:haskellmode_completion_ghc = 0

" neco-ghc
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
let g:ycm_semantic_triggers = {'haskell' : ['.']}
let g:necoghc_enable_detailed_browse = 1

" nerdtree
let g:NERDTreeGitStatusNodeColorization = 1
map <C-n> :NERDTreeToggle<LF>

" ALE options
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_linters = {
\   'tex': ['chktex']
\}

" vimtex options
let g:vimtex_view_method = 'zathura'
" disable latex-box mappings
let g:LatexBox_no_mappings = 1
" compilation
let g:vimtex_compiler_method = 'latexrun'

" auto-pairs options
let g:AutoPairsMultilineClose = 0

" nerd commenter
" [VISUAL MODE]<leader>c<space>
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDToggleCheckAllLines = 1

" vim-polyglot
let g:haskell_classic_highlighting = 1
let g:haskell_indent_if = 3
let g:haskell_indent_case = 2
let g:haskell_indent_let = 4
let g:haskell_indent_where = 6
let g:haskell_indent_before_where = 2
let g:haskell_indent_after_bare_where = 2
let g:haskell_indent_do = 3
let g:haskell_indent_in = 1
let g:haskell_indent_guard = 2
let g:haskell_indent_case_alternative = 1
let g:cabal_indent_section = 2

" deoplete
let g:deoplete#enable_at_startup = 1
let g:auto_complete = 1
let g:deoplete#auto_complete_delay = 0
let g:deoplete#file#enable_buffer_path = 1
let g:deoplete#auto_completion_start_length = 0
let g:deoplete#sources#clang#libclang_path = "/usr/lib/llvm-6.0/lib/libclang-6.0.so.1"
let g:deoplete#sources#clang#clang_header = "/usr/bin/clang"

" }}}
