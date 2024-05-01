return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      require("lspconfig.configs").vtsls = require("vtsls").lspconfig

      opts.servers.vtsls = {
        keys = {
          {
            "<leader>co",
            function()
              require("vtsls").commands.organize_imports(0)
            end,
            desc = "Organize Imports(vtsls)",
          },
          {
            "<leader>cM",
            function()
              require("vtsls").commands.add_missing_imports(0)
            end,
            desc = "Add missing imports(vtsls)",
          },
          {
            "<leader>cD",
            function()
              require("vtsls").commands.fix_all(0)
            end,
            desc = "Fix all diagnostics(vtsls)",
          },
          {
            "<leader>cL",
            function()
              require("vtsls").commands.open_tsserver_log()
            end,
            desc = "Open Vtsls Log(vtsls)",
          },
          {
            "<leader>cR",
            function()
              require("vtsls").commands.rename_file(0)
            end,
            desc = "Rename File(vtsls)",
          },
          {
            "<leader>cu",
            function()
              require("vtsls").commands.file_references(0)
            end,
            desc = "Show File Uses/Refs(vtsls)",
          },
          {
            "<leader>cP",
            function()
              require("vtsls").commands.goto_project_config(0)
            end,
            desc = "Open Project Config(vtsls)",
          },
        },
        settings = {
          vtsls = {
            experimental = {
              completion = {
                enableServerSideFuzzyMatch = true,
              },
            },
          },
          javascript = {
            format = {
              indentSize = vim.o.shiftwidth,
              convertTabsToSpaces = vim.o.expandtab,
              tabSize = vim.o.tabstop,
            },
            -- enables inline hints
            inlayHints = {
              parameterNames = { enabled = "literals" },
              parameterTypes = { enabled = true },
              variableTypes = { enabled = true },
              propertyDeclarationTypes = { enabled = true },
              functionLikeReturnTypes = { enabled = true },
              enumMemberValues = { enabled = true },
            },
            -- otherwise it would ask every time if you want to update imports, which is a bit annoying
            updateImportsOnFileMove = {
              enabled = "always",
            },
            -- cool feature, but increases ram usage
            -- referencesCodeLens = {
            --   enabled = true,
            --   showOnAllFunctions = true,
            -- },
          },
          typescript = {
            format = {
              indentSize = vim.o.shiftwidth,
              convertTabsToSpaces = vim.o.expandtab,
              tabSize = vim.o.tabstop,
            },
            updateImportsOnFileMove = {
              enabled = "always",
            },
            inlayHints = {
              parameterNames = { enabled = "literals" },
              parameterTypes = { enabled = true },
              variableTypes = { enabled = true },
              propertyDeclarationTypes = { enabled = true },
              functionLikeReturnTypes = { enabled = true },
              enumMemberValues = { enabled = true },
            },
            -- enables project wide error reporting similar to vscode
            -- tsserver = {
            --   experimental = {
            --     enableProjectDiagnostics = true,
            --   },
            -- },
          },
        },
      }
    end,
    dependencies = {
      {
        "yioneko/nvim-vtsls",
        handlers = {},
      },
    },
  },
}
