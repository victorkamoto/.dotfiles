return {
  {
    "pmizio/typescript-tools.nvim",
    lazy = true,
    ft = { "typescript", "javascript", "javascriptreact", "typescriptreact" },
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {
      settings = {
        separate_diagnostic_server = false,
      },
    },
  },
}
