return {
  {
    "jiaoshijie/undotree",
    dependencies = "nvim-lua/plenary.nvim",
    config = true,
    lazy = true,
    keys = {
      { "<leader>uu", "<cmd>lua require('undotree').toggle()<cr>", desc = "Toggle Undo Tree" },
    },
  },
}
