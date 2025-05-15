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
    {
      "MeanderingProgrammer/render-markdown.nvim",
      dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
      -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
      -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
      ---@module 'render-markdown'
      ---@type render.md.UserConfig
      opts = {},
      config = function()
        require("render-markdown").setup({
          heading = {
            --   icons = { "󰼏 ", "󰎨 " },
            icons = { "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎱 ", "󰎳 " },

            --   position = "inline",
          },
          latex = { enabled = false },
          callout = {
            note = {
              raw = "[!NOTE]",
              rendered = "󰋽 Note",
              highlight = "RenderMarkdownInfo",
              category = "github",
            },
            tip = {
              raw = "[!TIP]",
              rendered = "󰌶 Tip",
              highlight = "RenderMarkdownSuccess",
              category = "github",
            },
            important = {
              raw = "[!IMPORTANT]",
              rendered = "󰅾 Important",
              highlight = "RenderMarkdownHint",
              category = "github",
            },
            warning = {
              raw = "[!WARNING]",
              rendered = "󰀪 Warning",
              highlight = "RenderMarkdownWarn",
              category = "github",
            },
            caution = {
              raw = "[!CAUTION]",
              rendered = "󰳦 Caution",
              highlight = "RenderMarkdownError",
              category = "github",
            },
            abstract = {
              raw = "[!ABSTRACT]",
              rendered = "󰨸 Abstract",
              highlight = "RenderMarkdownInfo",
              category = "obsidian",
            },
            summary = {
              raw = "[!SUMMARY]",
              rendered = "󰨸 Summary",
              highlight = "RenderMarkdownInfo",
              category = "obsidian",
            },
            tldr = {
              raw = "[!TLDR]",
              rendered = "󰨸 Tldr",
              highlight = "RenderMarkdownInfo",
              category = "obsidian",
            },
            info = {
              raw = "[!INFO]",
              rendered = "󰋽 Info",
              highlight = "RenderMarkdownInfo",
              category = "obsidian",
            },
            todo = {
              raw = "[!TODO]",
              rendered = "󰗡 Todo",
              highlight = "RenderMarkdownInfo",
              category = "obsidian",
            },
            hint = {
              raw = "[!HINT]",
              rendered = "󰌶 Hint",
              highlight = "RenderMarkdownSuccess",
              category = "obsidian",
            },
            success = {
              raw = "[!SUCCESS]",
              rendered = "󰄬 Success",
              highlight = "RenderMarkdownSuccess",
              category = "obsidian",
            },
            check = {
              raw = "[!CHECK]",
              rendered = "󰄬 Check",
              highlight = "RenderMarkdownSuccess",
              category = "obsidian",
            },
            done = {
              raw = "[!DONE]",
              rendered = "󰄬 Done",
              highlight = "RenderMarkdownSuccess",
              category = "obsidian",
            },
            question = {
              raw = "[!QUESTION]",
              rendered = "󰘥 Question",
              highlight = "RenderMarkdownWarn",
              category = "obsidian",
            },
            help = {
              raw = "[!HELP]",
              rendered = "󰘥 Help",
              highlight = "RenderMarkdownWarn",
              category = "obsidian",
            },
            faq = {
              raw = "[!FAQ]",
              rendered = "󰘥 Faq",
              highlight = "RenderMarkdownWarn",
              category = "obsidian",
            },
            attention = {
              raw = "[!ATTENTION]",
              rendered = "󰀪 Attention",
              highlight = "RenderMarkdownWarn",
              category = "obsidian",
            },
            failure = {
              raw = "[!FAILURE]",
              rendered = "󰅖 Failure",
              highlight = "RenderMarkdownError",
              category = "obsidian",
            },
            fail = {
              raw = "[!FAIL]",
              rendered = "󰅖 Fail",
              highlight = "RenderMarkdownError",
              category = "obsidian",
            },
            missing = {
              raw = "[!MISSING]",
              rendered = "󰅖 Missing",
              highlight = "RenderMarkdownError",
              category = "obsidian",
            },
            danger = {
              raw = "[!DANGER]",
              rendered = "󱐌 Danger",
              highlight = "RenderMarkdownError",
              category = "obsidian",
            },
            error = {
              raw = "[!ERROR]",
              rendered = "󱐌 Error",
              highlight = "RenderMarkdownError",
              category = "obsidian",
            },
            bug = {
              raw = "[!BUG]",
              rendered = "󰨰 Bug",
              highlight = "RenderMarkdownError",
              category = "obsidian",
            },
            example = {
              raw = "[!EXAMPLE]",
              rendered = "󰉹 Example",
              highlight = "RenderMarkdownHint",
              category = "obsidian",
            },
            quote = {
              raw = "[!QUOTE]",
              rendered = "󱆨 Quote",
              highlight = "RenderMarkdownQuote",
              category = "obsidian",
            },
            cite = {
              raw = "[!CITE]",
              rendered = "󱆨 Cite",
              highlight = "RenderMarkdownQuote",
              category = "obsidian",
            },
          },
        })
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
    {
      "nvim-treesitter/nvim-treesitter",
      opts = {
        ensure_installed = {
          "markdown",
          "markdown_inline",
          "python", -- make sure this is included
        },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = { "markdown" },
        },
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
