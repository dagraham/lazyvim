-- ~/.config/nvim/lua/plugins/markdown.lua
-- ~/.config/nvim/lua/plugins/markdown.lua
return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-mini/mini.nvim", -- ✅ updated name
    },
    opts = {},
  },
}
