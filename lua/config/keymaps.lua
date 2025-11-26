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
-- 切换分屏
vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)
vim.keymap.set("n", "<C-v>", "<C-w>v", opts)
-- 保存
vim.keymap.set("n", "<C-g>", "<C-w>s", opts)
-- vim.keymap.set("n", "<C-w>", "<C-w>w", opts)
vim.keymap.set("n", "<C-c>", "<C-w>c", opts)
-- 调整分屏大小(暂时没找到合适的快捷键)
-- vim.keymap.set("n", "<C-i>h", "<Cmd>vertical resize -2<cr>", opts)
-- vim.keymap.set("n", "<C-i>j", "<Cmd>resize +2<cr>", opts)
-- vim.keymap.set("n", "<C-i>k", "<Cmd>resize -2<cr>", opts)
-- vim.keymap.set("n", "<C-i>l", "<Cmd>vertical resize +2<cr>", opts)

-- 粘贴已复制内容
vim.keymap.set("n", "cp", ':<C-U>:normal viwvpgv"mx<cr>', opts)
-- 快速搜索当前单词
vim.keymap.set("n", "ss", "viw*<Esc>", opts)
-- 打开终端键
vim.keymap.set("n", "ty", function()
  LazyVim.terminal()
end, { desc = "Terminal (cwd)" })
-- 打开lspsaga终端键
vim.keymap.set("n", "tt", ":Lspsaga term_toggle<CR>", opts)
-- 全局搜索文件名
-- vim.keymap.set("n", "ff", ":Telescope find_files cwd=<directory><CR>", opts)
-- 全局搜索单词
-- vim.keymap.set("n", "fw", ":Telescope grep_string<CR>", opts)
-- 全局搜索字段
-- vim.keymap.set("n", "fg", ":Telescope live_grep<CR>", opts)
-- 使用lspsaga的悬浮文档（仅在 LSP 客户端存在时）
vim.keymap.set("n", "K", function()
  local clients = vim.lsp.get_active_clients({ bufnr = 0 })
  if #clients > 0 then
    vim.cmd("Lspsaga hover_doc ++silent")
  else
    vim.lsp.buf.hover()
  end
end, { desc = "Hover Documentation" })
-- 使用lspsaga的code action
vim.keymap.set("n", "ca", "<cmd>Lspsaga code_action<CR>")
-----------------
-- Insert mode --
-----------------

vim.keymap.set("i", "jk", "<Esc>", opts)

-----------------
-- Visual mode --
-----------------

vim.keymap.set("v", "jk", "<Esc>", opts)
