-- vim.api.nvim_create_user_command("Doit", function(opts)
--   local arg = opts.args
--   if arg == "" then
--     print("Usage: Doit +/-N<command> (e.g. +3d)")
--     return
--   end
--
--   local cmd = ":" .. "." .. arg
--   vim.cmd("normal! m'") -- save cursor position to mark '
--   vim.cmd(cmd)
--   vim.cmd("normal! `'")
-- end, { nargs = 1 })
-- Lowercase "doit" fallback as Lua function for user convenience
-- _G.doit = function(arg)
--   vim.cmd("Doit " .. arg)
-- end
require("config.colors")

vim.api.nvim_create_user_command("AddProject", function(opts)
  local project_name = opts.fargs[1]
  local project_path = opts.fargs[2]
  if not project_name or not project_path then
    vim.notify("Usage: :AddProject <name> <directory>", vim.log.levels.ERROR)
    return
  end

  -- Expand tilde manually since jobstart doesn't use shell expansion
  project_path = project_path:gsub("^~", os.getenv("HOME"))

  local ok = vim.fn.executable("add_project.sh")
  if ok == 0 then
    vim.notify("add_project.sh not found in $PATH", vim.log.levels.ERROR)
    return
  end

  -- Run in background to avoid blocking
  vim.fn.jobstart({ "add_project.sh", project_name, project_path }, {
    detach = true,
    on_exit = function(_, code)
      if code ~= 0 then
        vim.notify("add_project.sh exited with code " .. code, vim.log.levels.WARN)
      end
    end,
  })
end, {
  nargs = "+",
  complete = "file",
  desc = "Add a new tmux project tab",
})
-- Make gf work on markdown links like [text](file.md)
vim.opt_local.isfname:append("@-@") -- allow @ and - in filenames
vim.opt_local.includeexpr = "substitute(v:fname, '\\v^.+%((.+)%)$', '\\1', '')"

-- if vim.g.todo_view == 1 then
if vim.g.minimal_view == 1 then
  vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
      vim.api.nvim_create_autocmd("ModeChanged", {
        buffer = 0,
        callback = function()
          -- Trigger get_mode() and refresh winbar
          vim.opt_local.winbar = vim.opt_local.winbar:get()
        end,
      })
      vim.defer_fn(function()
        local ok, lualine = pcall(require, "lualine")
        if ok then
          -- print("Calling lualine.hide()")
          lualine.hide({ place = { "statusline" }, unhide = false })
        end

        vim.opt.laststatus = 0
        vim.cmd("redrawstatus")

        -- Winbar, highlights, etc.
        vim.api.nvim_set_hl(0, "WinBarA", { fg = "#ffffff", bg = "#5f87af", bold = true })
        vim.api.nvim_set_hl(0, "WinBarB", { fg = "#dddddd", bg = "#303030" })

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

        local color_map = {
          ["n"] = { fg = "#ffffff", bg = "#005f87" },
          ["i"] = { fg = "#000000", bg = "#ffff00" },
          ["v"] = { fg = "#000000", bg = "#ff8c00" },
          ["V"] = { fg = "#000000", bg = "#ffaa00" },
          ["c"] = { fg = "#ffffff", bg = "#870000" },
          ["R"] = { fg = "#ffffff", bg = "#af00ff" },
          ["t"] = { fg = "#ffffff", bg = "#5f00af" },
          ["s"] = { fg = "#000000", bg = "#ffd75f" },
          ["S"] = { fg = "#000000", bg = "#ffd787" },
        }

        _G.get_mode = function()
          local mode = vim.api.nvim_get_mode().mode
          local name = mode_map[mode] or mode
          local colors = color_map[mode]

          if colors then
            vim.api.nvim_set_hl(0, "WinBarMode", {
              fg = colors.fg,
              bg = colors.bg,
              bold = true,
            })
          end

          return name
        end

        -- Winbar with dynamic mode color group
        vim.opt_local.winbar = "%#WinBarMode# %{v:lua.get_mode()} %*%#WinBarB# %t %m %*"

        -- View options
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.signcolumn = "no"
        -- vim.opt_local.textwidth = 30
        -- vim.opt_local.linebreak = false
        -- vim.opt_local.wrap = false
        vim.opt_local.colorcolumn = ""
      end, 100) -- wait 100ms for safety
    end,
  })
end
