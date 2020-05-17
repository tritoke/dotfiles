" Entirely taken from: https://vim.fandom.com/wiki/C/C++_function_abbreviations

" Help delete character if it is 'empty space'
" stolen from Vim manual
function! Eatchar()
  let c = nr2char(getchar())
  return (c =~ '\s') ? '' : c
endfunction

" Replace abbreviation if we're not in comment or other unwanted places
" stolen from Luc Hermitte's excellent http://hermitte.free.fr/vim/
function! MapNoContext(key, seq)
  let syn = synIDattr(synID(line('.'),col('.')-1,1),'name')
  if syn =~? 'comment\|string\|character\|doxygen'
    return a:key
  else
    exe 'return "' .
    \ substitute( a:seq, '\\<\(.\{-}\)\\>', '"."\\<\1>"."', 'g' ) . '"'
  endif
endfunction

" Create abbreviation suitable for MapNoContext
function! Iab (ab, full)
  exe "iab <silent> <buffer> ".a:ab." <C-R>=MapNoContext('".
    \ a:ab."', '".escape (a:full.'<C-R>=Eatchar()<CR>', '<>\"').
    \"')<CR>"
endfunction
