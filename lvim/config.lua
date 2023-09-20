-- setup leaders
lvim.leader = "\\"
vim.g.maplocalleader = ","

-- plugins
lvim.plugins = {
  "stevearc/dressing.nvim",
  "judaew/ronny.nvim",
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle"
  },
}

lvim.colorscheme = "ronny"

-- remove `json` from `skipped_servers` list
lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(
  function(server)
    return server ~= "json"
  end,
  lvim.lsp.automatic_configuration.skipped_servers
)

-- space fold / unfold
lvim.keys.normal_mode["<space>"] = "za"

-- navigate between tabs nicely navigate between tabs nicely navigate between tabs nicely navigate between tabs nicely navigate between tabs nicely navigate between tabs nicely navigate between tabs nicely navigate between tabs nicely navigate between tabs nicely navigate between tabs nicely
lvim.keys.normal_mode["L"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["H"] = ":BufferLineCyclePrev<CR>"

-- goto next <++> and enter insert mode
lvim.keys.normal_mode["<leader>n"] = [[<cmd>/<++><enter>:let @/=""<enter>ca<]]

-- open a new terminal
lvim.keys.normal_mode["<leader>t"] = "<cmd>:!nohup st&>/dev/null&<enter><enter>"

-- open man pages in splits / tabs
lvim.keys.normal_mode["<leader>ms"] = [["zyiw:exe "sp man://".@z.""<enter>]]
lvim.keys.normal_mode["<leader>mv"] = [["zyiw:exe "vsp man://".@z.""<enter>]]
lvim.keys.normal_mode["<leader>me"] = [["zyiw:exe "tabe man://".@z.""<enter>]]

-- vim settings
vim.opt.undolevels = 10000
vim.opt.undodir = "/tmp/tritoke/vim_undo"
vim.opt.undofile = true

-- jump to previous location in file
local jtp_group = vim.api.nvim_create_augroup('jump_to_previous', { clear = true })
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
  pattern = "*",
  group = jtp_group,
  callback = function(_)
    local last_line = vim.fn.line([['"]])
    if last_line > 1 and last_line <= vim.fn.line("$") then
      vim.fn.cursor({last_line, 0})
    end
  end
})

-- Project specific vimrc's 
if string.find(vim.fn.expand("%:ph"), "projects/systemd_integration_test_overhaul") then
  vim.cmd.source("/home/samleonard/projects/systemd_integration_test_overhaul/systemd/.vimrc")
end

