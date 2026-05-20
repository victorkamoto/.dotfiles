local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

map("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

map("n", "<leader>gd", function()
  Snacks.lazydocker()
end, { desc = "LazyDocker" })

map("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", { desc = "Open diagnostic float" })

map("n", "<leader>z", function()
  Snacks.zen()
end, { desc = "Toggle Zen Mode" })
map("n", "<leader>Z", function()
  Snacks.zen.zoom()
end, { desc = "Toggle Zoom Mode" })
