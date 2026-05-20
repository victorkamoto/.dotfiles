return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "kanagawa-dragon",
    },
  },
  {
    "folke/tokyonight.nvim",
    enabled = false,
  },
  {
    "rebelot/kanagawa.nvim",
    opts = {
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = "none",
            },
          },
        },
      },
      overrides = function(colors)
        local theme = colors.theme
        return {
          -- Diagnostic tinting
          DiagnosticVirtualTextHint = { fg = theme.diag.hint, bg = theme.diag.bg_hint },
          DiagnosticVirtualTextInfo = { fg = theme.diag.info, bg = theme.diag.bg_dim },
          DiagnosticVirtualTextWarn = { fg = theme.diag.warn, bg = theme.diag.bg_warn },
          DiagnosticVirtualTextError = { fg = theme.diag.error, bg = theme.diag.bg_error },
          -- Dark completion popup
          Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
          PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
          PmenuSbar = { bg = theme.ui.bg_m1 },
          PmenuThumb = { bg = theme.ui.bg_p2 },
          -- Flat UI for floats
          NormalFloat = { bg = "none" },
          FloatBorder = { bg = "none" },
          FloatTitle = { bg = "none" },
          NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
          LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
          MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
          NoiceCmdlinePopupBorder = { fg = theme.ui.bg_p1, bg = "none" },
          -- fzf-lua
          FzfLuaNormal = { fg = theme.ui.fg, bg = theme.ui.bg_m1 },
          FzfLuaBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
          FzfLuaTitle = { fg = theme.ui.special, bg = theme.ui.bg_m1, bold = true },
          FzfLuaPreviewNormal = { fg = theme.ui.fg, bg = theme.ui.bg_dim },
          FzfLuaPreviewBorder = { fg = theme.ui.bg_dim, bg = theme.ui.bg_dim },
          FzfLuaPreviewTitle = { fg = theme.ui.special, bg = theme.ui.bg_dim, bold = true },
          FzfLuaCursorLine = { bg = theme.ui.bg_p2 },
          FzfLuaBackdrop = { bg = "none" },
          FzfLuaScrollBorderBackCompat = { fg = theme.ui.fg, bg = theme.ui.bg_m1 },
          -- Snacks
          SnacksNotifierBorderInfo = { fg = theme.ui.bg_p1 },
          SnacksNotifierBorderDebug = { fg = theme.ui.bg_p1 },
          SnacksNotifierBorderTrace = { fg = theme.ui.bg_p1 },
        }
      end,
    },
  },
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          header = string.rep("\n", 9) .. [[]] .. "\n",
        },
      },
      zen = {
        toggles = {
          dim = true,
        },
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        theme = "kanagawa",
      },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          visible = true,
        },
      },
      window = {
        position = "right",
      },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
      require("scrollbar.handlers.gitsigns").setup()
    end,
    opts = {
      current_line_blame = true,
    },
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = "hrsh7th/cmp-emoji",
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      table.insert(opts.sources, { name = "emoji" })

      local cmp = require("cmp")
      opts.window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      }
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    opts = { mode = "cursor", max_lines = 0 },
  },
  {
    "folke/noice.nvim",
    opts = {
      presets = {
        lsp_doc_border = true,
      },
    },
  },
  {
    "snacks.nvim",
    opts = {
      scroll = { enabled = false },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        float = {
          border = "rounded",
        },
      },
    },
  },
  {
    "akinsho/bufferline.nvim",
    enabled = false,
  },
}
