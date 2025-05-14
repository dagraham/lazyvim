vim.api.nvim_create_autocmd("BufWinEnter", {
  once = true,
  callback = function()
    -- Disable Lualine for this buffer
    vim.b.lualine_disable = true

    -- Disable the statusline manually
    vim.opt_local.statusline = ""

    -- Optionally: disable tabline if shown
    vim.opt.showtabline = 0

    -- Set up winbar highlights
    vim.api.nvim_set_hl(0, "WinBarA", { fg = "#ffffff", bg = "#5f87af", bold = true })
    vim.api.nvim_set_hl(0, "WinBarB", { fg = "#dddddd", bg = "#303030" })

    -- Define readable mode mapping
    local mode_map = {
      ["n"] = "NORMAL",
      ["i"] = "INSERT",
      ["v"] = "VISUAL",
      ["V"] = "V·LINE",
      ["c"] = "COMMAND",
      ["R"] = "REPLACE",
      ["t"] = "TERMINAL",
      ["s"] = "SELECT",
      ["S"] = "S·LINE",
    }

    -- Mode function must be global to be used in winbar
    _G.get_mode = function()
      local code = vim.api.nvim_get_mode().mode
      return mode_map[code] or code
    end

    -- Set the winbar
    vim.opt_local.winbar = "%#WinBarA# %{v:lua.get_mode()} %*%#WinBarB# %t %*"
  end,
})
vim.opt.number = false
vim.opt.relativenumber = false
vim.opt.signcolumn = "no"
vim.opt.textwidth = 30
vim.opt.linebreak = false
vim.opt.wrap = false
vim.opt.colorcolumn = ""
