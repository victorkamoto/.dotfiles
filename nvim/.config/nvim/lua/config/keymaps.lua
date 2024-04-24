-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local Util = require("lazyvim.util")
local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

-- oil.nvim
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- carbon-now.nvim
vim.keymap.set("v", "<leader>cn", ":CarbonNow<CR>", { silent = true })

--lazydocker
map("n", "<leader>gd", function()
  Util.terminal({ "lazydocker", "-f", Util.root() .. "docker-compose.yml" }, { cwd = Util.root(), esc_esc = false })
end, { desc = "LazyDocker (root dir)" })
