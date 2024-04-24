return {
  {
    "tamton-aquib/duck.nvim",
    event = "VeryLazy",
    config = function()
      vim.keymap.set("n", "<leader>dd", function()
        require("duck").hatch("🦆", 10)
      end, {
        desc = "hatch duck",
      }) -- A pretty fast duck
      vim.keymap.set("n", "<leader>dc", function()
        require("duck").hatch("🐈", 0.75)
      end, {
        desc = "hatch cat",
      }) -- Quite a mellow cat
      vim.keymap.set("n", "<leader>da", function()
        require("duck").cook_all()
      end, {
        desc = "cook all",
      })
    end,
  },
}
