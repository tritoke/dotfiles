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

Plug 'w0rp/ale' " Asynchronous linting engine

Plug 'lervag/vimtex', { 'on': 'VimtexTocOpen', 'for': 'latex'} " latex but like better (better completion / autocompilation)

Plug 'godlygeek/tabular', { 'for': 'haskell' } " lines up tabs 

Plug 'ervandew/supertab' " Tab completion

Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'} " Neovim completion
" Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }     " TabNine integration

" Colour schemes
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()
" }}}

" Appearance {{{

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

" deoplete
let g:deoplete#enable_at_startup = 1
let g:auto_complete = 1
let g:deoplete#auto_complete_delay = 0
let g:deoplete#file#enable_buffer_path = 1
let g:deoplete#auto_completion_start_length = 0

" }}}
