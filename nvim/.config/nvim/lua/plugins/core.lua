-- Overrides for the core plugins go here
return {
  -- Dashboard
  {
    "nvimdev/dashboard-nvim",
    opts = {
      config = {
        header = vim.split(string.rep("\n", 4) .. [[
	      ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗           Z
	      ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║       Z    
	      ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║    z       
	      ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║  z         
	      ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║            
	      ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝            

	                        [ @victorkamoto ]                           
    ]] .. "\n\n", "\n"),
      },
    },
  },
  -- Colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      transparent_background = true,
    },
  },
  -- Emoji
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      table.insert(opts.sources, { name = "emoji" })
    end,
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
    },
  },
  {
    "lewis6991/gitsigns.nvim",
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
}
