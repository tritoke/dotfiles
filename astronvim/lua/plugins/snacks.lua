--- https://github.com/folke/snacks.nvim
---@type LazySpec
return {
  "folke/snacks.nvim",
  lazy = false,
  priority = 1000,
  ---@module 'snacks'
  ---@type snacks.plugins.Config
  opts = {
    image = {
      enabled = false,
    }
  }
}
