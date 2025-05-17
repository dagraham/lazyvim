local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },

    -- coding
    { import = "lazyvim.plugins.extras.coding.luasnip" },
    { import = "lazyvim.plugins.extras.coding.mini-surround" },

    -- editor enhancements
    { import = "lazyvim.plugins.extras.editor.aerial" },

    -- language support
    { import = "lazyvim.plugins.extras.lang.json" },
    -- NOTE TO FUTURE SELF:
    -- Do NOT enable { import = "lazyvim.plugins.extras.lang.markdown" }
    -- It conflicts with render-markdown.nvim and breaks the icons!
    -- { import = "lazyvim.plugins.extras.lang.markdown" },

    -- your added plugins
    { "ellisonleao/gruvbox.nvim" },
    {
      "LazyVim/LazyVim",
      opts = { colorscheme = "gruvbox" },
    },
    {
      "nvim-lualine/lualine.nvim",
      opts = function(_, opts)
        local gruvbox = require("lualine.themes.gruvbox")

        -- override INSERT colors
        gruvbox.insert.a.bg = "#ffff00"
        gruvbox.insert.a.fg = "#000000"
        gruvbox.insert.a.gui = "bold"

        opts.options = {
          theme = gruvbox,
          section_separators = "",
          component_separators = "",
        }

        opts.sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch" },
          lualine_c = { { "filename", path = 1 } },
          lualine_x = {},
          lualine_y = { "progress" },
          lualine_z = { "location" },
        }
      end,
    },
    { "williamboman/mason-lspconfig.nvim", version = "1.29.0" },
    { "tpope/vim-fugitive" },
    { "kdheepak/lazygit.nvim" },
    -- 🧩 Mini plugins
    {
      -- mini.files: lightweight file explorer
      "echasnovski/mini.files",
      version = false,
      keys = {
        {
          "<leader>fm",
          function()
            require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
          end,
          desc = "MiniFiles (directory of current file)",
        },
      },
      config = function()
        require("mini.files").setup()
      end,
    },
    -- {
    --   "ellisonleao/glow.nvim",
    --   cmd = { "Glow" },
    --   config = true,
    -- },
    {
      -- mini.move: intuitive line and block movement
      "echasnovski/mini.move",
      version = false,
      config = function()
        require("mini.move").setup({
          mappings = {
            left = "<M-h>",
            right = "<M-l>",
            down = "<M-j>",
            up = "<M-k>",
            line_left = "<M-h>",
            line_right = "<M-l>",
            line_down = "<M-j>",
            line_up = "<M-k>",
          },
        })
      end,
    },
    -- {
    --   "MeanderingProgrammer/render-markdown.nvim",
    --   enabled = true,
    --   dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
    --   -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    --   -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    --   ---@module 'render-markdown'
    --   ---@type render.md.UserConfig
    --   opts = {},
    --   config = function()
    --     -- require("render-markdown").setup({
    --     --   heading = {
    --     --     --   icons = { "󰼏 ", "󰎨 " },
    --     --     icons = { "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎱 ", "󰎳 " },
    --     --
    --     --     --   position = "inline",
    --     --   },
    --     --   latex = { enabled = false },
    --     -- })
    --     require("render-markdown").setup({
    --       heading = {
    --         icons = { "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎱 ", "󰎳 " },
    --       },
    --       latex = { enabled = false },
    --       callouts = {
    --         NOTE = { icon = "", hl = "DiagnosticInfo" },
    --         WARNING = { icon = "", hl = "DiagnosticWarn" },
    --         TIP = { icon = "💡", hl = "DiagnosticHint" },
    --         IMPORTANT = { icon = "", hl = "DiagnosticError" },
    --         INFO = { icon = "", hl = "DiagnosticHint" },
    --       },
    --     })
    --   end,
    -- },
    {
      "MeanderingProgrammer/render-markdown.nvim",
      ft = "markdown", -- <-- this ensures it loads only for markdown files
      dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
      -- dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-web-devicons" },
      opts = {
        heading = {
          icons = { "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎱 ", "󰎳 " },
        },
        latex = { enabled = false },
        callouts = {
          NOTE = { icon = "", hl = "DiagnosticInfo" },
          WARNING = { icon = "", hl = "DiagnosticWarn" },
          TIP = { icon = "💡", hl = "DiagnosticHint" },
        },
      },
      config = function(_, opts)
        require("render-markdown").setup(opts)
      end,
    },
    {
      "gaoDean/autolist.nvim",
      ft = { "markdown", "text", "tex", "plaintex", "norg" },
      config = function()
        require("autolist").setup()
        vim.keymap.set("i", "<tab>", "<cmd>AutolistTab<cr>")
        vim.keymap.set("i", "<s-tab>", "<cmd>AutolistShiftTab<cr>")
        vim.keymap.set("i", "<CR>", "<CR><cmd>AutolistNewBullet<cr>")
        vim.keymap.set("n", "o", "o<cmd>AutolistNewBullet<cr>")
        vim.keymap.set("n", "O", "O<cmd>AutolistNewBulletBefore<cr>")
        vim.keymap.set("n", "<C-x>", "<cmd>AutolistToggleCheckbox<cr>")
        vim.keymap.set("n", "<C-r>", "<cmd>AutolistRecalculate<cr>")
        vim.keymap.set("n", ">>", ">><cmd>AutolistRecalculate<cr>")
        vim.keymap.set("n", "<<", "<<<cmd>AutolistRecalculate<cr>")
        vim.keymap.set("n", "dd", "dd<cmd>AutolistRecalculate<cr>")
        vim.keymap.set("v", "d", "d<cmd>AutolistRecalculate<cr>")
      end,
    },
    -- {
    --   "nvim-treesitter/nvim-treesitter",
    --   opts = {
    --     ensure_installed = {
    --       "markdown",
    --       "markdown_inline",
    --       "python", -- make sure this is included
    --     },
    --     highlight = {
    --       enable = true,
    --       additional_vim_regex_highlighting = false,
    --     },
    --   },
    -- },
    {
      "nvim-treesitter/nvim-treesitter",
      dependencies = {
        "nvim-treesitter/playground",
      },
      opts = {
        ensure_installed = {
          "markdown",
          "markdown_inline",
          "python",
        },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        playground = {
          enable = true,
        },
      },
    },
    -- {
    --   "nvim-treesitter/playground",
    --   cmd = "TSPlaygroundToggle",
    --   config = true,
    -- },

    {
      "okuuva/auto-save.nvim",
      version = "^1.0.0", -- see https://devhints.io/semver, alternatively use '*' to use the latest tagged release
      cmd = "ASToggle", -- optional for lazy loading on command
      event = { "InsertLeave", "TextChanged" }, -- optional for lazy loading on trigger events
      opts = {
        enabled = true, -- start auto-save when the plugin is loaded (i.e. when your package manager loads it)
        trigger_events = { -- See :h events
          immediate_save = { "BufLeave", "FocusLost", "QuitPre", "VimSuspend" }, -- vim events that trigger an immediate save
          defer_save = { "InsertLeave", "TextChanged" }, -- vim events that trigger a deferred save (saves after `debounce_delay`)
          cancel_deferred_save = { "InsertEnter" }, -- vim events that cancel a pending deferred save
        },
        -- function that takes the buffer handle and determines whether to save the current buffer or not
        -- return true: if buffer is ok to be saved
        -- return false: if it's not ok to be saved
        -- if set to `nil` then no specific condition is applied
        condition = nil,
        write_all_buffers = false, -- write all buffers when the current one meets `condition`
        noautocmd = false, -- do not execute autocmds when saving
        lockmarks = false, -- lock marks when saving, see `:h lockmarks` for more details
        debounce_delay = 1000, -- delay after which a pending save is executed
        -- log debug messages to 'auto-save.log' file in neovim cache directory, set to `true` to enable
        debug = false,

        -- your config goes here
        -- or just leave it empty :)
      },
    },
  },

  defaults = { lazy = false, version = false },
  install = { colorscheme = { "gruvbox" } },
  checker = { enabled = true, notify = false },
  performance = {
    rtp = { disabled_plugins = { "gzip", "tarPlugin", "tohtml", "tutor", "zipPlugin" } },
  },
})
