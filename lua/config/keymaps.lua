-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- define common options
local opts = {
  noremap = true, -- non-recursive
  silent = true, -- do not show message
}

-----------------
-- Normal mode --
-----------------

-- Hint: see `:h vim.map.set()`
-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)
vim.keymap.set("n", "<C-v>", "<C-w>v", opts)
vim.keymap.set("n", "<C-g>", "<C-w>s", opts)
-- vim.keymap.set("n", "<C-w>", "<C-w>w", opts)

-----------------
-- Insert mode --
-----------------

vim.api.nvim_set_keymap("i", "jk", "<Esc>", { noremap = true, silent = true })

-----------------
-- Visual mode --
-----------------

vim.api.nvim_set_keymap("v", "jk", "<Esc>", { noremap = true, silent = true })
