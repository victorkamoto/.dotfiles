local plugins = {
  -- Mason - Package manager
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- Go
        "gopls",
        -- C++
        "clangd",
        "clang-format",
        -- Debugger for C++ & Rust
        "codelldb",
        -- JS/TS
        "typescript-language-server",
        "tailwindcss-language-server",
        "eslint-lsp",
        "prettierd",
        -- Rust
        "rust-analyzer",
        -- Python: lsp, formatter & linter, static analysis
        "pyright",
        "ruff-lsp",
        "black",
        "mypy",
        "debugpy",
      }
    }
  },
  -- Treesitter - Syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function()
      local opts = require "plugins.configs.treesitter"
      opts.ensure_installed = {
        "lua",
        "go",
        "cpp",
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "rust",
        "python",
      }
      opts.refactor = {
        highlight_definitions = { enable = true },
        smart_rename = {
          enable = true,
          keymaps = {
            smart_rename = "grr",
          },
        },
      }
      return opts
    end,
  },
  -- Treesitter context
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufRead",
  },
  -- Treesitter refactor
  {
    "nvim-treesitter/nvim-treesitter-refactor",
    event = "BufRead",
  },
  --  LSP Config - Language Server Protocol
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end
  },
  -- None-ls - LSP Wrapper
  {
    "nvimtools/none-ls.nvim",
    event = "VeryLazy",
    ft = { "go", "cpp", "js", "ts", "jsx", "tsx", "py" },
    opts = function()
      return require("custom.configs.null-ls")
    end,
  },
  -- -- Rust formatting via rust.vim
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
    end
  },
  -- Rust tools via rustacean.vim
  {
    "mrcjkb/rustaceanvim",
    version = "^4",
    ft = { "rust" },
    dependencies = "neovim/nvim-lspconfig",
    config = function()
      require "custom.configs.rustaceanvim-cfg"
    end
  },
  -- Cargo crates
  {
    "saecki/crates.nvim",
    ft = { "rust", "toml" },
    config = function(_, opts)
      local crates = require("crates")
      crates.setup(opts)
      crates.show()
    end
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function()
      local M = require "plugins.configs.cmp"
      table.insert(M.sources, { name = "crates" })
      return M
    end,
  },
  -- Autotag - Auto close and auto rename tags
  {
    "windwp/nvim-ts-autotag",
    ft = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
    },
    config = function()
      require("nvim-ts-autotag").setup()
    end
  },
  -- Gopher - Go utilities
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    config = function(_, opts)
      require("gopher").setup(opts)
      require("core.utils").load_mappings("gopher")
    end,
    build = function()
      vim.cmd [[silent! GoInstallDeps]]
    end,
  },
  -- DAP - Debug Adapter Protocol
  {
    "mfussenegger/nvim-dap",
    init = function(_, _)
      require("core.utils").load_mappings("dap")
    end
  },
  -- DAP UI
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = {
      "mfussenegger/nvim-dap"
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },
  -- DAP Virtual Text
  {
    "theHamsta/nvim-dap-virtual-text",
    lazy = false,
    config = function()
      require("nvim-dap-virtual-text").setup()
    end
  },
  -- DAP: C++
  {
    "jay-babu/mason-nvim-dap.nvim",
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    opts = {
      automatic_setup = true,
      handlers = {}
    },
  },
  -- DAP Go
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    dependencies = "mfussenegger/nvim-dap",
    config = function(_, opts)
      require("dap-go").setup(opts)
      require("core.utils").load_mappings("dap_go")
    end
  },
  -- DAP Python
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
    },
    config = function()
      local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
      require("dap-python").setup(path)
      require("core.utils").load_mappings("dap_python")
    end
  },
  -- GitHub Copilot
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "VeryLazy",
    opts = function()
      return require "custom.configs.copilot-cfg"
    end,
    config = function(_, opts)
      require("copilot").setup(opts)
    end
  },
  -- Tmux Navigator
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },
  -- Vim Fugitive
  {
    "tpope/vim-fugitive",
    event = "BufRead",
  },
}
return plugins
