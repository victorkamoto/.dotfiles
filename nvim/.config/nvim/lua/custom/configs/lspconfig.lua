local base = require("plugins.configs.lspconfig")
local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")
local util = require "lspconfig/util"


local servers = { "gopls", "clangd", "tsserver", "tailwindcss", "eslint" }

for _, lsp in ipairs(servers) do
  if lsp == "gopls" then
    lspconfig[lsp].setup {
      on_attach = on_attach,
      capabilities = capabilities,
      cmd = { "gopls" },
      filetypes = { "go", "gomod", "gowork", "gotmpl" },
      root_dir = util.root_pattern("go.work", "go.mod", ".git"),
      settings = {
        gopls = {
          completeUnimported = true,
          usePlaceholders = true,
          staticcheck = true,
          analyses = {
            unusedParams = true,
            shadow = true,
          },
        },
      },
    }
  elseif lsp == "clangd" then
    lspconfig[lsp].setup {
      on_attach = function(client, bufnr)
        client.server_capabilities.signatureHelpProvider = false
        on_attach(client, bufnr)
      end
    }
  else
    lspconfig[lsp].setup {
      on_attach = on_attach,
      capabilities = capabilities,
    }
  end
end
