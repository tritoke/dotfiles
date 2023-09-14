-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

lvim.leader = "\\"
lvim.localleader = ","
lvim.plugins = {
  "stevearc/dressing.nvim",
  "judaew/ronny.nvim",
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle"
  },
}

lvim.colorscheme = "ronny"

-- navigate between tabs nicely navigate between tabs nicely navigate between tabs nicely navigate between tabs nicely navigate between tabs nicely navigate between tabs nicely navigate between tabs nicely navigate between tabs nicely navigate between tabs nicely navigate between tabs nicely
lvim.keys.normal_mode["L"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["H"] = ":BufferLineCyclePrev<CR>"

-- replace pyright with ruff_lsp
-- add `pyright` to `skipped_servers` list
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- remove `ruff_lsp` from `skipped_servers` list
lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
  return server ~= "ruff_lsp"
end, lvim.lsp.automatic_configuration.skipped_servers)

-- space fold / unfold
lvim.keys.normal_mode["<space>"] = "za"

-- goto next <++> and enter insert mode
lvim.keys.normal_mode["<leader>n"] = [[<cmd>/<++><enter>:let @/=""<enter>ca<]]

-- open a new terminal
lvim.keys.normal_mode["<leader>t"] = "<cmd>:!nohup st&>/dev/null&<enter><enter>"

-- vim settings
vim.env.undolevels=10000
vim.env.undodir="/tmp/tritoke/vim_undo"

-- Project specific vimrc's 
if string.find(vim.fn.expand("%:ph"), "projects/systemd_integration_test_overhaul") then
  vim.cmd("source /home/samleonard/projects/systemd_integration_test_overhaul/systemd/.vimrc")
end

