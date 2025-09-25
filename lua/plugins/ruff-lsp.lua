-- ~/.config/nvim/lua/plugins/ruff-lsp.lua
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ruff_lsp = {},
      },
    },
  },
}
