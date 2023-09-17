vim.cmd.nnoremap("<LocalLeader>p", [[<cmd>:!pandoc % -s -o "%:r".pdf<enter>]])
vim.cmd.nnoremap("<localleader>x", [[<cmd>:!pandoc % -s --pdf-engine=xelatex -o "%:r".pdf<enter>]])
vim.cmd.nnoremap("<localleader>j", [[<cmd>:!pandoc % -V monofont="JetBrains Mono NL Medium" --pdf-engine=xelatex -s -o "%:r".pdf<enter>]])
vim.cmd.nnoremap("<localleader>v", [[<cmd>:!zathura "%:r".pdf & disown<enter><enter>]])

-- j and k move within a wrapped line, useful when writing text.
vim.cmd.nnoremap("j", "gj")
vim.cmd.nnoremap("k", "gk")

-- set text wrapping
vim.opt.wrap = true
