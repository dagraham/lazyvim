-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
-- Load core config
require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.commands") -- ✅ This line is required
-- init.lua
if vim.g.vscode then
  -- When in VSCode, source the legacy Vimscript config
  vim.cmd("source " .. vim.fn.stdpath("config") .. "/vim_legacy.vim")
end
