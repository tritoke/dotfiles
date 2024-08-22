-- vim: fdm=marker foldlevel=1
-- setup leaders
lvim.leader = "\\"
vim.g.maplocalleader = ","

-- Feature will be removed in ts_context_commentstring in the future (see https://github.com/JoosepAlviste/nvim-ts-context-commentstring/issues/82 for more info)
vim.g.skip_ts_context_commentstring_module = true

-- plugins {{{
lvim.plugins = {
  "stevearc/dressing.nvim",
  "judaew/ronny.nvim",
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle"
  },
  -- Sometimes seeing hex codes as colours is nice...
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end
  },
  -- Rust Plugins {{{
  "simrat39/rust-tools.nvim",
  {
    "saecki/crates.nvim",
    version = "v0.3.0",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("crates").setup {
        null_ls = {
          enabled = true,
          name = "crates.nvim",
        },
        popup = {
          border = "rounded",
        },
      }
    end,
  },
  {
    "j-hui/fidget.nvim",
    -- legacy tag commit ID, lazy thinks tag is deprecated and to replace with version but doesn't respect version?? 🙃
    commit = "0ba1e16d07627532b6cae915cc992ecac249fb97",
    event = "LspAttach",
    opts = {},
  },
  -- }}}
}
-- }}}

lvim.colorscheme = "ronny"

-- rust settings {{{
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "rust_analyzer", "robotframework_ls" })

local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")

local codelldb_path = mason_path .. "bin/codelldb"
local liblldb_path = mason_path .. "packages/codelldb/extension/lldb/lib/liblldb.so"

-- rust-tools setup {{{
local opts = {
  tools = {
    executor = require("rust-tools/executors").termopen, -- termopen / quickfix / toggleterm / vimux
    runnables = {
      use_telescope = true,
    },
    hover_actions = {
      border = "rounded",
    },
  },
  dap = {
    adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
  },
  server = {
    on_attach = function(client, bufnr)
      require("lvim.lsp").common_on_attach(client, bufnr)
      local rt = require "rust-tools"
      vim.keymap.set("n", "K", rt.hover_actions.hover_actions, { buffer = bufnr })
    end,

    capabilities = require("lvim.lsp").common_capabilities(),
    settings = {
      ["rust-analyzer"] = {
        cargo = {
          unsetTest = { "core", "server" },
        },
        lens = {
          enable = true,
        },
        checkOnSave = {
          enable = true,
          command = "clippy",
        },
      },
    },
  },
}
require("rust-tools").setup(opts)
-- }}}

-- Rust DAP setup {{{
lvim.builtin.dap.on_config_done = function(dap)
  dap.adapters.codelldb = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path)
  dap.configurations.rust = {
    {
      name = "Launch file",
      type = "codelldb",
      request = "launch",
      program = function()
        return vim.fn.input({"Path to executable: ", vim.fn.getcwd() .. "/", "file"})
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
    },
  }
end
-- }}}

-- rust which_key bindings {{{
lvim.builtin.which_key.mappings["C"] = {
  name = "Rust",
  r = { "<cmd>RustRunnables<Cr>", "Runnables" },
  t = { "<cmd>lua _CARGO_TEST()<cr>", "Cargo Test" },
  m = { "<cmd>RustExpandMacro<Cr>", "Expand Macro" },
  c = { "<cmd>RustOpenCargo<Cr>", "Open Cargo" },
  p = { "<cmd>RustParentModule<Cr>", "Parent Module" },
  d = { "<cmd>RustDebuggables<Cr>", "Debuggables" },
  v = { "<cmd>RustViewCrateGraph<Cr>", "View Crate Graph" },
  R = {
    "<cmd>lua require('rust-tools/workspace_refresh')._reload_workspace_from_cargo_toml()<Cr>",
    "Reload Workspace",
  },
  o = { "<cmd>RustOpenExternalDocs<Cr>", "Open External Docs" },
  y = { "<cmd>lua require'crates'.open_repository()<cr>", "[crates] open repository" },
  P = { "<cmd>lua require'crates'.show_popup()<cr>", "[crates] show popup" },
  i = { "<cmd>lua require'crates'.show_crate_popup()<cr>", "[crates] show info" },
  f = { "<cmd>lua require'crates'.show_features_popup()<cr>", "[crates] show features" },
  D = { "<cmd>lua require'crates'.show_dependencies_popup()<cr>", "[crates] show dependencies" },
}
-- }}}

-- }}}

-- formatter setup {{{

lvim.format_on_save = {
  enabled = true,
  pattern = {
    "*.rs",
    "*.py",
  }
}

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { name = "rustfmt" },
  {
    name = "black",
    args = { "--line-length=131" },
  },
}

-- }}}

-- linter setup {{{
-- Only setup linters if its for a project
if string.find(vim.fn.expand("%:ph"), "/home/samleonard/projects/") then
  local linters = require "lvim.lsp.null-ls.linters"
  linters.setup {
    { name = "ruff", },
    {
      name = "flake8",
      args = {
        "--format=pylint",
        "--max-line-length=131",
        "--extend-ignore=E203",
        "--show-source",
      },
    },
  }
end

-- }}}

-- folding setup {{{

-- use expression based folding
vim.opt.foldmethod = "expr"

-- use treesitter to determine fold expressions
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

-- default to unfolded
-- autocmd BufReadPost,FileReadPost * normal zR
vim.api.nvim_create_autocmd({"bufreadpost", "filereadpost"}, {
  pattern = "*",
  callback = function(_)
    vim.opt.foldlevel = 99
    vim.opt.foldlevelstart = 99
  end
})

-- space fold / unfold
lvim.keys.normal_mode["<space>"] = "za"

-- }}}

-- navigate between tabs nicely
lvim.keys.normal_mode["L"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["H"] = ":BufferLineCyclePrev<CR>"

-- goto next <++> and enter insert mode
lvim.keys.normal_mode["<leader>n"] = [[<cmd>/<++><enter>:let @/=""<enter>ca<]]

-- open a new terminal
lvim.keys.normal_mode["<leader>t"] = "<cmd>:!nohup kitty&>/dev/null&<enter><enter>"

-- open man pages in splits / tabs
lvim.keys.normal_mode["<leader>ms"] = [["zyiw:exe "sp man://".@z.""<enter>]]
lvim.keys.normal_mode["<leader>mv"] = [["zyiw:exe "vsp man://".@z.""<enter>]]
lvim.keys.normal_mode["<leader>me"] = [["zyiw:exe "tabe man://".@z.""<enter>]]

-- vim settings
vim.opt.undolevels = 10000
vim.opt.undodir = "/tmp/samleonard/vim_undo"
vim.opt.undofile = true

vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4

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
