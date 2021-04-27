augroup uni_settings
  autocmd!
  autocmd BufRead /*comp23412*/*.* setlocal tabstop=2 shiftwidth=2 expandtab
  autocmd BufRead /*comp22712*/*.s setlocal filetype=armasm tabstop=8 shiftwidth=8 noexpandtab
  autocmd BufRead /*comp26120*/*.* setlocal tabstop=4 shiftwidth=4 expandtab
augroup END
