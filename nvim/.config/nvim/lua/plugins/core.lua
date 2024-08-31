-- Overrides for the core plugins go here
return {
  -- Dashboard
  {
    "nvimdev/dashboard-nvim",
    opts = {
      config = {
        header = vim.split(string.rep("\n", 9) .. [[]] .. "\n", "\n"),
      },
    },
  },
  -- Colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = function()
        -- empty func to override default behaviour
      end,
    },
  },
  {
    "sainnhe/gruvbox-material",
    config = function()
      -- opts
      vim.g.gruvbox_material_background = "hard"
      vim.g.gruvbox_material_better_performance = 1
      -- set
      vim.cmd.colorscheme("gruvbox-material")
      -- tweaks
      vim.api.nvim_set_hl(0, "FloatBorder", { link = "Normal" })
      vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })
    end,
  },
  {
    "folke/tokyonight.nvim",
    enabled = false,
  },
  {
    "catppuccin/nvim",
    enabled = false,
    name = "catppuccin",
  },
  -- Neotree
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
  -- Git signs
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
  -- lsp clangd
  {
    "neovim/nvim-lspconfig",
    opts = {
      setup = {
        clangd = function(_, opts)
          opts.capabilities.offsetEncoding = { "utf-16" }
        end,
      },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = "hrsh7th/cmp-emoji",
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      -- Emoji
      table.insert(opts.sources, { name = "emoji" })

      local cmp = require("cmp")
      -- Borders
      opts.window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      }
    end,
  },
  -- treesitter context
  {
    "nvim-treesitter/nvim-treesitter-context",
    opts = { mode = "cursor", max_lines = 0 },
  },
  -- Mason borders
  {
    "williamboman/mason.nvim",
    opts = {
      ui = {
        border = "rounded",
      },
    },
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
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        float = {
          border = "rounded",
        },
      },
    },
  },
}
