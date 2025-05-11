-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
-- Load core config
require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.commands") -- ✅ This line is required
