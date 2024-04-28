-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_autocmd({ "VimEnter" }, {
  callback = function()
    vim.cmd(":silent !kitty @ set-spacing padding=0")
  end,
})

vim.api.nvim_create_autocmd({ "VimLeave" }, {
  callback = function()
    vim.cmd(":silent !kitty @ set-spacing padding=default")
    -- workaround for issue: https://github.com/neovim/neovim/issues/21856
    vim.cmd("sleep 10m")
  end,
})
