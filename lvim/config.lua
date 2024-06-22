-- vim: fdm=marker
-- setup leaders
lvim.leader = "\\"
vim.g.maplocalleader = ","

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
  -- Rust Plugins (mostly bastardised from LazyVim:/lura/lazyvim/plugins/extra/lang/rust.lua) {{{
  {
    "saecki/crates.nvim",
    version = "v0.4.0",
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
  -- Setup rust tooling
  {
    "mrcjkb/rustaceanvim",
    version = "^4", -- Recommended
    ft = { "rust" },
    opts = {
      tools = {
        executor = require("rustaceanvim/executors").termopen, -- termopen / quickfix / toggleterm / vimux
        runnables = {
          use_telescope = true,
        },
        hover_actions = {
          border = "rounded",
        },
        on_initialized = function()
          vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "CursorHold", "InsertLeave" }, {
            pattern = { "*.rs" },
            callback = function()
              local _, _ = pcall(vim.lsp.codelens.refresh)
            end,
          })
        end,
      },
      server = {
        default_settings = {
          ["rust-analyzer"] = {
            cargo = {
              allFeatures = true,
              loadOutDirsFromCheck = true,
              buildScripts = {
                enable = true,
              },
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
    },
    config = function(_, opts)
      vim.g.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim or {}, opts or {})
      if vim.fn.executable("rust-analyzer") == 0 then
        LazyVim.error(
          "**rust-analyzer** not found in PATH, please install it.\nhttps://rust-analyzer.github.io/",
          { title = "rustaceanvim" }
        )
      end
    end,
  },
  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = {},
  },
  -- }}}
}
-- }}}

lvim.colorscheme = "ronny"

-- formatter setup {{{

lvim.format_on_save = {
  enabled = true,
  pattern = { "*.rs", "*.py" }
}

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { name = "rustfmt" },
  { name = "black" },
}

-- }}}

-- linter setup {{{

local linters = require "lvim.lsp.null-ls.linters"
linters.setup { { command = "ruff", filetypes = { "python" } } }

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

-- navigate between tabs nicely navigate between tabs nicely navigate between tabs nicely navigate between tabs nicely navigate between tabs nicely navigate between tabs nicely navigate between tabs nicely navigate between tabs nicely navigate between tabs nicely navigate between tabs nicely
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
vim.opt.undodir = "/tmp/tritoke/vim_undo"
vim.opt.undofile = true
