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
        "js-debug-adapter",
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
  -- Treesitter
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
    event = "VeryLazy",
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
    end
  },
  -- Rust tools via rustacean.vim
  {
    "mrcjkb/rustaceanvim",
    event = "VeryLazy",
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
    event = "VeryLazy",
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
    event = "VeryLazy",
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
    event = "VeryLazy",
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
    event = "VeryLazy",
    opts = function()
      local dap = require("dap")
      if not dap.adapters["pwa-node"] then
        require("dap").adapters["pwa-node"] = {
          type = "server",
          host = "localhost",
          port = "${port}",
          executable = {
            command = "node",
            args = {
              require("mason-registry").get_package("js-debug-adapter"):get_install_path()
              .. "/js-debug/src/dapDebugServer.js",
              "${port}",
            },
          },
        }
      end
      for _, language in ipairs({ "javascript" }) do
        if not dap.configurations[language] then
          dap.configurations[language] = {
            {
              type = 'pwa-node',
              request = 'launch',
              name = 'Launch Current File (pwa-node)',
              cwd = vim.fn.getcwd(),
              args = { '${file}' },
              sourceMaps = true,
              protocol = 'inspector',
            },
            {
              type = 'pwa-node',
              request = 'launch',
              name = 'Launch Test Current File (pwa-node with jest)',
              cwd = vim.fn.getcwd(),
              runtimeArgs = { '${workspaceFolder}/node_modules/.bin/jest' },
              runtimeExecutable = 'node',
              args = { '${file}', '--coverage', 'false' },
              rootPath = '${workspaceFolder}',
              sourceMaps = true,
              console = 'integratedTerminal',
              internalConsoleOptions = 'neverOpen',
              skipFiles = { '<node_internals>/**', 'node_modules/**' },
            },
            {
              type = 'pwa-node',
              request = 'launch',
              name = 'Launch Test Current File (pwa-node with vitest)',
              cwd = vim.fn.getcwd(),
              program = '${workspaceFolder}/node_modules/vitest/vitest.mjs',
              args = { '--inspect-brk', '--threads', 'false', 'run', '${file}' },
              autoAttachChildProcesses = true,
              smartStep = true,
              console = 'integratedTerminal',
              skipFiles = { '<node_internals>/**', 'node_modules/**' },
            },
            {
              type = 'pwa-node',
              request = 'attach',
              name = 'Attach Program (pwa-node)',
              cwd = vim.fn.getcwd(),
              processId = require('dap.utils').pick_process,
              skipFiles = { '<node_internals>/**' },
            },
          }
        end
      end
    end,
    config = function()
      require("core.utils").load_mappings("dap")
    end,
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
        dapui.open({ reset = true })
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
    event = "VeryLazy",
    dependencies = "mfussenegger/nvim-dap",
    config = function()
      require("nvim-dap-virtual-text").setup()
    end
  },
  -- Mason - DAP bridge
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
    event = "VeryLazy",
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
    event = "VeryLazy",
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
    event = "VeryLazy"
  },
  -- Neogit
  {
    "NeogitOrg/neogit",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
    },
    config = true
  },
  {
    'sindrets/diffview.nvim',
    event = "VeryLazy",
  },
  -- Minimap
  {
    'gorbit99/codewindow.nvim',
    event = "BufRead",
    config = function()
      local codewindow = require('codewindow')
      codewindow.setup({
        window_border = 'none',
      })
      codewindow.apply_default_keybinds()
    end,
  },
  -- Undo tree
  {
    "mbbill/undotree",
    event = "BufRead",
  },
  -- Override and enable nvimtree git integration
  {
    "nvim-tree/nvim-tree.lua",
    opts = function()
      local opts = require "plugins.configs.nvimtree"
      opts.git = {
        enable = true,
        ignore = true,
      }
      opts.renderer = {
        highlight_git = true,
        icons = {
          show = {
            git = true,
          }
        }
      }
      return opts
    end,
  },
}
return plugins
