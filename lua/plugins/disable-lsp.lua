-- ~/.config/nvim/lua/plugins/disable-lsp.lua
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = false,
        pylsp = false,
      },
    },
  },
}
