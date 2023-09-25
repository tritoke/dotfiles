vim.api.nvim_set_keymap("n", "<LocalLeader>p", [[<cmd>:!pandoc % -s -o "%:r".pdf<enter>]], { noremap = true })
vim.api.nvim_set_keymap("n", "<localleader>x", [[<cmd>:!pandoc % -s --pdf-engine=xelatex -o "%:r".pdf<enter>]], { noremap = true })
vim.api.nvim_set_keymap("n", "<localleader>j", [[<cmd>:!pandoc % -V monofont="JetBrains Mono NL Medium" --pdf-engine=xelatex -s -o "%:r".pdf<enter>]], { noremap = true })
vim.api.nvim_set_keymap("n", "<localleader>v", [[<cmd>:!zathura "%:r".pdf & disown<enter><enter>]], { noremap = true })

-- j and k move within a wrapped line, useful when writing text.
vim.api.nvim_set_keymap("n", "j", "gj", { noremap = true })
vim.api.nvim_set_keymap("n", "k", "gk", { noremap = true })

-- set text wrapping
vim.opt.wrap = true
