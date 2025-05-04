return {
  { import = "lazyvim.plugins" }, -- required core plugins
  { import = "lazyvim.plugins.extras.coding.luasnip" }, -- snippets

  -- ✅ Add gruvbox.nvim plugin
  { "ellisonleao/gruvbox.nvim" },

  -- ✅ Configure LazyVim to use gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },
}
